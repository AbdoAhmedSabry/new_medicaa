import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_medicaa/config/const/routes.dart';
import 'package:new_medicaa/config/theme/app_colors.dart';
import 'package:new_medicaa/config/theme/app_text_styles.dart';

class CategoriesSection extends StatelessWidget {
  CategoriesSection({super.key});

  final List<Map<String, dynamic>> categories = [
    {'name': 'Cardiology',   'key': 'cardiology',   'icon': Icons.favorite_outline_rounded},
    {'name': 'Dentist',      'key': 'dentist',      'icon': Icons.medical_services_outlined},
    {'name': 'Neurology',    'key': 'neurology',    'icon': Icons.psychology_outlined},
    {'name': 'Pediatrics',   'key': 'pediatrics',   'icon': Icons.child_care_outlined},
    {'name': 'Dermatology',  'key': 'dermatology',  'icon': Icons.face_retouching_natural_rounded},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'categories'.tr(),
                style: AppTextStyles.font18SemiBold.copyWith(
                  color: AppColors.textDark,
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                onPressed: () {},
                child: Text(
                  'see_all'.tr(),
                  style: AppTextStyles.font14Regular.copyWith(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.h),
        SizedBox(
          height: 90.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsetsDirectional.only(end: 20.w),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      Routes.categoryDoctorsScreen,
                      arguments: {'categoryName': categories[index]['name']},
                    );
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 60.w,
                        height: 60.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primaryColor.withValues(alpha: 0.08),
                        ),
                        child: Center(
                          child: Icon(
                            categories[index]['icon'],
                            size: 26.sp,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        categories[index]['key'].toString().tr(),
                        style: AppTextStyles.font12Regular.copyWith(
                          color: AppColors.textDark,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
