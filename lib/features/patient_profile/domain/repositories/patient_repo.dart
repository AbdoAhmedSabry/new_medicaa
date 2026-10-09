import 'package:dartz/dartz.dart';
import 'package:new_medicaa/config/erorr/failure.dart';
import 'package:new_medicaa/features/patient_profile/domain/entities/patient_entity.dart';

abstract class PatientRepo {
  Future<Either<Failure, void>> updatePatient({
    required PatientEntity patientEntity,
  });
  Future<Either<Failure, PatientEntity>> getPatientData();
  Future<Either<Failure, void>> logOut();
  Future<Either<Failure, void>> deletAccount({required String id});
}
