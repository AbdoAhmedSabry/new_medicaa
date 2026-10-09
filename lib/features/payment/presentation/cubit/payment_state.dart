abstract class PaymentState {}

class PaymentInitial extends PaymentState {}

class PaymentLoading extends PaymentState {}

class CardPaymentSuccess extends PaymentState {
  final String paymentKey;
  CardPaymentSuccess(this.paymentKey);
}

class WalletPaymentSuccess extends PaymentState {
  final String redirectUrl;
  WalletPaymentSuccess(this.redirectUrl);
}

class PaymentError extends PaymentState {
  final String errorMessage;
  PaymentError(this.errorMessage);
}
