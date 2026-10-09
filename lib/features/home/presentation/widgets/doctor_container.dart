import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_medicaa/config/const/routes.dart';
import 'package:new_medicaa/config/theme/app_colors.dart';
import 'package:new_medicaa/config/theme/app_text_styles.dart';
import 'package:new_medicaa/features/home/domain/entities/home_entity.dart';

class Doctorcontainer extends StatelessWidget {
  const Doctorcontainer({super.key, required this.doctor});
  final DoctorEntity doctor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.doctorProfileScreen,
          arguments: doctor,
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.nearBlack.withValues(alpha: 0.04),
              blurRadius: 8.r,
              spreadRadius: 1,
              offset: Offset(0, 3.h),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Container(
                width: 85.w,
                height: 85.w,
                color: AppColors.imagePlaceholderBg,
              child: Image.network(
                  doctor.image,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.person, size: 40, color: Colors.grey),
                ),
              ),
            ),
            SizedBox(width: 14.w),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                     
                      Text(doctor.getLocalizedName(context), style: AppTextStyles.font18SemiBold),
                      Icon(
                        Icons.favorite_border_rounded,
                        color: AppColors.primaryColor,
                        size: 22.w,
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),

                  Text(
                    doctor.getLocalizedSpecialty(context),
                    style: AppTextStyles.font12Regular.copyWith(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8.h),

                  Row(
                    children: [
                      Icon(
                        Icons.star_rounded,
                        color: AppColors.starAmber,
                        size: 18.w,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        doctor.averageRating.toString(),
                        style: AppTextStyles.font14SemiBold,
                      ),
                      SizedBox(width: 4.w),
                   
                      Text(
                        'patients_count'.tr(namedArgs: {'count': doctor.patientsTreated.toString()}),
                        style: AppTextStyles.font12Regular.copyWith(
                          color: AppColors.greyShade600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_rounded,
                            color: AppColors.greyShade400,
                            size: 16.w,
                          ),
                          SizedBox(width: 2.w),
                          Text(
                            'distance_away'.tr(),
                            style: AppTextStyles.font12Regular.copyWith(
                              color: AppColors.greyShade600,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 32.h,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                          child: Text(
                            'book'.tr(),
                            style: AppTextStyles.font12SemiBold.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
