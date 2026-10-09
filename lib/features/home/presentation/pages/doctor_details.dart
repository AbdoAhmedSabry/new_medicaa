import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_medicaa/config/theme/app_colors.dart';
import 'package:new_medicaa/config/theme/app_text_styles.dart';
import 'package:new_medicaa/config/theme/app_theme.dart';
import 'package:new_medicaa/features/home/domain/entities/home_entity.dart';
import 'package:new_medicaa/features/home/presentation/manager/appointment_cubit.dart';
import 'package:new_medicaa/features/home/presentation/pages/booking_checkout_screen.dart';
import 'package:new_medicaa/features/home/presentation/widgets/about_section_widget.dart';
import 'package:new_medicaa/features/home/presentation/widgets/background_curve_widget.dart';
import 'package:new_medicaa/features/home/presentation/widgets/clinic_info_widget.dart';
import 'package:new_medicaa/features/home/presentation/widgets/doctor_info_card_widget.dart';
import 'package:new_medicaa/features/home/presentation/widgets/reviews_header_widget.dart';
import 'package:new_medicaa/features/home/presentation/widgets/reviews_list_widget.dart';
import 'package:new_medicaa/features/home/presentation/widgets/section_title_widget.dart';
import 'package:new_medicaa/features/home/presentation/widgets/stats_row_widget.dart';

class DoctorProfileScreen extends StatelessWidget {
  final DoctorEntity doctor;
  const DoctorProfileScreen({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    final List<dynamic>? daysList =
        doctor.clinicInfo?['workingDays'] as List<dynamic>?;
    String displayDays = 'unknown_working_days'.tr();
    if (daysList != null && daysList.isNotEmpty) {
      if (daysList.length == 1) {
        displayDays = daysList.first.toString();
      } else {
        displayDays = '${daysList.first} - ${daysList.last}';
      }
    }
    return Scaffold(
      backgroundColor: AppColors.fieldBg,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppColors.white, size: 20.r),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'doctor_profile'.tr(),
          style: AppTextStyles.font18SemiBold.copyWith(color: AppColors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.favorite_border,
              color: AppColors.white,
              size: 24.r,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          const BackgroundCurveWidget(),
          Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: Responsive(context).maxContentWidth,
              ),
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DoctorInfoCardWidget(doctor: doctor),
                    SizedBox(height: 20.h),
                    const StatsRowWidget(),
                    SizedBox(height: 24.h),

                    SectionTitleWidget(title: 'about_doctor'.tr()),
                    AboutSectionWidget(text: doctor.getLocalizedAbout(context) ?? 'no_bio'.tr()),
                    SizedBox(height: 24.h),

                    SectionTitleWidget(title: 'clinic_information'.tr()),
                    ClinicInfoWidget(
                      clinicName:
                          doctor.clinicInfo?['name'] ?? 'unknown_clinic'.tr(),
                      clinicAddress:
                          doctor.clinicInfo?['address'] ?? 'unknown_address'.tr(),
                      phone: doctor.clinicInfo?['phone'] ?? 'unknown_phone'.tr(),
                      workingHours:
                          doctor.clinicInfo?['workingTime'] ??
                          'unknown_working_hours'.tr(),
                      workingDays: displayDays,
                      email: doctor.clinicInfo?['email'] ?? 'unknown_email'.tr(),
                    ),

                    SizedBox(height: 24.h),

                    SectionTitleWidget(title: 'reviews'.tr()),
                    const ReviewsListWidget(),
                    SizedBox(height: 100.h), 
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsetsDirectional.only(
            start: 16.w,
            end: 16.w,
            bottom: 16.h,
            top: 8.h,
          ),
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (newContext) => BlocProvider.value(
                    value: BlocProvider.of<AppointmentCubit>(context),
                    child: BookingCheckoutScreen(doctor: doctor),
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              padding: EdgeInsets.symmetric(vertical: 16.h),
              elevation: 6,
              shadowColor: AppColors.primaryColor.withOpacity(0.4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  16.r,
                ),
              ),
            ),
            child: Text(
              'book_appointment'.tr(),
              style: AppTextStyles.font16SemiBold.copyWith(
                color: AppColors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
