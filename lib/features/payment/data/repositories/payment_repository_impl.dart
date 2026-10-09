import 'package:dartz/dartz.dart';
import 'package:new_medicaa/config/erorr/failure.dart';
import 'package:new_medicaa/features/payment/data/datasources/paymob_remote_data_source.dart';
import 'package:new_medicaa/features/payment/domain/repositories/payment_repository.dart';
import 'package:new_medicaa/features/payment/domain/use_case/payment_params.dart';

class PaymentRepositoryImpl implements BasePaymentRepository {
  final BasePaymobRemoteDataSource _basePaymobRemoteDataSource;

  PaymentRepositoryImpl({
    required BasePaymobRemoteDataSource basePaymobRemoteDataSource,
  }) : _basePaymobRemoteDataSource = basePaymobRemoteDataSource;
  @override
  Future<Either<Failure, String>> getCardPaymentKey(
    PaymentParams params,
  ) async {
    try {
      final result = await _basePaymobRemoteDataSource.getCardKey(params);
      return right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> getWalletPaymentUrl(
    PaymentParams params,
  ) async {
    try {
      final result = await _basePaymobRemoteDataSource.getWalletUrl(params);
      return right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
