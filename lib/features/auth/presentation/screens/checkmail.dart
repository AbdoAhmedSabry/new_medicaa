import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:new_medicaa/config/const/routes.dart';
import 'package:new_medicaa/config/theme/app_colors.dart';
import 'package:new_medicaa/config/theme/app_text_styles.dart';
import 'package:new_medicaa/config/theme/app_theme.dart';
import 'package:new_medicaa/features/auth/data/models/user_model.dart';
import 'package:new_medicaa/features/auth/presentation/manager/auth_cubit.dart';
import 'package:new_medicaa/features/auth/presentation/manager/authstate.dart';

class CheckEmailScreen extends StatefulWidget {
  final UserModel userModel;
  const CheckEmailScreen({super.key, required this.userModel});

  @override
  State<CheckEmailScreen> createState() => _CheckEmailScreenState();
}

class _CheckEmailScreenState extends State<CheckEmailScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 10), (_) {
      context.read<AuthCubit>().checkEmailVerification(widget.userModel);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);

    return Scaffold(
      backgroundColor: AppColors.softWhiteBg,
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            _timer?.cancel();
            Navigator.pushReplacementNamed(
              context,
              Routes.patientDataScreen,
              arguments: widget.userModel,
            );
          }
        },
        child: Column(
          children: [
            SizedBox(
              height: 220.h,
              width: double.infinity,
              child: Image.asset(
                'assets/images/varification.png',
                fit: BoxFit.cover,
              ),
            ),

            Expanded(
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: r.maxContentWidth),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: r.horizontalPadding),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center, 
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Lottie.asset(
                          'assets/lottie/Open Mail.json',
                          height: 140.h, 
                          fit: BoxFit.contain,
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          'check_your_email'.tr(),
                          style: AppTextStyles.font26LexendBold.copyWith(
                            color: AppColors.textNavy,
                          ),
                        ),
                        SizedBox(height: 10.h),

                        Text(
                          'verification_link_sent'.tr(),
                          textAlign: TextAlign.center,
                          style: AppTextStyles.font14InterRegular.copyWith(
                            color: AppColors.textGrey,
                            height: 1.5,
                          ),
                        ),
                        SizedBox(height: 18.h),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 20.w,
                              height: 1.5.h,
                              color: AppColors.blueTint100,
                            ),
                            SizedBox(width: 6.w),
                            Container(
                              width: 6.r,
                              height: 6.r,
                              decoration: const BoxDecoration(
                                color: AppColors.accentBlueBright,
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: 6.w),
                            Container(
                              width: 20.w,
                              height: 1.5.h,
                              color: AppColors.blueTint100,
                            ),
                          ],
                        ),
                        SizedBox(height: 18.h),

                        SizedBox(
                          height: 32.r,
                          width: 32.r,
                          child: const CircularProgressIndicator(
                            color: AppColors.primaryColor,
                            strokeWidth: 3.5,
                          ),
                        ),
                        SizedBox(height: 10.h),

                        Text(
                          'waiting_for_verification'.tr(),
                          style: AppTextStyles.font12InterRegular.copyWith(
                            color: AppColors.textGrey,
                          ),
                        ),
                        SizedBox(height: 24.h),

                        _ActionTile(
                          icon: Icons.mail_outline_rounded,
                          title: 'didnt_receive_email'.tr(),
                          actionText: 'resend_email'.tr(),
                          onTap: () {},
                        ),
                        SizedBox(height: 12.h),

                        _ActionTile(
                          icon: Icons.arrow_back_rounded,
                          title: 'wrong_email'.tr(),
                          actionText: 'change_email'.tr(),
                          onTap: () {
                            _timer?.cancel();
                            Navigator.pushReplacementNamed(
                              context,
                              Routes.loginScreen,
                            );
                          },
                        ),
                        SizedBox(height: 20.h), 
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class _ActionTile extends StatelessWidget {
  final IconData    icon;
  final String      title;
  final String      actionText;
  final VoidCallback onTap;

  const _ActionTile({
    required this.icon,
    required this.title,
    required this.actionText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.whiteSemiTransparent,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: AppColors.lightBlueTint,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(icon, color: AppColors.accentBlueBright, size: 20.r),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              title,
              style: AppTextStyles.font13InterRegular.copyWith(
                color: AppColors.nearBlack,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  actionText,
                  style: AppTextStyles.font13InterSemiBold.copyWith(
                    color: AppColors.accentBlueBright,
                  ),
                ),
                SizedBox(width: 4.w),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 12.r,
                  color: AppColors.accentBlueBright,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}