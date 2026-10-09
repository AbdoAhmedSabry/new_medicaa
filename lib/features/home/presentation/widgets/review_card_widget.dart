import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_medicaa/config/theme/app_colors.dart';
import 'package:new_medicaa/config/theme/app_text_styles.dart';

class ReviewCardWidget extends StatelessWidget {
  final String name;
  final String time;
  final String comment;
  final int stars;

  const ReviewCardWidget({
    super.key,
    required this.name,
    required this.time,
    required this.comment,
    required this.stars,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.reviewCardBg.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20.r,
            backgroundColor: AppColors.greyShade300,
            child: Icon(Icons.person, color: AppColors.white, size: 20.r),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        name,
                        style: AppTextStyles.font14SemiBold,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      time,
                      style: AppTextStyles.font12Regular.copyWith(
                        color: AppColors.textGrey,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Row(
                  children: List.generate(
                    stars,
                    (index) =>
                        Icon(Icons.star, color: AppColors.starAmber, size: 16.r),
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  comment,
                  style: AppTextStyles.font13Regular.copyWith(
                    color: AppColors.textGrey,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          Icon(Icons.more_vert, color: AppColors.textGrey, size: 20.r),
        ],
      ),
    );
  }
}
