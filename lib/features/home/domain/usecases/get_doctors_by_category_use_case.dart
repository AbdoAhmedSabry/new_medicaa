import 'package:dartz/dartz.dart';
import 'package:new_medicaa/config/erorr/failure.dart';
import 'package:new_medicaa/features/home/domain/entities/home_entity.dart';
import 'package:new_medicaa/features/home/domain/repositories/home_repository.dart';

class GetDoctorsByCategoryUseCase {
  final HomeRepository repository;

  GetDoctorsByCategoryUseCase(this.repository);

  Future<Either<Failure, List<DoctorEntity>>> call(
    String field,
    String value,
  ) async {
    return await repository.getDoctorCategory(field, value);
  }
}
