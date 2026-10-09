import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_medicaa/config/const/routes.dart';
import 'package:new_medicaa/config/theme/app_colors.dart';
import 'package:new_medicaa/config/theme/app_text_styles.dart';
import 'package:new_medicaa/config/theme/app_theme.dart';
import 'package:new_medicaa/features/auth/presentation/widgets/curved_header.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.bgGradient),
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: r.maxContentWidth),
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: r.horizontalPadding,
                  vertical: 16.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: r.isTablet ? 20.h : 10.h),

                    const Center(child: MediCareBrand(iconSize: 200)),
                    SizedBox(height: r.isTablet ? 40.h : 32.h),

                    Text(
                      'choose_language'.tr(),
                      textAlign: TextAlign.center,
                      style: AppTextStyles.font26LexendBold.copyWith(
                        color: AppColors.textDark,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'select_preferred_language'.tr(),
                      textAlign: TextAlign.center,
                      style: AppTextStyles.font14InterRegular.copyWith(
                        color: AppColors.textGrey,
                      ),
                    ),
                    SizedBox(height: 40.h),

                    ElevatedButton(
                      onPressed: () async {
                        await context.setLocale(const Locale('en'));
                        if (context.mounted) {
                          Navigator.pushReplacementNamed(
                            context,
                            Routes.loginScreen,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Text(
                        'english_language'.tr(),
                        style: AppTextStyles.font14InterSemiBold.copyWith(
                          color: Colors.white,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),

                    OutlinedButton(
                      onPressed: () async {
                        await context.setLocale(const Locale('ar'));
                        if (context.mounted) {
                          Navigator.pushReplacementNamed(
                            context,
                            Routes.loginScreen,
                          );
                        }
                      },
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        side: const BorderSide(
                          color: AppColors.primaryColor,
                          width: 1.5,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Text(
                        'arabic_language'.tr(),
                        style: AppTextStyles.font14InterSemiBold.copyWith(
                          color: AppColors.primaryColor,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
