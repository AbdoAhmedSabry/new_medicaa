import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_medicaa/config/theme/app_colors.dart';
import 'package:new_medicaa/config/theme/app_text_styles.dart';

class ScheduleListWidget extends StatelessWidget {
  final List<Map<String, String>> schedule;
  final int selectedIndex;
  final ValueChanged<int> onDateSelected;

  const ScheduleListWidget({
    super.key,
    required this.schedule,
    required this.selectedIndex,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: schedule.length,
        itemBuilder: (context, index) {
          bool isSelected = selectedIndex == index;
          return GestureDetector(
            onTap: () => onDateSelected(index),
            child: Container(
              width: 65.w,
              margin: EdgeInsets.only(right: 12.w),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primaryColor : AppColors.white,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color: isSelected
                      ? AppColors.primaryColor
                      : AppColors.greyShade300,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    schedule[index]['day']!,
                    style: AppTextStyles.font13Regular.copyWith(
                      color: isSelected ? AppColors.white : AppColors.textGrey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    schedule[index]['date']!,
                    style: AppTextStyles.font18SemiBold.copyWith(
                      color: isSelected ? AppColors.white : AppColors.textDark,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
