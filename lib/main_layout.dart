import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_medicaa/core/di/injection_container.dart';
import 'package:new_medicaa/features/home/presentation/manager/appointment_cubit.dart';
import 'package:new_medicaa/features/home/presentation/pages/home_page.dart';
import 'package:new_medicaa/features/home/presentation/pages/user_appointment.dart';
import 'package:new_medicaa/features/patient_profile/presentation/manager/patient_cubit.dart';
import 'package:new_medicaa/features/patient_profile/presentation/screen/profile_patient_screen.dart';
import 'package:new_medicaa/video_call_page.dart';

class MainLayoutScreen extends StatefulWidget {
  const MainLayoutScreen({super.key});

  @override
  State<MainLayoutScreen> createState() => _MainLayoutScreenState();
}

class _MainLayoutScreenState extends State<MainLayoutScreen> {
  int _currentIndex = 0;

  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? _callSubscription;
  bool _inCall = false;

  final List<Widget> _screens = [
    const HomePage(),
    BlocProvider(
      create: (context) => sl<AppointmentCubit>()..getMyAppointment(),
      child: const UserAppointmentPage(),
    ),
    BlocProvider(
      create: (context) => sl<PatientCubit>()..getPatientData(),
      child: const ProfilePatientscreen(),
    ),
  ];

  @override
  void initState() {
    super.initState();
    listenToIncomingCalls();
  }

  void listenToIncomingCalls() {
    final patientId = FirebaseAuth.instance.currentUser?.uid;
    debugPrint('Listening for calls, patientId = $patientId');
    if (patientId == null) return;

    _callSubscription = FirebaseFirestore.instance
        .collection('appointments')
        .where('patientId', isEqualTo: patientId)
        .where('status', isEqualTo: 'calling')
        .snapshots()
        .listen((snapshot) async {
          if (snapshot.docs.isEmpty || _inCall || !mounted) return;

          _inCall = true;
          final doc = snapshot.docs.first;
          debugPrint('Incoming call for appointment ${doc.id}');

          try {
            // نغيّر الحالة عشان الشاشة ما تفتحش أكتر من مرة
            await doc.reference.update({'status': 'in_call'});

            if (!mounted) return;
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => VideoCallPage(
                  callID: doc.id,
                  userID: patientId,
                  userName: 'Patient',
                ),
              ),
            );

            // لما المكالمة تخلص
            await doc.reference.update({'status': 'completed'});
          } catch (e) {
            debugPrint('Call flow error: $e');
          } finally {
            _inCall = false;
          }
        }, onError: (e) => debugPrint('Call listener error: $e'));
  }

  @override
  void dispose() {
    _callSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, 0.05),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            ),
          );
        },
        child: SizedBox(
          key: ValueKey<int>(_currentIndex),
          child: _screens[_currentIndex],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          backgroundColor: Colors.white,
          selectedItemColor: const Color(0xFF00668C),
          unselectedItemColor: Colors.grey.shade400,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 12,
          ),
          items: [
            BottomNavigationBarItem(
              icon: const Padding(
                padding: EdgeInsets.only(bottom: 4.0),
                child: Icon(Icons.home_outlined),
              ),
              activeIcon: const Padding(
                padding: EdgeInsets.only(bottom: 4.0),
                child: Icon(Icons.home),
              ),
              label: 'home'.tr(),
            ),
            BottomNavigationBarItem(
              icon: const Padding(
                padding: EdgeInsets.only(bottom: 4.0),
                child: Icon(Icons.calendar_today_outlined),
              ),
              activeIcon: const Padding(
                padding: EdgeInsets.only(bottom: 4.0),
                child: Icon(Icons.calendar_today),
              ),
              label: 'appointments'.tr(),
            ),
            BottomNavigationBarItem(
              icon: const Padding(
                padding: EdgeInsets.only(bottom: 4.0),
                child: Icon(Icons.person_outline),
              ),
              activeIcon: const Padding(
                padding: EdgeInsets.only(bottom: 4.0),
                child: Icon(Icons.person),
              ),
              label: 'profile'.tr(),
            ),
          ],
        ),
      ),
    );
  }
}
