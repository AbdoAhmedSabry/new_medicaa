import 'package:dartz/dartz.dart';
import 'package:new_medicaa/config/erorr/failure.dart';
import 'package:new_medicaa/features/home/data/datasources/home_local_datasource.dart';
import 'package:new_medicaa/features/home/data/datasources/home_remote_datasource.dart';
import 'package:new_medicaa/features/home/data/models/home_model.dart';
import 'package:new_medicaa/features/home/domain/entities/home_entity.dart';
import 'package:new_medicaa/features/home/domain/repositories/home_repository.dart';
import 'package:new_medicaa/features/patient_profile/data/models/patient_model.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;
  final HomeLocalDataSource localDataSource;

  HomeRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });
  @override
  Future<Either<Failure, List<DoctorModel>>> getDoctors() async {
    try {
      final data = await remoteDataSource.getHomeData();
      final doctors = data
          .map((json) => DoctorModel.fromJson(json, json['id']))
          .toList();
      return Right(doctors);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, PatientModel>> getPatientData() async {
    try {
      final data = await localDataSource.getPatientProfile();
      if (data != null) {
        final patient = PatientModel.fromJson(data);
        return Future.value(Right(patient));
      } else {
        return (Left(CacheFailure('No patient data found in cache')));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<DoctorEntity>>> getDoctorCategory(
    String field,
    String value,
  ) async {
    try {
      final data = await remoteDataSource.getDoctorCategory(field, value);
      final doctors = data
          .map((json) => DoctorModel.fromJson(json, json['id']))
          .toList();
      return Right(doctors);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
