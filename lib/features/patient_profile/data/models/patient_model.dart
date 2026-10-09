import 'package:new_medicaa/features/patient_profile/domain/entities/patient_entity.dart';

class PatientModel extends PatientEntity {
  PatientModel({
    required super.uid,
    required super.weight,
    required super.height,
    required super.bloodType,
    required super.hasBloodPressure,
    required super.hasDiabetes,
    required super.chronicDiseases,
    required super.gender,
    required super.age,
    required super.email,
    required super.name,
    required super.phone,
  });

  factory PatientModel.fromPatientEntity(PatientEntity patientEntity) {
    return PatientModel(
      uid: patientEntity.uid,
      weight: patientEntity.weight,
      height: patientEntity.height,
      bloodType: patientEntity.bloodType,
      hasBloodPressure: patientEntity.hasBloodPressure,
      hasDiabetes: patientEntity.hasDiabetes,
      chronicDiseases: patientEntity.chronicDiseases,
      gender: patientEntity.gender,
      age: patientEntity.age,
      email: patientEntity.email,
      name: patientEntity.name,
      phone: patientEntity.phone,
    );
  }

  factory PatientModel.fromJson(Map<String, dynamic> json) {
    return PatientModel(
      uid: json['uid'] ?? '',
      weight: json['weight']?.toDouble() ?? 0.0,
      height: json['height']?.toDouble() ?? 0.0,
      bloodType: json['bloodType'] ?? '',
      hasBloodPressure: json['hasBloodPressure'] ?? false,
      hasDiabetes: json['hasDiabetes'] ?? false,
      chronicDiseases: List<String>.from(json['chronicDiseases'] ?? []),
      gender: json['gender'] ?? '',
      age: json['age']?.toInt() ?? 0,
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'weight': weight,
      'height': height,
      'bloodType': bloodType,
      'hasBloodPressure': hasBloodPressure,
      'hasDiabetes': hasDiabetes,
      'chronicDiseases': chronicDiseases,
      'gender': gender,
      'age': age,
      'email': email,
      'name': name,
      'phone': phone,
    };
  }

  PatientEntity toPatientEntity() {
    return PatientEntity(
      uid: uid,
      weight: weight,
      height: height,
      bloodType: bloodType,
      hasBloodPressure: hasBloodPressure,
      hasDiabetes: hasDiabetes,
      chronicDiseases: chronicDiseases,
      gender: gender,
      age: age,
      email: email,
      name: name,
      phone: phone,
    );
  }
}
