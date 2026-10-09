import 'package:dartz/dartz.dart';
import 'package:new_medicaa/config/erorr/failure.dart';
import 'package:new_medicaa/features/home/domain/repositories/home_repository.dart';
import 'package:new_medicaa/features/patient_profile/data/models/patient_model.dart';

class GetPatientDataUseCase {
  final HomeRepository repository;

  GetPatientDataUseCase(this.repository);

  Future<Either<Failure, PatientModel>> call() async {
    return await repository.getPatientData();
  }
}
