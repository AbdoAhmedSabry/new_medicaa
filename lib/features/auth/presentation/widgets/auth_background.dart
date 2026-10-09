import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthBackgroundWrapper extends StatelessWidget {
  final Widget child;

  const AuthBackgroundWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7FAFF),
      body: Stack(
        children: [
          
          Container(
            width: double.infinity,
            height: 360.h,
            decoration: const BoxDecoration(
              //
              image: DecorationImage(
                image: AssetImage('assets/images/background.png'),
                fit: BoxFit.fill,
              ),
              //
            ),
          ),

          
          Positioned(
            top: -70.h,
            left: -80.w,
            child: Container(
              width: 210.w,
              height: 210.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(.06),
              ),
            ),
          ),

          
          Positioned(
            top: 80.h,
            right: -90.w,
            child: Container(
              width: 190.w,
              height: 190.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(.05),
              ),
            ),
          ),

        
          Positioned(
            top: 90.h,
            right: 35.w,
            child: Icon(
              Icons.add,
              color: Colors.white.withOpacity(.08),
              size: 70.sp,
            ),
          ),

          Positioned(
            top: 180.h,
            left: 25.w,
            child: Icon(
              Icons.add,
              color: Colors.white.withOpacity(.06),
              size: 50.sp,
            ),
          ),

          // =========================================
         
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                 
                  SizedBox(height: 35.h),

                  Image.asset(
                    'assets/images/logoo.png',
                    width: 150.w,
                    height: 120.h,
                    fit: BoxFit.contain,
                  ),

                  
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(top: 35.h),
                    padding: EdgeInsets.only(
                      left: 24.w,
                      right: 24.w,
                      top: 30.h,
                      bottom: 30.h,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xffFDFEFF),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(55.r),
                        topRight: Radius.circular(55.r),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.08),
                          blurRadius: 25,
                          offset: const Offset(0, -5),
                        ),
                      ],
                    ),
                    child: child,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
