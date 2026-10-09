import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_medicaa/config/theme/app_colors.dart';
import 'package:new_medicaa/config/theme/app_text_styles.dart';
import 'package:new_medicaa/config/theme/app_theme.dart';
import 'package:new_medicaa/features/home/presentation/manager/doctor_cubit.dart';
import 'package:new_medicaa/features/home/presentation/manager/doctor_state.dart';
import 'package:new_medicaa/features/home/presentation/widgets/doctor_containers_list.dart';

class CategoryDoctorsScreen extends StatelessWidget {
  const CategoryDoctorsScreen({super.key, required this.categoryName});

  final String categoryName;

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
                    padding: EdgeInsets.only(top: 16.h),
                    child: Text(
                      'category_doctors_title'.tr(
                        namedArgs: {'category': categoryName},
                      ),
                      style: AppTextStyles.font24SemiBold.copyWith(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),

                  BlocBuilder<DoctorCubit, DoctorState>(
                    builder: (context, state) {
                      if (state is DoctorLoading) {
                        return Padding(
                          padding: EdgeInsets.only(top: 100.h),
                          child: const Center(
                            child: CircularProgressIndicator(color: AppColors.primaryColor),
                          ),
                        );
                      } else if (state is DoctorSuccess) {
                        if (state.doctors.isEmpty) {
                          return Padding(
                            padding: EdgeInsets.only(top: 100.h),
                            child: Center(
                              child: Text(
                                'no_doctors_in_specialty'.tr(),
                                style: AppTextStyles.font18SemiBold,
                              ),
                            ),
                          );
                        }
                        return DoctorcontainersList(doctors: state.doctors);
                      } else if (state is DoctorError) {
                        return Padding(
                          padding: EdgeInsets.only(top: 100.h),
                          child: Center(
                            child: Text(
                              state.message,
                              style: AppTextStyles.font16Regular.copyWith(
                                color: AppColors.successGreen.withValues(
                                  alpha: 0.8,
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
