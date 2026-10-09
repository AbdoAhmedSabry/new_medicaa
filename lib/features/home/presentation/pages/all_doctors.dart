import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_medicaa/config/theme/app_colors.dart';
import 'package:new_medicaa/config/theme/app_text_styles.dart';
import 'package:new_medicaa/config/theme/app_theme.dart';
import 'package:new_medicaa/features/home/domain/entities/home_entity.dart';
import 'package:new_medicaa/features/home/presentation/widgets/doctor_containers_list.dart';

class Alldoctors extends StatelessWidget {
  const Alldoctors({super.key, required this.doctors});
  final List<DoctorEntity> doctors;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: Responsive(context).maxContentWidth,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    child: Text(
                      'all_doctors'.tr(),
                      style: AppTextStyles.font24SemiBold.copyWith(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  DoctorcontainersList(doctors: doctors),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
