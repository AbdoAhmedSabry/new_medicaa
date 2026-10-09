import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:new_medicaa/config/backendpoint.dart';
import 'package:new_medicaa/config/cachehelper.dart';
import 'package:new_medicaa/config/erorr/failure.dart';
import 'package:new_medicaa/config/services/databaseservice.dart';
import 'package:new_medicaa/features/auth/data/data_sources/remote_data_source.dart';
import 'package:new_medicaa/features/auth/data/models/user_model.dart';
import 'package:new_medicaa/features/auth/domain/entities/user_entity.dart';
import 'package:new_medicaa/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthServic firebaseAuthServic;
  final Databasabaseservice databaseservice;

  AuthRepositoryImpl({
    required this.firebaseAuthServic,
    required this.databaseservice,
  });
  @override
  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final user = await firebaseAuthServic.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null && !currentUser.emailVerified) {
        await firebaseAuthServic.logOut();
        return left(
          ServerFailure(
            'برجاء تفعيل حسابك أولاً من خلال الرابط المرسل لبريدك الإلكتروني',
          ),
        );
      }

      final userexist = await databaseservice.getData(
        collectionPath: BackEndpoint.patientCollection,
        docId: user.uid,
      );

      if (userexist != null) {
        final userModel = UserModel.fromJson(userexist);
        await CacheHelper.saveData(
          key: CacheEndpoint.patientProfile,
          value: jsonEncode(userModel.toJson()),
        );
        return right(userModel);
      } else {
        await firebaseAuthServic.logOut();
        return left(
          ServerFailure(
            'لم يتم العثور على بيانات الحساب، يرجى إنشاء حساب جديد.',
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      return left(ServerFailure.fromFirebaseAuthException(e));
    } on Exception catch (e) {
      return left(ServerFailure.fromException(e));
    } catch (e) {
      return left(ServerFailure('حدث خطأ غير معروف، يرجى المحاولة لاحقاً.'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    try {
      final user = await firebaseAuthServic.signUpWithEmailAndPassword(
        email: email,
        password: password,
        name: name,
        phone: phone,
      );

      final userModel = UserModel.fromUserEntity(user);

      return right(userModel);
    } on FirebaseAuthException catch (e) {
      return left(ServerFailure.fromFirebaseAuthException(e));
    } on Exception catch (e) {
      return left(ServerFailure.fromException(e));
    } catch (e) {
      return left(ServerFailure('حدث خطأ غير معروف، يرجى المحاولة لاحقاً'));
    }
  }

  @override
  Future<Either<Failure, void>> forgotPassword(String email) async {
    try {
      await firebaseAuthServic.forgotPassword(email: email);
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
  Future<Either<Failure, void>> logOut() async {
    try {
      await firebaseAuthServic.logOut();
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
  Future<Either<Failure, UserEntity>> signInWithGoogle() async {
    try {
      final user = await firebaseAuthServic.signInWithGoogle();
      final userexist = await databaseservice.getData(
        collectionPath: BackEndpoint.patientCollection,
        docId: user.uid,
      );
      if (userexist == null) {
        final userModel = UserModel.fromUserEntity(user);
        await databaseservice.setData(
          collectionPath: BackEndpoint.patientCollection,
          docId: user.uid,
          data: userModel.toJson(),
        );
        await CacheHelper.saveData(
          key: CacheEndpoint.patientProfile,
          value: jsonEncode(userModel.toJson()),
        );
        return right(userModel);
      } else {
        final userModel = UserModel.fromJson(userexist);
        await CacheHelper.saveData(
          key: CacheEndpoint.patientProfile,
          value: jsonEncode(userModel.toJson()),
        );
        return right(userModel);
      }
    } on FirebaseAuthException catch (e) {
      return left(ServerFailure.fromFirebaseAuthException(e));
    } on Exception catch (e) {
      return left(ServerFailure.fromException(e));
    } catch (e) {
      return left(ServerFailure('حدث خطأ غير معروف، يرجى المحاولة لاحقاً.'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithFacebook() async {
    try {
      final user = await firebaseAuthServic.signInWithFacebook();
      final userexist = await databaseservice.getData(
        collectionPath: BackEndpoint.patientCollection,
        docId: user.uid,
      );
      if (userexist == null) {
        final userModel = UserModel.fromUserEntity(user);
        await databaseservice.setData(
          collectionPath: BackEndpoint.patientCollection,
          docId: user.uid,
          data: userModel.toJson(),
        );
        await CacheHelper.saveData(
          key: CacheEndpoint.patientProfile,
          value: jsonEncode(userModel.toJson()),
        );
        return right(userModel);
      } else {
        final userModel = UserModel.fromJson(userexist);
        await CacheHelper.saveData(
          key: CacheEndpoint.patientProfile,
          value: jsonEncode(userModel.toJson()),
        );
        return right(userModel);
      }
    } on FirebaseAuthException catch (e) {
      return left(ServerFailure.fromFirebaseAuthException(e));
    } on Exception catch (e) {
      return left(ServerFailure.fromException(e));
    } catch (e) {
      return left(ServerFailure('حدث خطأ غير معروف، يرجى المحاولة لاحقاً.'));
    }
  }

  @override
  Future<Either<Failure, void>> saveUserData(UserModel userModel) async {
    try {
      await databaseservice.setData(
        collectionPath: BackEndpoint.patientCollection,
        docId: userModel.uid,
        data: userModel.toJson(),
      );
      return right(null);
    } catch (e) {
      return left(ServerFailure.fromException(e as Exception));
    }
  }
}
