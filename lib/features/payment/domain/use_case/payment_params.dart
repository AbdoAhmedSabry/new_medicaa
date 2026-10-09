class PaymentParams {
  final int amountInCents;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;

  PaymentParams({
    required this.amountInCents,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
  });
}
