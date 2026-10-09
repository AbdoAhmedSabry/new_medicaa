import 'package:flutter/material.dart';
import 'package:new_medicaa/call_helper.dart';
import 'package:new_medicaa/config/cachehelper.dart';
import 'package:new_medicaa/config/const/routes.dart';
import 'package:new_medicaa/config/theme/app_colors.dart';

import 'package:new_medicaa/features/auth/presentation/widgets/curved_header.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();

    Timer(const Duration(seconds: 3), () {
      _checkUserAndNavigate();
    });
  }

  void _checkUserAndNavigate() {
    String? userId = CacheHelper.getData(key: 'userId');
    String? userName = CacheHelper.getData(key: 'userName');

    if (userId != null && userName != null) {
      // 👈 بنشغل الاستماع للمكالمات بالطريقة الصح
      CallHelper.listenToIncomingCalls(userId);

      Navigator.pushReplacementNamed(context, Routes.homeScreen);
    } else {
      Navigator.pushReplacementNamed(context, Routes.languageScreen);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(gradient: AppColors.bgGradient),
        child: FadeTransition(
          opacity: _animation,
          child: const Center(child: MediCareBrand(iconSize: 60)),
        ),
      ),
    );
  }
}
