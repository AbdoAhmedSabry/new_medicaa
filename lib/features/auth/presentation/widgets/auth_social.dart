import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_medicaa/config/theme/app_colors.dart';
import 'package:new_medicaa/config/theme/app_text_styles.dart';

class CustomSocialButton extends StatelessWidget {
  final VoidCallback facebooktap;
  final VoidCallback googletap;
  final bool isFacebookLoading;
  final bool isGoogleLoading;

  const CustomSocialButton({
    super.key,
    required this.facebooktap,
    required this.googletap,
    this.isFacebookLoading = false, 
    this.isGoogleLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(
            "OR",
            style: AppTextStyles.font22BoldAveria.copyWith(
              color: AppColors.hintGrey,
            ),
          ),
        ),
        SizedBox(height: 19.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: isGoogleLoading || isFacebookLoading ? null : googletap,
              child: CircleAvatar(
                radius: 27.r,
                backgroundColor: AppColors.fieldBg,
                child: CircleAvatar(
                  radius: 26.r,
                  backgroundColor: Colors.white,
                  child: isGoogleLoading
                      ? SizedBox(
                          width: 20.w,
                          height: 20.h,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColors.primaryColor,
                          ),
                        )
                      : Image.asset(
                          'assets/images/google_logo.png',
                          width: 24.w,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.g_mobiledata, size: 30),
                        ),
                ),
              ),
            ),

            GestureDetector(
              onTap: isFacebookLoading || isGoogleLoading ? null : facebooktap,
              child: CircleAvatar(
                radius: 27.r,
                backgroundColor: AppColors.fieldBg,
                child: CircleAvatar(
                  radius: 26.r,
                  backgroundColor: Colors.white,
                  child: isFacebookLoading
                      ? SizedBox(
                          width: 20.w,
                          height: 20.h,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColors.primaryColor,
                          ),
                        )
                      : Icon(
                          Icons.facebook,
                          color: AppColors.primaryColor,
                          size: 28.sp,
                        ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
