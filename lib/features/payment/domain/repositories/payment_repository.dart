import 'package:dartz/dartz.dart';
import 'package:new_medicaa/config/erorr/failure.dart';
import 'package:new_medicaa/features/payment/domain/use_case/payment_params.dart';

abstract class BasePaymentRepository {
  Future<Either<Failure, String>> getCardPaymentKey(PaymentParams params);
  Future<Either<Failure, String>> getWalletPaymentUrl(PaymentParams params);
}
