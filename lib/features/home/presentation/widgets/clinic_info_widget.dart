import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_medicaa/config/theme/app_colors.dart';
import 'package:new_medicaa/config/theme/app_text_styles.dart';

class ClinicInfoWidget extends StatelessWidget {
  final String clinicName;
  final String clinicAddress;
  final String phone;
  final String workingHours;
  final String workingDays;
  final String email;
  const ClinicInfoWidget({
    super.key,
    required this.clinicName,
    required this.clinicAddress,
    required this.phone,
    required this.workingHours,
    required this.workingDays,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.location_on,
                color: AppColors.primaryColor,
                size: 20.r,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(clinicName, style: AppTextStyles.font14SemiBold),
                    SizedBox(height: 4.h),
                    Text(
                      clinicAddress,
                      style: AppTextStyles.font12Regular.copyWith(
                        color: AppColors.textGrey,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.phone, color: AppColors.primaryColor, size: 20.r),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  phone,
                  style: AppTextStyles.font12Regular.copyWith(
                    color: AppColors.textGrey,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            child: const Divider(),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.access_time,
                color: AppColors.primaryColor,
                size: 20.r,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(workingHours, style: AppTextStyles.font13SemiBold),
                    SizedBox(height: 4.h),
                    Text(
                      workingDays,
                      style: AppTextStyles.font12Regular.copyWith(
                        color: AppColors.textGrey,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.mail_outline,
                color: AppColors.primaryColor,
                size: 20.r,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  email,
                  style: AppTextStyles.font12Regular.copyWith(
                    color: AppColors.textGrey,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
