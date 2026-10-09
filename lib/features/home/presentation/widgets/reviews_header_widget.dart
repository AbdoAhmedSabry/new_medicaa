import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:new_medicaa/config/theme/app_colors.dart';
import 'package:new_medicaa/config/theme/app_text_styles.dart';

class ReviewsHeaderWidget extends StatelessWidget {
  const ReviewsHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'reviews_count'.tr(),
          style: AppTextStyles.font18SemiBold,
        ),
        Text(
          'see_all'.tr(),
          style: AppTextStyles.font14SemiBold.copyWith(
            color: AppColors.primaryColor,
          ),
        ),
      ],
    );
  }
}
