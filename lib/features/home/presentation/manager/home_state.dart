import 'package:new_medicaa/features/home/domain/entities/home_entity.dart';
import 'package:new_medicaa/features/patient_profile/domain/entities/patient_entity.dart';

class Homestate {}

class HomeInitial extends Homestate {}

class HomeLoading extends Homestate {}

class HomeSuccess extends Homestate {
  final List<DoctorEntity> doctors;
  final PatientEntity patientData;

  HomeSuccess({required this.doctors, required this.patientData});
}

class HomeError extends Homestate {
  final String message;
  HomeError(this.message);
}

// class GetDoctorsByCategorySuccess extends Homestate {
//   final List<DoctorEntity> doctors;

//   GetDoctorsByCategorySuccess({required this.doctors});
// }

// class GetDoctorsByCategoryError extends Homestate {
//   final String message;
//   GetDoctorsByCategoryError(this.message);
// }
// class GetDoctorsByCategoryLoading extends Homestate {}
