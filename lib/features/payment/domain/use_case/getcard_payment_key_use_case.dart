import 'package:dartz/dartz.dart';
import 'package:new_medicaa/config/erorr/failure.dart';
import 'package:new_medicaa/features/payment/domain/repositories/payment_repository.dart';
import 'package:new_medicaa/features/payment/domain/use_case/payment_params.dart';

class GetCardPaymentKeyUseCase {
  final BasePaymentRepository repository;
  GetCardPaymentKeyUseCase(this.repository);

  Future<Either<Failure, String>> call(PaymentParams params) async {
    return await repository.getCardPaymentKey(params);
  }
}

class GetWalletPaymentUrlUseCase {
  final BasePaymentRepository repository;
  GetWalletPaymentUrlUseCase(this.repository);

  Future<Either<Failure, String>> call(PaymentParams params) async {
    return await repository.getWalletPaymentUrl(params);
  }
}
