import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_medicaa/config/theme/app_colors.dart';
import 'package:new_medicaa/config/theme/app_text_styles.dart';

class TimeSlotsGridWidget extends StatelessWidget {
  final List<String> timeSlots;
  final int selectedIndex;
  final ValueChanged<int> onTimeSelected;
  final List<String> bookedSlots;

  const TimeSlotsGridWidget({
    super.key,
    required this.timeSlots,
    required this.selectedIndex,
    required this.onTimeSelected,
    required this.bookedSlots,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12.w,
      runSpacing: 12.h,
      children: List.generate(timeSlots.length, (index) {
        final time = timeSlots[index];
        bool isBooked = bookedSlots.contains(time);
        bool isSelected = selectedIndex == index && !isBooked;

        return GestureDetector(
          onTap: isBooked ? null : () => onTimeSelected(index),
          child: Container(
            width: (MediaQuery.of(context).size.width - 56.w) / 2,
            padding: EdgeInsets.symmetric(vertical: 12.h),
            decoration: BoxDecoration(
              color: isBooked
                  ? AppColors.greyShade200
                  : (isSelected ? AppColors.primaryColor : AppColors.white),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: isBooked
                    ? AppColors.greyShade400
                    : (isSelected
                          ? AppColors.primaryColor
                          : AppColors.primaryColor.withValues(alpha: 0.5)),
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              time,
              style: AppTextStyles.font13SemiBold.copyWith(
                color: isBooked
                    ? AppColors.textGrey
                    : (isSelected ? AppColors.white : AppColors.primaryColor),
                decoration: isBooked ? TextDecoration.lineThrough : null,
              ),
            ),
          ),
        );
      }),
    );
  }
}
