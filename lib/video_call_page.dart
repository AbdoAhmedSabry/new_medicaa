import 'dart:async';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

// ====== إعدادات Agora (للتجربة) ======
const String kAgoraAppId = '0e9a7dcb27dd488f816c9dd4476feb33';

// ولّد التوكن من Agora Console > Generate Temp Token لنفس القناة (kTestChannel)
const String kAgoraTempToken =
    '007eJxTYCiq4Hh417WvnZX16Le7+pHSj//+XnLTa+LJ5vPui/+mTxNXYDBItUw0T0lOMjJPSTGxsEizMDRLtgQyTczN0lKTjI09O/ZlNQQyMvR+cmFghEIQn40hNzUlMzmRgQEASl4i2w==';

// الـ Temp Token بيشتغل مع قناة واحدة بس، فللتجربة استخدم قناة ثابتة.
const bool kUseTestChannel = true;
const String kTestChannel = 'medica';

// اسم الكولكشن والحالة اللي بتتحط لما المكالمة تخلص
const String kAppointmentsCollection = 'appointments';
const String kEndedStatus = 'completed';
// =====================================

class VideoCallPage extends StatefulWidget {
  /// لازم يكون هو الـ Document ID بتاع الموعد في Firestore
  final String callID;
  final String userID;
  final String userName;

  const VideoCallPage({
    super.key,
    required this.callID,
    required this.userID,
    required this.userName,
  });

  @override
  State<VideoCallPage> createState() => _VideoCallPageState();
}

class _VideoCallPageState extends State<VideoCallPage> {
  late final RtcEngine _engine;
  bool _localUserJoined = false;
  int? _remoteUid;
  bool _closing = false;
  bool _firstSnapshotSkipped = false;
  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? _statusSub;

  String get _channelId => kUseTestChannel ? kTestChannel : widget.callID;

  DocumentReference<Map<String, dynamic>> get _apptRef => FirebaseFirestore
      .instance
      .collection(kAppointmentsCollection)
      .doc(widget.callID);

  @override
  void initState() {
    super.initState();
    _engine = createAgoraRtcEngine();
    _listenToCallStatus();
    initAgora();
  }

  /// لو الطرف التاني قفل، الحالة في Firestore بتتغير فنقفل إحنا كمان
  void _listenToCallStatus() {
    _statusSub = _apptRef.snapshots().listen((snap) {
      // أول snapshot بيرجّع الحالة الحالية (calling / in_call)، نتجاهله
      if (!_firstSnapshotSkipped) {
        _firstSnapshotSkipped = true;
        return;
      }
      final status = snap.data()?['status'];
      if (status == kEndedStatus) {
        _endCall(updateStatus: false);
      }
    }, onError: (e) => debugPrint('Status listener error: $e'));
  }

  Future<void> initAgora() async {
    if (!kIsWeb) {
      await [Permission.camera, Permission.microphone].request();
    }

    await _engine.initialize(const RtcEngineContext(appId: kAgoraAppId));

    _engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          debugPrint('Joined channel: ${connection.channelId}');
          if (mounted) setState(() => _localUserJoined = true);
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          if (mounted) setState(() => _remoteUid = remoteUid);
        },
        onUserOffline:
            (
              RtcConnection connection,
              int remoteUid,
              UserOfflineReasonType reason,
            ) {
              if (mounted) setState(() => _remoteUid = null);
              // الطرف التاني خرج من القناة => نقفل المكالمة
              _endCall(updateStatus: true);
            },
        onError: (ErrorCodeType err, String msg) {
          debugPrint('Agora error: $err - $msg');
        },
      ),
    );

    await _engine.enableVideo();
    await _engine.startPreview();

    await _engine.joinChannel(
      token: kAgoraTempToken,
      channelId: _channelId,
      uid: 0,
      options: const ChannelMediaOptions(
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
        channelProfile: ChannelProfileType.channelProfileCommunication,
        publishCameraTrack: true,
        publishMicrophoneTrack: true,
        autoSubscribeAudio: true,
        autoSubscribeVideo: true,
      ),
    );
  }

  /// بتقفل المكالمة عندنا، وتغيّر الحالة في Firestore عشان الطرف التاني يقفل
  Future<void> _endCall({required bool updateStatus}) async {
    if (_closing) return;
    _closing = true;

    if (updateStatus) {
      try {
        await _apptRef.update({'status': kEndedStatus});
      } catch (e) {
        debugPrint('End call update error: $e');
      }
    }

    if (mounted) Navigator.of(context).pop();
  }

  Future<void> _disposeAgora() async {
    try {
      await _engine.leaveChannel();
      await _engine.release();
    } catch (e) {
      debugPrint('Dispose error: $e');
    }
  }

  @override
  void dispose() {
    _statusSub?.cancel();
    _disposeAgora();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      // زرار الرجوع في الموبايل يقفل المكالمة صح برضو
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) _endCall(updateStatus: true);
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Stack(
            children: [
              // الطرف التاني (الخلفية الكبيرة)
              Center(
                child: _remoteUid != null
                    ? AgoraVideoView(
                        controller: VideoViewController.remote(
                          rtcEngine: _engine,
                          canvas: VideoCanvas(uid: _remoteUid),
                          connection: RtcConnection(channelId: _channelId),
                        ),
                      )
                    : const Text(
                        'في انتظار الطرف الآخر...',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
              ),

              // كاميرتك (المربع الصغير)
              Positioned(
                top: 20,
                right: 20,
                child: SizedBox(
                  width: 120,
                  height: 160,
                  child: _localUserJoined
                      ? AgoraVideoView(
                          controller: VideoViewController(
                            rtcEngine: _engine,
                            canvas: const VideoCanvas(uid: 0),
                          ),
                        )
                      : const Center(
                          child: CircularProgressIndicator(color: Colors.white),
                        ),
                ),
              ),

              // زرار قفل المكالمة
              Positioned(
                bottom: 40,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.red,
                      radius: 30,
                      child: IconButton(
                        icon: const Icon(
                          Icons.call_end,
                          color: Colors.white,
                          size: 30,
                        ),
                        onPressed: () => _endCall(updateStatus: true),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
