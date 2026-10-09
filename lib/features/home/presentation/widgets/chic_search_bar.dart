import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_medicaa/config/theme/app_colors.dart';
import 'package:new_medicaa/features/auth/presentation/widgets/custom_textfield.dart';

class ChicSearchBar extends StatelessWidget {
  final TextEditingController controller;

  const ChicSearchBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55.h,
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.nearBlack.withValues(alpha: 0.06),
            blurRadius: 10.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: CustomTextfield(
        label: "search",
        hintText: "Search for doctor...",
        controller: controller,
        prefix: Icon(Icons.search_rounded, color: AppColors.primaryColor),
      ),
    );
  }
}
