import 'package:dartz/dartz.dart';
import 'package:new_medicaa/config/erorr/failure.dart';
import 'package:new_medicaa/features/home/data/models/home_model.dart';
import 'package:new_medicaa/features/home/domain/entities/home_entity.dart';
import 'package:new_medicaa/features/patient_profile/data/models/patient_model.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<DoctorEntity>>> getDoctors();
  Future<Either<Failure, PatientModel>> getPatientData();
  Future<Either<Failure, List<DoctorEntity>>> getDoctorCategory(
    String field,
    String value,
  );
}
