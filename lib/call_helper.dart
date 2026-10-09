import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_medicaa/video_call_page.dart';
// تأكد من استدعاء مسار ملف CacheHelper و VideoCallPage الصحيح هنا
// import 'cache_helper.dart';
// import 'video_call_page.dart';

class CallHelper {
  // المفتاح اللي بيسمح للرنة تظهر فوق أي شاشة
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  static bool _isCallDialogShowing = false;

  static void listenToIncomingCalls(String userId) {
    FirebaseFirestore.instance
        .collection('appointments')
        .where('patientId', isEqualTo: userId)
        .where('status', isEqualTo: 'calling')
        .snapshots()
        .listen((snapshot) {
          if (snapshot.docs.isNotEmpty) {
            if (_isCallDialogShowing) return;

            final callId = snapshot.docs.first.id;
            final currentContext = navigatorKey.currentContext;

            if (currentContext != null) {
              _isCallDialogShowing = true;
              showDialog(
                context: currentContext,
                barrierDismissible: false,
                builder: (context) => AlertDialog(
                  title: const Text('مكالمة واردة'),
                  content: const Text('الطبيب يتصل بك الآن للكشف.'),
                  actions: [
                    TextButton(
                      onPressed: () async {
                        await FirebaseFirestore.instance
                            .collection('appointments')
                            .doc(callId)
                            .update({'status': 'rejected'});
                        _isCallDialogShowing = false;
                        if (context.mounted) Navigator.pop(context);
                      },
                      child: const Text(
                        'رفض',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await FirebaseFirestore.instance
                            .collection('appointments')
                            .doc(callId)
                            .update({'status': 'in_progress'});
                        _isCallDialogShowing = false;

                        if (context.mounted) {
                          Navigator.pop(context); // قفل النافذة
                          Navigator.push(
                            // فتح غرفة المكالمة
                            context,
                            MaterialPageRoute(
                              builder: (context) => VideoCallPage(
                                callID: callId,
                                userID: userId,
                                // لو CacheHelper مش مقروء هنا، ممكن تبعت الاسم في بارامتر الدالة
                                userName: 'Patient',
                              ),
                            ),
                          );
                        }
                      },
                      child: const Text('رد'),
                    ),
                  ],
                ),
              );
            }
          }
        });
  }
}
