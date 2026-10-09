import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_medicaa/config/backendpoint.dart';
import 'package:new_medicaa/config/cachehelper.dart';
import 'package:new_medicaa/config/erorr/failure.dart';
import 'package:new_medicaa/config/services/databaseservice.dart';
import 'package:new_medicaa/features/auth/data/data_sources/remote_data_source.dart';
import 'package:new_medicaa/features/patient_profile/data/datasource/profile_localdata_source.dart';
import 'package:new_medicaa/features/patient_profile/data/models/patient_model.dart';
import 'package:new_medicaa/features/patient_profile/domain/entities/patient_entity.dart';
import 'package:new_medicaa/features/patient_profile/domain/repositories/patient_repo.dart';

class PatientRepoImpl implements PatientRepo {
  final Databasabaseservice databaseservice;
  final ProfileLocalDataSource localDataSource;
  final FirebaseAuthServic firebaseAuthServic;

  PatientRepoImpl({
    required this.databaseservice,
    required this.localDataSource,
    required this.firebaseAuthServic,
  });
  @override
  Future<Either<Failure, void>> updatePatient({
    required PatientEntity patientEntity,
  }) async {
    try {
      final data = PatientModel.fromPatientEntity(patientEntity).toJson();
      await databaseservice.updateData(
        collectionPath: BackEndpoint.patientCollection,
        docId: patientEntity.uid,
        data: data,
      );
      String userJson = jsonEncode(data);
      await CacheHelper.saveData(
        key: CacheEndpoint.patientProfile,
        value: userJson,
      );
      return Right(null);
    } on FirebaseAuthException catch (e) {
      return left(ServerFailure.fromFirebaseAuthException(e));
    } on Exception catch (e) {
      return left(ServerFailure.fromException(e));
    } catch (e) {
      debugPrint('=== Firebase Update Error: ${e.toString()} ===');
      return left(ServerFailure('حدث خطأ غير معروف، يرجى المحاولة لاحقاً.'));
    }
  }

  @override
  Future<Either<Failure, PatientEntity>> getPatientData() async {
    try {
      final data = await localDataSource.getPatientProfile();
      if (data != null) {
        final patient = PatientModel.fromJson(data);
        return Right(patient);
      } else {
        return Left(CacheFailure('لا توجد بيانات محلياً'));
      }
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logOut() async {
    try {
      await firebaseAuthServic.logOut();
      await localDataSource.deletLocalData();

      return right(null);
    } on FirebaseAuthException catch (e) {
      return left(ServerFailure.fromFirebaseAuthException(e));
    } on Exception catch (e) {
      return left(ServerFailure.fromException(e));
    } catch (e) {
      return left(ServerFailure('حدث خطأ غير معروف، يرجى المحاولة لاحقاً.'));
    }
  }

  @override
  Future<Either<Failure, void>> deletAccount({required String id}) async {
    try {
      await databaseservice.deleteData(
        collectionPath: BackEndpoint.patientCollection,
        docId: id,
      );
      await firebaseAuthServic.delatUser();
      await localDataSource.deletLocalData();
      return right(null);
    } on FirebaseAuthException catch (e) {
      return left(ServerFailure.fromFirebaseAuthException(e));
    } on Exception catch (e) {
      return left(ServerFailure.fromException(e));
    } catch (e) {
      return left(ServerFailure('حدث خطأ غير معروف، يرجى المحاولة لاحقاً.'));
    }
  }
}
