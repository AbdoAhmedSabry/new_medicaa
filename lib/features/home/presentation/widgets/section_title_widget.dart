import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_medicaa/config/theme/app_text_styles.dart';

class SectionTitleWidget extends StatelessWidget {
  final String title;
  const SectionTitleWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Text(
        title,
        style: AppTextStyles.font18SemiBold,
      ),
    );
  }
}
