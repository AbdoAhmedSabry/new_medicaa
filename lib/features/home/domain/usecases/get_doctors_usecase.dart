import 'package:dartz/dartz.dart';
import 'package:new_medicaa/config/erorr/failure.dart';
import 'package:new_medicaa/features/home/data/models/home_model.dart';
import 'package:new_medicaa/features/home/domain/entities/home_entity.dart';
import 'package:new_medicaa/features/home/domain/repositories/home_repository.dart';

class GetDoctorsUseCase {
  final HomeRepository repository;

  GetDoctorsUseCase(this.repository);

  Future<Either<Failure, List<DoctorEntity>>> call() async {
    return await repository.getDoctors();
  }
}
