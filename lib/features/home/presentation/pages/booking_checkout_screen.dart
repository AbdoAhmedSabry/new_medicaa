import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:new_medicaa/config/theme/app_colors.dart';
import 'package:new_medicaa/config/theme/app_text_styles.dart';
import 'package:new_medicaa/config/theme/app_theme.dart';
import 'package:new_medicaa/core/di/injection_container.dart';
import 'package:new_medicaa/features/home/domain/entities/home_entity.dart';
import 'package:new_medicaa/features/home/presentation/manager/appointment_cubit.dart';
import 'package:new_medicaa/features/home/presentation/manager/appointment_state.dart';
import 'package:new_medicaa/features/home/presentation/widgets/booking_bottom_bar.dart';
import 'package:new_medicaa/features/home/presentation/widgets/consultation_type_toggle.dart';
import 'package:new_medicaa/features/home/presentation/widgets/payment_method_card.dart';
import 'package:new_medicaa/features/home/presentation/widgets/schedule_list_widget.dart';
import 'package:new_medicaa/features/home/presentation/widgets/time_slots_grid_widget.dart';
import 'package:new_medicaa/features/payment/presentation/cubit/payment_cubit.dart';
import 'package:new_medicaa/features/payment/presentation/cubit/payment_state.dart';
import 'package:new_medicaa/features/payment/presentation/screens/paymob_webview_screen.dart';
import 'package:new_medicaa/features/payment/presentation/screens/walletpaymentscreen.dart';

class BookingCheckoutScreen extends StatefulWidget {
  final DoctorEntity doctor;
  const BookingCheckoutScreen({super.key, required this.doctor});

  @override
  State<BookingCheckoutScreen> createState() => _BookingCheckoutScreenState();
}

class _BookingCheckoutScreenState extends State<BookingCheckoutScreen> {
  bool isOnlineConsultation = false;
  String selectedPaymentMethod = 'clinic';

  @override
  void initState() {
    super.initState();
    context.read<AppointmentCubit>().initschedule(
      onlineTimeSlots: widget.doctor.onlineTimeSlots ?? [],
      doctorId: widget.doctor.id,
      clinicTimeSlots: widget.doctor.availableTimeSlots,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<PaymentCubit>(),
      child: Builder(
        builder: (builderContext) {
          return MultiBlocListener(
            listeners: [
              BlocListener<PaymentCubit, PaymentState>(
                listener: (listenerContext, state) async {
                  if (state is PaymentLoading) {
                    showDialog(
                      context: listenerContext,
                      barrierDismissible: false,
                      builder: (dialogContext) =>
                          const Center(child: CircularProgressIndicator(color: AppColors.primaryColor)),
                    );
                  } else if (state is PaymentError) {
                    Navigator.pop(listenerContext);
                    ScaffoldMessenger.of(listenerContext).showSnackBar(
                      SnackBar(
                        content: Text(
                          state.errorMessage,
                          style: const TextStyle(color: AppColors.white),
                        ),
                        backgroundColor: AppColors.errorRed,
                      ),
                    );
                  } else if (state is CardPaymentSuccess) {
                    Navigator.pop(listenerContext);
                    final isSuccess = await Navigator.push(
                      listenerContext,
                      MaterialPageRoute(
                        builder: (navContext) =>
                            CardPaymentScreen(paymentKey: state.paymentKey),
                      ),
                    );
                    if (isSuccess == true) {
                      builderContext.read<AppointmentCubit>().bookAppointment(
                        doctorId: widget.doctor.id,
                        doctorName: widget.doctor.getLocalizedName(context),
                        doctorSpeciality: widget.doctor.getLocalizedSpecialty(context),
                        doctorImage: widget.doctor.image,
                      );
                    }
                  } else if (state is WalletPaymentSuccess) {
                    Navigator.pop(listenerContext);
                    final isSuccess = await Navigator.push(
                      listenerContext,
                      MaterialPageRoute(
                        builder: (navContext) =>
                            WalletPaymentScreen(redirectUrl: state.redirectUrl),
                      ),
                    );
                    if (isSuccess == true) {
                      builderContext.read<AppointmentCubit>().bookAppointment(
                        doctorId: widget.doctor.id,
                        doctorName: widget.doctor.getLocalizedName(context),
                        doctorSpeciality: widget.doctor.getLocalizedSpecialty(context),
                        doctorImage: widget.doctor.image,
                      );
                    }
                  }
                },
              ),

              BlocListener<AppointmentCubit, AppointmentState>(
                listener: (listenerContext, state) {
                  if (state is AppointmentLoading) {
                    showDialog(
                      context: listenerContext,
                      barrierDismissible: false,
                      builder: (dialogContext) =>
                          const Center(child: CircularProgressIndicator(color: AppColors.primaryColor)),
                    );
                  } else if (state is AppointmentFailure) {
                    Navigator.pop(listenerContext);
                    ScaffoldMessenger.of(listenerContext).showSnackBar(
                      SnackBar(
                        content: Text(
                          state.errorMessage,
                          style: const TextStyle(color: AppColors.white),
                        ),
                        backgroundColor: AppColors.errorRed,
                      ),
                    );
                  } else if (state is AppointmentBookedSuccess) {
                    Navigator.pop(listenerContext);
                    ScaffoldMessenger.of(listenerContext).showSnackBar(
                      SnackBar(
                        content: Text(
                          'appointment_booked_successfully'.tr(),
                          style: const TextStyle(color: AppColors.white),
                        ),
                        backgroundColor: AppColors.successGreen,
                      ),
                    );
                    Navigator.pop(context);
                  }
                },
              ),
            ],
            child: Scaffold(
              backgroundColor: AppColors.white,
              appBar: AppBar(
                backgroundColor: AppColors.white,
                elevation: 0,
                iconTheme: IconThemeData(color: AppColors.textDark, size: 24.r),
                title: Text(
                  'book_appointment'.tr(),
                  style: AppTextStyles.font18SemiBold.copyWith(
                    color: AppColors.textDark,
                  ),
                ),
              ),
              body: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: Responsive(builderContext).maxContentWidth,
                  ),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'consultation_type'.tr(),
                          style: AppTextStyles.font16SemiBold,
                        ),
                        SizedBox(height: 12.h),
                        ConsultationTypeToggle(
                          isOnline: isOnlineConsultation,
                          onChanged: (value) {
                            setState(() => isOnlineConsultation = value);
                            builderContext
                                .read<AppointmentCubit>()
                                .changeConsultationType(value);
                          },
                        ),
                        SizedBox(height: 24.h),

                        BlocBuilder<AppointmentCubit, AppointmentState>(
                          buildWhen: (previous, current) {
                            return current is AppointmentLoading ||
                                current is AppointmentFailure ||
                                current is AppointmentSuccess;
                          },
                          builder: (blocContext, state) {
                            if (state is AppointmentLoading) {
                              return const Center(
                                child: CircularProgressIndicator(color: AppColors.primaryColor),
                              );
                            } else if (state is AppointmentFailure) {
                              return Center(child: Text(state.errorMessage));
                            } else if (state is AppointmentSuccess) {
                              final cubit = builderContext
                                  .read<AppointmentCubit>();

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'available_schedule'.tr(),
                                    style: AppTextStyles.font16SemiBold,
                                  ),
                                  SizedBox(height: 12.h),
                                  ScheduleListWidget(
                                    schedule: state.upcomingDays.map((date) {
                                      return {
                                        'day': DateFormat('E').format(date),
                                        'date': DateFormat(
                                          'd MMM',
                                        ).format(date),
                                      };
                                    }).toList(),
                                    selectedIndex: state.upcomingDays.indexOf(
                                      state.selectedDate,
                                    ),
                                    onDateSelected: (index) {
                                      cubit.getBookedTimeSlots(
                                        doctorId: widget.doctor.id,
                                        date: state.upcomingDays[index],
                                      );
                                    },
                                  ),
                                  SizedBox(height: 24.h),

                                  Text(
                                    'available_time_slots'.tr(),
                                    style: AppTextStyles.font16SemiBold,
                                  ),
                                  SizedBox(height: 12.h),
                                  TimeSlotsGridWidget(
                                    bookedSlots: state.bookedSlots,
                                    timeSlots: state.doctorTimeSlots,
                                    selectedIndex: state.doctorTimeSlots
                                        .indexOf(state.selectedTime ?? ''),
                                    onTimeSelected: (index) {
                                      final selectedTime =
                                          state.doctorTimeSlots[index];
                                      if (!state.bookedSlots.contains(
                                        selectedTime,
                                      )) {
                                        cubit.selectTime(selectedTime);
                                      }
                                    },
                                  ),
                                  SizedBox(height: 24.h),
                                  Text(
                                    'payment_method'.tr(),
                                    style: AppTextStyles.font16SemiBold,
                                  ),
                                  SizedBox(height: 12.h),
                                  Row(
                                    children: [
                                      PaymentMethodCard(
                                        title: 'clinic'.tr(),
                                        icon: Icons.storefront,
                                        isSelected:
                                            selectedPaymentMethod == 'clinic',
                                        onTap: () => setState(
                                          () =>
                                              selectedPaymentMethod = 'clinic',
                                        ),
                                      ),
                                      PaymentMethodCard(
                                        title: 'wallet'.tr(),
                                        icon: Icons.phone_android,
                                        isSelected:
                                            selectedPaymentMethod == 'wallet',
                                        onTap: () => setState(
                                          () =>
                                              selectedPaymentMethod = 'wallet',
                                        ),
                                      ),
                                      PaymentMethodCard(
                                        title: 'card'.tr(),
                                        icon: Icons.credit_card,
                                        isSelected:
                                            selectedPaymentMethod == 'card',
                                        onTap: () => setState(
                                          () => selectedPaymentMethod = 'card',
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                        SizedBox(height: 100.h),
                      ],
                    ),
                  ),
                ),
              ),
              bottomNavigationBar:
                  BlocBuilder<AppointmentCubit, AppointmentState>(
                    buildWhen: (previous, current) {
                      return current is AppointmentLoading ||
                          current is AppointmentFailure ||
                          current is AppointmentSuccess;
                    },
                    builder: (blocContext, state) {
                      String selectedDateTime = 'select_a_time'.tr();
                      if (state is AppointmentSuccess &&
                          state.selectedTime != null) {
                        final dateStr = DateFormat(
                          'E d MMM',
                        ).format(state.selectedDate);
                        selectedDateTime = '$dateStr, ${state.selectedTime}';
                      }

                      final double price = isOnlineConsultation
                          ? (widget.doctor.onlinePrice ?? 0.0)
                          : (widget.doctor.clinicPrice ?? 0.0);
                      return BookingCheckoutBottomBar(
                        price: price,
                        selectedDateTime: selectedDateTime,
                        onConfirmPressed: () {
                          if (state is AppointmentSuccess &&
                              state.selectedTime != null) {
                            if (selectedPaymentMethod == 'clinic') {
                              builderContext
                                  .read<AppointmentCubit>()
                                  .bookAppointment(
                                    doctorId: widget.doctor.id,
                                    doctorName: widget.doctor.getLocalizedName(context),
                                    doctorSpeciality: widget.doctor.getLocalizedSpecialty(context),
                                    doctorImage: widget.doctor.image,
                                  );
                            } else if (selectedPaymentMethod == 'card') {
                              builderContext.read<PaymentCubit>().payWithCard(
                                price.toString(),
                              );
                            } else if (selectedPaymentMethod == 'wallet') {
                              builderContext.read<PaymentCubit>().payWithWallet(
                                price.toString(),
                              );
                            }
                          } else {
                            ScaffoldMessenger.of(builderContext).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'please_select_time_slot'.tr(),
                                  style: const TextStyle(color: AppColors.white),
                                ),
                                backgroundColor: AppColors.errorRed,
                              ),
                            );
                          }
                        },
                      );
                    },
                  ),
            ),
          );
        },
      ),
    );
  }
}
