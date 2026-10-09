import 'package:new_medicaa/features/auth/domain/repositories/auth_repository.dart';

class GetCurrentUserUsecase {
  final AuthRepository repository;
  GetCurrentUserUsecase(this.repository);
}
