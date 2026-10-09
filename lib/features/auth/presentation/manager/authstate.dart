import 'package:new_medicaa/features/auth/domain/entities/user_entity.dart';

class Authstate {}

class AuthState {}

class AuthInitial extends AuthState {}

class LoginLoading extends AuthState {}

class GoogleLoading extends AuthState {}

class FacebookLoading extends AuthState {}

class RegisterLoading extends AuthState {}

class ForgotPasswordLoading extends AuthState {}

class SignOutLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final UserEntity user;

  AuthSuccess({required this.user});
}

class AuthEmailNotVerified extends AuthState {}

class AuthFailure extends AuthState {
  final String errorMessage;

  AuthFailure({required this.errorMessage});
}
