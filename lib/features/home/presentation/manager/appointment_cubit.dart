import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:new_medicaa/features/home/domain/entities/appointment_entity.dart';
import 'package:new_medicaa/features/home/domain/usecases/book_appointment_usecase.dart';
import 'package:new_medicaa/features/home/domain/usecases/get_book_time_slots_usecase.dart';
import 'package:new_medicaa/features/home/domain/usecases/get_my_appointment_usecase.dart';
import 'package:new_medicaa/features/home/domain/usecases/get_patient_data_usecase.dart';
import 'package:new_medicaa/features/home/presentation/manager/appointment_state.dart';

class AppointmentCubit extends Cubit<AppointmentState> {
  final GetBookedTimeSlotsUseCase getBookedTimeSlotsUseCase;
  final BookAppointmentUseCase bookAppointmentUseCase;
  final GetPatientDataUseCase getPatientDataUseCase;
  final GetMyAppointmentUseCase getMyAppointmentUseCase;

  AppointmentCubit(
    this.getBookedTimeSlotsUseCase,
    this.bookAppointmentUseCase, {
    required this.getPatientDataUseCase,
    required this.getMyAppointmentUseCase,
  }) : super(AppointmentInitial());

  DateTime? _selectedDate;
  List<DateTime> days = [];
  String? _selectedTime;

  
  List<String> _clinicTimeSlots = [];
  List<String> _onlineTimeSlots = [];
  List<String> _doctorTimeSlots = [];
  List<String> _currentBookedSlots = [];
  bool _isOnline = false;

  
  void initschedule({
    required List<String> clinicTimeSlots,
    required List<String> onlineTimeSlots,
    required String doctorId,
  }) {
    _clinicTimeSlots = clinicTimeSlots;
    _onlineTimeSlots = onlineTimeSlots;
    _doctorTimeSlots = _clinicTimeSlots;

    days = List.generate(
      7,
      (index) => DateTime.now().add(Duration(days: index)),
    );
    _selectedDate = days.first;
    getBookedTimeSlots(doctorId: doctorId, date: _selectedDate!);
  }

  
  void changeConsultationType(bool isOnline) {
    _isOnline = isOnline;

    if (_isOnline) {
      _doctorTimeSlots = _onlineTimeSlots;
    } else {
      _doctorTimeSlots = _clinicTimeSlots;
    }

    _selectedTime = null;

    emit(
      AppointmentSuccess(
        selectedDate: _selectedDate!,
        upcomingDays: days,
        doctorTimeSlots: _doctorTimeSlots,
        bookedSlots: _currentBookedSlots,
        selectedTime: _selectedTime,
      ),
    );
  }

  Future<void> getBookedTimeSlots({
    required String doctorId,
    required DateTime date,
  }) async {
    _selectedDate = date;
    _selectedTime = null;

    emit(
      AppointmentSuccess(
        selectedDate: _selectedDate!,
        upcomingDays: days,
        doctorTimeSlots: _doctorTimeSlots,
        bookedSlots: _currentBookedSlots,
        selectedTime: _selectedTime,
      ),
    );

    final dateString = DateFormat('yyyy-MM-dd').format(date);

    final result = await getBookedTimeSlotsUseCase(
      doctorId: doctorId,
      date: dateString,
    );

    result.fold(
      (failure) {
        debugPrint(failure.message);
      },
      (bookedTimeSlots) {
        _currentBookedSlots = bookedTimeSlots;
        emit(
          AppointmentSuccess(
            selectedDate: _selectedDate!,
            upcomingDays: days,
            doctorTimeSlots: _doctorTimeSlots,
            bookedSlots: bookedTimeSlots,
            selectedTime: _selectedTime,
          ),
        );
      },
    );
  }

  void selectTime(String time) {
    _selectedTime = time;

    emit(
      AppointmentSuccess(
        selectedDate: _selectedDate!,
        upcomingDays: days,
        doctorTimeSlots: _doctorTimeSlots,
        bookedSlots: _currentBookedSlots,
        selectedTime: _selectedTime,
      ),
    );
  }

  
  Future<void> bookAppointment({
    required String doctorId,
    required String doctorName,
    required String doctorSpeciality,
    String? doctorImage,
  }) async {
    if (_selectedDate == null || _selectedTime == null) {
      emit(AppointmentFailure(errorMessage: 'Please select a date and time.'));
      return;
    }

    emit(AppointmentBookedLoading());

    final patientResult = await getPatientDataUseCase.call();

    await patientResult.fold(
      (failure) async {
        emit(AppointmentFailure(errorMessage: 'حدث خطأ في جلب بيانات المريض'));
      },
      (patient) async {
        final appointmentEntity = AppointmentEntity(
          AppointmentId: DateTime.now().millisecondsSinceEpoch.toString(),
          PatientId: patient.uid,
          DoctorId: doctorId,
          date: DateFormat('yyyy-MM-dd').format(_selectedDate!),
          time: _selectedTime!,
          status: 'booked',
          consultationType: _isOnline ? 'online' : 'clinic',
          doctorName: doctorName,
          speciality: doctorSpeciality,
          doctorImage: doctorImage,
          patientName: patient.name,
          patientImage: patient.photoURL,
          patientPhone: patient.phone,
        );

        final result = await bookAppointmentUseCase(appointmentEntity);

        result.fold(
          (failure) {
            emit(AppointmentFailure(errorMessage: failure.message));
          },
          (_) {
            emit(
              AppointmentBookedSuccess(
                message: 'Appointment booked successfully.',
              ),
            );
          },
        );
      },
    );
  }

  Future<void> getMyAppointment() async {
    emit(AppointmentLoadingState());

    final result = await getMyAppointmentUseCase();

    result.fold(
      (failure) => emit(AppointmentErrorState(message: failure.message)),
      (appointments) =>
          emit(AppointmentSuccessState(appointments: appointments)),
    );
  }
}
