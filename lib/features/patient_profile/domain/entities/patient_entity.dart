import 'package:new_medicaa/features/auth/domain/entities/user_entity.dart';

class PatientEntity extends UserEntity {
  final double weight;
  final double height;
  final String bloodType;
  final bool hasBloodPressure;
  final bool hasDiabetes;
  final List<String> chronicDiseases;
  final String gender;
  final int age;

  PatientEntity({
    required super.uid,
    required super.email,
    required super.name,
    required super.phone,
    super.photoURL,
    required this.weight,
    required this.height,
    required this.bloodType,
    required this.hasBloodPressure,
    required this.hasDiabetes,
    required this.chronicDiseases,
    required this.gender,
    required this.age,
  });
}
