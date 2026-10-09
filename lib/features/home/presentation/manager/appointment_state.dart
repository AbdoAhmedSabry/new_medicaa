import 'package:new_medicaa/features/home/domain/entities/appointment_entity.dart';

class AppointmentState {}

class AppointmentInitial extends AppointmentState {}

class AppointmentLoading extends AppointmentState {}

class AppointmentSuccess extends AppointmentState {
  final DateTime selectedDate;
  final List<DateTime> upcomingDays;
  final List<String> doctorTimeSlots;
  final List<String> bookedSlots;
  final String? selectedTime;
  AppointmentSuccess({
    required this.selectedDate,
    required this.upcomingDays,
    required this.doctorTimeSlots,
    required this.bookedSlots,
    this.selectedTime,
  });
}

class AppointmentFailure extends AppointmentState {
  final String errorMessage;
  AppointmentFailure({required this.errorMessage});
}

class AppointmentBookedLoading extends AppointmentState {}

class AppointmentBookedSuccess extends AppointmentState {
  final String message;
  AppointmentBookedSuccess({required this.message});
}

class AppointmentLoadingState extends AppointmentState {}

class AppointmentErrorState extends AppointmentState {
  final String message;

  AppointmentErrorState({required this.message});
}

class AppointmentSuccessState extends AppointmentState {
  final List<AppointmentEntity> appointments;

  AppointmentSuccessState({required this.appointments});
}
