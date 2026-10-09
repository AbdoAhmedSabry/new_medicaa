import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_medicaa/config/theme/app_colors.dart';
import 'package:new_medicaa/features/home/presentation/widgets/stat_item_widget.dart';

class StatsRowWidget extends StatelessWidget {
  const StatsRowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          StatItemWidget(
            icon: Icons.work_outline,
            value: '10+',
            label: 'years_experience'.tr(),
          ),
          StatItemWidget(
            icon: Icons.people_outline,
            value: '500+',
            label: 'patients_treated'.tr(),
          ),
          StatItemWidget(
            icon: Icons.star_border,
            value: '4.9',
            label: 'patient_rating'.tr(),
          ),
        ],
      ),
    );
  }
}
