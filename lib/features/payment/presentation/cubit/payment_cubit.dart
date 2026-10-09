import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_medicaa/features/home/domain/usecases/get_patient_data_usecase.dart';
import 'package:new_medicaa/features/payment/domain/use_case/getcard_payment_key_use_case.dart';
import 'package:new_medicaa/features/payment/domain/use_case/payment_params.dart';
import 'package:new_medicaa/features/payment/presentation/cubit/payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit(
    super.initialState, {
    required this.getCardPaymentKeyUseCase,
    required this.getWalletPaymentUrlUseCase,
    required this.getPatientDataUseCase,
  });
  final GetCardPaymentKeyUseCase getCardPaymentKeyUseCase;
  final GetWalletPaymentUrlUseCase getWalletPaymentUrlUseCase;
  final GetPatientDataUseCase getPatientDataUseCase;

  Future<void> payWithCard(String amount) async {
    emit(PaymentLoading());
    final resultPatient = await getPatientDataUseCase.call();

    await resultPatient.fold(
      (failure) async {
        emit(PaymentError(failure.message));
      },
      (patient) async {
        String fName = "NA";
        String lName = 'NA';
        String cleanName = (patient.name ?? "").trim();

        if (cleanName.contains(' ')) {
          List<String> nameParts = cleanName.split(' ');
          fName = nameParts.first;
          lName = nameParts.sublist(1).join(' ');
        } else {
          fName = cleanName.isEmpty ? "NA" : cleanName;
        }

        final params = PaymentParams(
          amountInCents: (double.parse(amount) * 100).toInt(),
          firstName: fName,
          lastName: lName,
          email: patient.email ?? "",
          phone: patient.phone ?? "01000000000",
        );

        final result = await getCardPaymentKeyUseCase(params);
        result.fold(
          (failure) => emit(PaymentError(failure.message)),
          (paymentKey) => emit(CardPaymentSuccess(paymentKey)),
        );
      },
    );
  }

  Future<void> payWithWallet(String amount) async {
    emit(PaymentLoading());
    final resultPatient = await getPatientDataUseCase.call();
    await resultPatient.fold(
      (failuer) {
        emit(PaymentError(failuer.message));
      },
      (patient) async {
        String fName = "NA";
        String lName = "NA";
        String cleanName = (patient.name ?? '').trim();
        if (cleanName.contains(' ')) {
          List<String> partsName = cleanName.split(' ');
          fName = partsName.first;
          lName = partsName.sublist(1).join(' ');
        } else {
          fName = cleanName.isEmpty ? "NA" : cleanName;
        }
        final params = PaymentParams(
          amountInCents: (double.parse(amount) * 100).toInt(),
          firstName: fName,
          lastName: lName,
          email: patient.email ?? "NA",
          phone: patient.phone ?? "01000000000",
        );
        final result = await getWalletPaymentUrlUseCase(params);
        result.fold(
          (failure) => emit(PaymentError(failure.message)),
          (redirectUrl) => emit(WalletPaymentSuccess(redirectUrl)),
        );
      },
    );
  }
}
