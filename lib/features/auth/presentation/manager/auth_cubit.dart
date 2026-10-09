import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_medicaa/config/backendpoint.dart';
import 'package:new_medicaa/config/cachehelper.dart';
import 'package:new_medicaa/features/auth/data/models/user_model.dart';
import 'package:new_medicaa/features/auth/domain/entities/user_entity.dart';
import 'package:new_medicaa/features/auth/domain/repositories/auth_repository.dart';
import 'package:new_medicaa/features/auth/presentation/manager/authstate.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepository) : super(AuthInitial());
  final AuthRepository authRepository;
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    emit(LoginLoading());
    var result = await authRepository.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    result.fold(
      (failure) {
        emit(AuthFailure(errorMessage: failure.message));
      },
      (user) {
        emit(AuthSuccess(user: user));
      },
    );
  }

  Future<void> signUpWithEmailAndPassword(
    String email,
    String password,
    String name,
    String phone,
  ) async {
    emit(RegisterLoading());
    var result = await authRepository.signUpWithEmailAndPassword(
      email: email,
      password: password,
      name: name,
      phone: phone,
    );
    result.fold(
      (failure) {
        emit(AuthFailure(errorMessage: failure.message));
      },
      (user) async {
        // await FirebaseAuth.instance.currentUser?.sendEmailVerification();
        emit(AuthSuccess(user: user));
      },
    );
  }

  Future<void> signInWithGoogle() async {
    emit(GoogleLoading());
    var result = await authRepository.signInWithGoogle();
    result.fold(
      (failure) {
        emit(AuthFailure(errorMessage: failure.message));
      },
      (user) {
        emit(AuthSuccess(user: user));
      },
    );
  }

  Future<void> signInWithFacebook() async {
    emit(FacebookLoading());
    var result = await authRepository.signInWithFacebook();
    result.fold(
      (failure) {
        emit(AuthFailure(errorMessage: failure.message));
      },
      (user) {
        emit(AuthSuccess(user: user));
      },
    );
  }

  Future<void> forgotPassword(String email) async {
    emit(ForgotPasswordLoading());
    var result = await authRepository.forgotPassword(email);
    result.fold(
      (failure) {
        emit(AuthFailure(errorMessage: failure.message));
      },
      (_) {
        emit(
          AuthSuccess(
            user: UserEntity(uid: '', email: '', name: '', phone: ''),
          ),
        );
      },
    );
  }

  Future<void> checkEmailVerification(UserModel userModel) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.reload();
      if (user.emailVerified) {
        await authRepository.saveUserData(userModel);
        await CacheHelper.saveData(
          key: CacheEndpoint.patientProfile,
          value: userModel.toJson(),
        );

        emit(AuthSuccess(user: userModel));
      } else {
        emit(AuthEmailNotVerified());
      }
    }
  }

  Future<void> logOut() async {
    emit(SignOutLoading());
    var result = await authRepository.logOut();
    result.fold(
      (failure) {
        emit(AuthFailure(errorMessage: failure.message));
      },
      (_) {
        emit(
          AuthSuccess(
            user: UserEntity(uid: '', email: '', name: '', phone: ''),
          ),
        );
      },
    );
  }
}
