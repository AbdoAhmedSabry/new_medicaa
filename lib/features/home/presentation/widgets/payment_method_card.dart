import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_medicaa/config/theme/app_colors.dart';
import 'package:new_medicaa/config/theme/app_text_styles.dart';

class PaymentMethodCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const PaymentMethodCard({
    super.key,
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          padding: EdgeInsets.symmetric(vertical: 16.h),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.accentBlue.withValues(alpha: 0.1)
                : AppColors.greyShade200,
            border: Border.all(
              color: isSelected ? AppColors.accentBlue : Colors.transparent,
              width: 2.w,
            ),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                color: isSelected ? AppColors.accentBlue : AppColors.greyShade700,
                size: 28.r,
              ),
              SizedBox(height: 8.h),
              Text(
                title,
                style: AppTextStyles.font14Regular.copyWith(
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? AppColors.accentBlue : AppColors.textDark,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
