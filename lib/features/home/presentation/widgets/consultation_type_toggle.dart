import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_medicaa/config/theme/app_colors.dart';
import 'package:new_medicaa/config/theme/app_text_styles.dart';

class ConsultationTypeToggle extends StatelessWidget {
  final bool isOnline;
  final ValueChanged<bool> onChanged;

  const ConsultationTypeToggle({
    super.key,
    required this.isOnline,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      decoration: BoxDecoration(
        color: AppColors.greyShade200,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => onChanged(false),
              child: Container(
                decoration: BoxDecoration(
                  color: !isOnline ? AppColors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(10.r),
                  border: !isOnline
                      ? Border.all(color: AppColors.greyShade300)
                      : null,
                  boxShadow: !isOnline
                      ? [
                          BoxShadow(
                            color: AppColors.nearBlack.withValues(alpha: 0.05),
                            blurRadius: 4.r,
                          ),
                        ]
                      : [],
                ),
                alignment: Alignment.center,
                child: Text(
                  'in_clinic'.tr(),
                  style: AppTextStyles.font14Regular.copyWith(
                    color: !isOnline
                        ? AppColors.deepBlue
                        : AppColors.greyShade600,
                    fontWeight: !isOnline ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => onChanged(true),
              child: Container(
                decoration: BoxDecoration(
                  color: isOnline ? AppColors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(10.r),
                  border: isOnline
                      ? Border.all(color: AppColors.greyShade300)
                      : null,
                  boxShadow: isOnline
                      ? [
                          BoxShadow(
                            color: AppColors.nearBlack.withValues(alpha: 0.05),
                            blurRadius: 4.r,
                          ),
                        ]
                      : [],
                ),
                alignment: Alignment.center,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'online_telehealth'.tr(),
                        style: AppTextStyles.font14Regular.copyWith(
                          color: isOnline
                              ? AppColors.deepBlue
                              : AppColors.greyShade600,
                          fontWeight: isOnline
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Icon(
                        Icons.video_camera_front,
                        size: 18.r,
                        color: isOnline
                            ? AppColors.deepBlue
                            : AppColors.greyShade600,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
