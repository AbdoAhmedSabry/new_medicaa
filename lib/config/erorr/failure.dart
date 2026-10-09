import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class Failure {
  final String message;
  Failure(this.message);
}

class ServerFailure extends Failure {
  ServerFailure(super.message);

  factory ServerFailure.fromFirebaseAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'weak-password':
        return ServerFailure('error_weak_password'.tr());
      case 'email-already-in-use':
        return ServerFailure('error_email_already_in_use'.tr());
      case 'invalid-email':
        return ServerFailure('error_invalid_email'.tr());
      case 'user-not-found':
        return ServerFailure('error_user_not_found'.tr());
      case 'wrong-password':
      case 'invalid-credential':
        return ServerFailure('error_invalid_credential'.tr());
      case 'user-disabled':
        return ServerFailure('error_user_disabled'.tr());
      case 'too-many-requests':
        return ServerFailure('error_too_many_requests'.tr());
      case 'network-request-failed':
        return ServerFailure('error_network_request_failed'.tr());
      case 'operation-not-allowed':
        return ServerFailure('error_operation_not_allowed'.tr());
      default:
        return ServerFailure('error_unexpected'.tr(namedArgs: {'message': e.message ?? ''}));
    }
  }

  factory ServerFailure.fromException(Exception e) {
    if (e.toString().contains('SocketException') ||
        e.toString().contains('ClientException')) {
      return ServerFailure('error_socket_exception'.tr());
    } else if (e.toString().contains('TimeoutException')) {
      return ServerFailure('error_timeout_exception'.tr());
    }
    return ServerFailure('error_general_exception'.tr());
  }
}

class CacheFailure extends Failure {
  CacheFailure(super.message);
}
