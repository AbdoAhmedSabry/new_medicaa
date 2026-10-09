import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_medicaa/config/const/routes.dart';
import 'package:new_medicaa/config/theme/app_colors.dart';
import 'package:new_medicaa/config/theme/app_text_styles.dart';
import 'package:new_medicaa/config/theme/app_theme.dart';
import 'package:new_medicaa/features/home/presentation/manager/home_cubit.dart';
import 'package:new_medicaa/features/home/presentation/manager/home_state.dart';
import 'package:new_medicaa/features/home/presentation/widgets/banner.dart';
import 'package:new_medicaa/features/home/presentation/widgets/custom_app_bar.dart';
import 'package:new_medicaa/features/home/presentation/widgets/doctor_containers_list.dart';
import 'package:new_medicaa/features/home/presentation/widgets/small_container_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController searchcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, Homestate>(
      listener: (context, state) {
        if (state is HomeError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(
            SnackBar(
              content: Text(
                state.message,
                style: const TextStyle(color: AppColors.white),
              ),
              backgroundColor: AppColors.errorRed,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is HomeLoading) {
          return const Scaffold(
            body: const Center(child: CircularProgressIndicator(color: AppColors.primaryColor)),
          );
        } else if (state is HomeSuccess) {
          final doctors = state.doctors;
          final patientData = state.patientData;

          return Scaffold(
            appBar: CustomAppBar(
              patient: patientData,
              controller: searchcontroller,
            ),
            body: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: Responsive(context).maxContentWidth,
                ),
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(top: 16.h, bottom: 24.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const BannerCarousel(),
                      SizedBox(height: 16.h),

                      CategoriesSection(),
                      SizedBox(height: 20.h),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'all_doctors'.tr(),
                              style: AppTextStyles.font24SemiBold,
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  Routes.allDoctorsScreen,
                                  arguments: doctors,
                                );
                              },
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

                      DoctorcontainersList(doctors: doctors),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else if (state is HomeError) {
          return Scaffold(body: Center(child: Text(state.message)));
        }

        return const Scaffold(body: SizedBox.shrink());
      },
    );
  }
}
