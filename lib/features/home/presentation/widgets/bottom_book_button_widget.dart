import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_medicaa/config/theme/app_colors.dart';
import 'package:new_medicaa/config/theme/app_text_styles.dart';
import 'package:new_medicaa/features/home/domain/entities/home_entity.dart';
import 'package:new_medicaa/features/home/presentation/manager/appointment_cubit.dart';
import 'package:new_medicaa/features/home/presentation/manager/appointment_state.dart';

class BottomBookButtonWidget extends StatelessWidget {
  final DoctorEntity doctor;

  const BottomBookButtonWidget({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppointmentCubit, AppointmentState>(
      listener: (context, state) {
        if (state is AppointmentBookedSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.message,
                style: const TextStyle(color: AppColors.white),
              ),
              backgroundColor: AppColors.successGreen,
            ),
          );
          Navigator.pop(context);
        }

        if (state is AppointmentFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(
            SnackBar(
              content: Text(
                state.errorMessage,
                style: const TextStyle(color: AppColors.white),
              ),
              backgroundColor: AppColors.errorRed,
            ),
          );
        }
      },

      builder: (context, state) {
        bool isButtonEnabled = false;
        String buttonText = 'select_date_and_time'.tr();

        bool isLoading = state is AppointmentBookedLoading;

        if (state is AppointmentSuccess) {
          isButtonEnabled =
              state.selectedTime != null &&
              !state.bookedSlots.contains(state.selectedTime);
          buttonText = isButtonEnabled
              ? 'book_appointment'.tr()
              : 'select_date_and_time'.tr();
        }

        return Container(
          color: AppColors.white,
          padding: EdgeInsets.all(16.w),
          child: ElevatedButton(
            onPressed: (isButtonEnabled && !isLoading)
                ? () {
                    final cubit = context.read<AppointmentCubit>();
                    cubit.bookAppointment(
                      doctorId: doctor.id,
                      doctorName: doctor.getLocalizedName(context),
                      doctorSpeciality: doctor.getLocalizedSpecialty(context),
                      doctorImage: doctor.image,
                    );
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: (isButtonEnabled || isLoading)
                  ? AppColors.primaryColor
                  : AppColors.greyShade400,
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: isLoading
                ? SizedBox(
                    height: 24.h,
                    width: 24.w,
                    child: CircularProgressIndicator(
                      color: AppColors.white,
                      strokeWidth: 2.w,
                    ),
                  )
                : Text(
                    buttonText,
                    style: AppTextStyles.font16SemiBold.copyWith(
                      color: AppColors.white,
                    ),
                  ),
          ),
        );
      },
    );
  }
}
