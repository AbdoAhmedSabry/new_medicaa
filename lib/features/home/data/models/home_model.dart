import 'package:new_medicaa/features/home/domain/entities/home_entity.dart';

class DoctorModel extends DoctorEntity {
  DoctorModel({
    required super.id,
    required super.nameEn,
    required super.nameAr,
    required super.image,
    required super.specialtyEn,
    required super.specialtyAr,
    required super.aboutEn,
    required super.aboutAr,
    required super.experienceYears,
    required super.patientsTreated,
    required super.averageRating,
    required super.clinicInfo,
    required super.availableTimeSlots,
    required super.onlineTimeSlots,
    required super.clinicPrice,
    required super.onlinePrice,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json, String docId) {
    return DoctorModel(
      id: docId,
      nameEn: json['name_en'] ?? '',
      nameAr: json['name_ar'] ?? '',
      image: json['image'] ?? '',
      specialtyEn: json['specialty_en'] ?? '',
      specialtyAr: json['specialty_ar'] ?? '',
      aboutEn: json['about_en'] ?? '',
      aboutAr: json['about_ar'] ?? '',
      experienceYears: json['experienceYears']?.toInt() ?? 0,
      patientsTreated: json['patientsTreated']?.toInt() ?? 0,
      averageRating: json['averageRating']?.toDouble() ?? 0.0,
      clinicInfo: json['clinicInfo'] ?? {},
      availableTimeSlots: List<String>.from(json['availableTimeSlots'] ?? []),
      onlineTimeSlots: json['onlineTimeSlots'] != null
          ? List<String>.from(json['onlineTimeSlots'])
          : null,
      clinicPrice: json['clinicPrice']?.toDouble() ?? 100.0,
      onlinePrice: json['onlinePrice']?.toDouble() ?? 200.0,
    );
  }
}
