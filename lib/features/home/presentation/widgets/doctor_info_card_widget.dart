import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_medicaa/config/theme/app_colors.dart';
import 'package:new_medicaa/config/theme/app_text_styles.dart';
import 'package:new_medicaa/features/home/domain/entities/home_entity.dart';

class DoctorInfoCardWidget extends StatelessWidget {
  final DoctorEntity doctor;

  const DoctorInfoCardWidget({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.fieldIconBg,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: Container(
              width: 100.w,
              height: 120.h,
              color: AppColors.fieldBg,
              child: Image.network(doctor.image),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doctor.getLocalizedName(context),
                  style: AppTextStyles.font22Bold,
                ),
                SizedBox(height: 4.h),
                Text(
                  doctor.getLocalizedSpecialty(context),
                  style: AppTextStyles.font14SemiBold.copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
                SizedBox(height: 12.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.star, color: AppColors.starAmber, size: 16.r),
                      SizedBox(width: 4.w),
                      Text('4.9', style: AppTextStyles.font14SemiBold),
                      SizedBox(width: 4.w),
                      Text(
                        '(250 Reviews)',
                        style: AppTextStyles.font12Regular.copyWith(
                          color: AppColors.textGrey,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.location_on,
                        color: AppColors.primaryColor,
                        size: 16.r,
                      ),
                      SizedBox(width: 4.w),
                      Text('2.5 km Away', style: AppTextStyles.font12Regular),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
