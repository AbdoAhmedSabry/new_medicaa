import 'package:new_medicaa/features/home/domain/entities/appointment_entity.dart';

class AppointmentModel extends AppointmentEntity {
  AppointmentModel({
    required super.AppointmentId,
    required super.PatientId,
    required super.DoctorId,
    required super.date,
    required super.time,
    required super.status,
    required super.consultationType,
    required super.doctorName,
    required super.speciality,
    required super.doctorImage,
    required super.patientName,
    required super.patientImage,
    required super.patientPhone,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      AppointmentId: json['appointmentId'] ?? '',
      PatientId: json['patientId'] ?? '',
      DoctorId: json['doctorId'] ?? '',
      date: json['date'] ?? '',
      time: json['time'] ?? '',
      status: json['status'] ?? '',
      consultationType: json['consultationType'] ?? 'clinic',
      doctorName: json['doctorName'],
      speciality: json['speciality'],
      doctorImage: json['doctorImage'],
      patientName: json['patientName'],
      patientImage: json['patientImage'],
      patientPhone: json['patientPhone'],
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'appointmentId': AppointmentId,
      'patientId': PatientId,
      'doctorId': DoctorId,
      'date': date,
      'time': time,
      'status': status,
      'consultationType': consultationType,
      'doctorName': doctorName,
      'speciality': speciality,
      'doctorImage': doctorImage,
      'patientName': patientName,
      'patientImage': patientImage,
      'patientPhone': patientPhone,
    };
  }
}
