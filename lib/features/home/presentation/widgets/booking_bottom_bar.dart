import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_medicaa/config/theme/app_colors.dart';
import 'package:new_medicaa/config/theme/app_text_styles.dart';

class BookingCheckoutBottomBar extends StatelessWidget {
  final double price;
  final String selectedDateTime;
  final VoidCallback onConfirmPressed;

  const BookingCheckoutBottomBar({
    super.key,
    required this.price,
    required this.selectedDateTime,
    required this.onConfirmPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.nearBlack.withValues(alpha: 0.05),
            offset: Offset(0, -4.h),
            blurRadius: 10.r,
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'booking_summary'.tr(),
                        style: AppTextStyles.font16SemiBold,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        selectedDateTime,
                        style: AppTextStyles.font13Regular.copyWith(
                          color: AppColors.greyShade600,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        children: [
                          _buildPaymentIcon('VISA'),
                          _buildPaymentIcon('MC'),
                          _buildPaymentIcon('Apple'),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '\$$price',
                        style: AppTextStyles.font22Bold.copyWith(
                          color: AppColors.deepBlue,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      ElevatedButton(
                        onPressed: onConfirmPressed,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.deepBlue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 24.w,
                            vertical: 12.h,
                          ),
                        ),
                        child: Text(
                          'confirm_and_pay'.tr(),
                          style: AppTextStyles.font14SemiBold.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentIcon(String label) {
    return Container(
      margin: EdgeInsetsDirectional.only(end: 6.w),
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.greyShade300),
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Text(
        label,
        style: AppTextStyles.font12SemiBold.copyWith(
          color: AppColors.greyShade700,
          fontSize: 10.sp,
        ),
      ),
    );
  }
}
