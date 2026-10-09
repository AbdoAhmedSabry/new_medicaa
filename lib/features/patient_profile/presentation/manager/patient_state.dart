import 'package:new_medicaa/features/patient_profile/data/models/patient_model.dart';

class PatientState {}

class PatientIntial extends PatientState {}

class PatientLoading extends PatientState {}

class PatientSuccess extends PatientState {
  final PatientModel patientModel;
  PatientSuccess({required this.patientModel});
}

class PatientError extends PatientState {
  final String errorMessage;
  PatientError({required this.errorMessage});
}

class PatientLoggedOutSuccess extends PatientState {}

class PatientAccountDeletedSuccess extends PatientState {}
