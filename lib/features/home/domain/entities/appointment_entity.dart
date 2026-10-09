class AppointmentEntity {
  final String AppointmentId;
  final String PatientId;
  final String DoctorId;
  final String date;
  final String time;
  final String status;
  final String consultationType;

  final String? doctorName;
  final String? speciality;
  final String? doctorImage;
  final String? patientName;
  final String? patientImage;
  final String? patientPhone;

  AppointmentEntity({
    required this.AppointmentId,
    required this.PatientId,
    required this.DoctorId,
    required this.date,
    required this.time,
    required this.status,
    required this.consultationType,
    this.doctorName,
    this.speciality,
    this.doctorImage, this.patientName, this.patientImage, this.patientPhone,
  });
}
