import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class DoctorEntity {
  final String id;
  final String nameEn;
  final String nameAr;
  final String image;
  final String specialtyEn;
  final String specialtyAr;
  final String aboutEn;
  final String aboutAr;
  final int experienceYears;
  final int patientsTreated;
  final double averageRating;
  final Map<String, dynamic> clinicInfo;
  final List<String> availableTimeSlots;
  final List<String>? onlineTimeSlots;
  final double clinicPrice;
  final double onlinePrice;

  DoctorEntity({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.image,
    required this.specialtyEn,
    required this.specialtyAr,
    required this.aboutEn,
    required this.aboutAr,
    required this.experienceYears,
    required this.patientsTreated,
    required this.averageRating,
    required this.clinicInfo,
    required this.availableTimeSlots,
    required this.onlineTimeSlots,
    required this.clinicPrice,
    required this.onlinePrice,
  });

  String getLocalizedName(BuildContext context) {
    return context.locale.languageCode == 'ar' ? nameAr : nameEn;
  }

  String getLocalizedSpecialty(BuildContext context) {
    return context.locale.languageCode == 'ar' ? specialtyAr : specialtyEn;
  }

  String getLocalizedAbout(BuildContext context) {
    return context.locale.languageCode == 'ar' ? aboutAr : aboutEn;
  }
}
