import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_medicaa/config/theme/app_colors.dart';
import 'package:new_medicaa/config/theme/app_text_styles.dart';

class StatItemWidget extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const StatItemWidget({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: AppColors.primaryColor.withValues(alpha: 0.1),
          radius: 24.r,
          child: Icon(icon, color: AppColors.primaryColor, size: 22.r),
        ),
        SizedBox(height: 8.h),
        Text(
          value,
          style: AppTextStyles.font16SemiBold,
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          textAlign: TextAlign.center,
          style: AppTextStyles.font12Regular.copyWith(
            color: AppColors.textGrey,
          ),
        ),
      ],
    );
  }
}
