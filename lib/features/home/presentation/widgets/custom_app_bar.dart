import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_medicaa/config/theme/app_colors.dart';
import 'package:new_medicaa/config/theme/app_text_styles.dart';
import 'package:new_medicaa/features/home/presentation/widgets/chic_search_bar.dart';
import 'package:new_medicaa/features/patient_profile/domain/entities/patient_entity.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.patient,
    required this.controller,
  });

  final PatientEntity patient;
  final TextEditingController controller;

  static const double _headerHeight = 135;
  static const double _searchBarHeight = 55;
  static const double _searchBarOverlap = _searchBarHeight / 2;

  @override
  Size get preferredSize =>
      Size.fromHeight((_headerHeight + _searchBarOverlap).h);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: preferredSize.height,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: _headerHeight.h,
            decoration: BoxDecoration(
              color: AppColors.headerBlue,
              boxShadow: [
                BoxShadow(
                  color: AppColors.nearBlack.withValues(alpha: 0.12),
                  blurRadius: 4.r,
                  offset: Offset(0, 2.h),
                ),
              ],
            ),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16.w, 12.h, 16.w, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 26.r,
                      backgroundColor: AppColors.white,
                      child: Icon(
                        Icons.person,
                        color: AppColors.primaryColor,
                        size: 28.r,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 2.h),
                        Text(
                          'welcome_back_greeting'.tr(),
                          style: AppTextStyles.font14Regular.copyWith(
                            color: AppColors.white.withValues(alpha: 0.7),
                          ),
                        ),
                        Text(
                          patient.name,
                          style: AppTextStyles.font18SemiBold.copyWith(
                            color: AppColors.white,
                            height: 1.2,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    IconButton(
                      icon: Icon(
                        Icons.notifications_none_rounded,
                        color: AppColors.white,
                        size: 28.r,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
          PositionedDirectional(
            top: (_headerHeight - _searchBarOverlap).h,
            start: 0,
            end: 0,
            child: ChicSearchBar(controller: controller),
          ),
        ],
      ),
    );
  }
}
