import 'package:dio/dio.dart';
import 'package:new_medicaa/features/payment/domain/use_case/payment_params.dart';

abstract class BasePaymobRemoteDataSource {
  Future<String> getCardKey(PaymentParams params);
  Future<String> getWalletUrl(PaymentParams params);
}

class PaymobRemoteDataSourceImpl implements BasePaymobRemoteDataSource {
  final Dio dio;
  static const String apiKey =
      "ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SmpiR0Z6Y3lJNklrMWxjbU5vWVc1MElpd2ljSEp2Wm1sc1pWOXdheUk2TVRJd05qZzNPU3dpYm1GdFpTSTZJbWx1YVhScFlXd2lmUS5OekVRZ21WX1g1TEh0ZWlWNWhEWTkwakJFaDZQRHl4ajNrRF9sZVJUZUtNWGRuSllnOVBIaHY1eUpXOWExVlFydlJQaHhlbzhSSmFyOTN3ekFqZlpOdw==";
  static const String cardIntegrationId = "5812954";
  static const String walletIntegrationId = "5812967";

  PaymobRemoteDataSourceImpl({required this.dio});

  @override
  Future<String> getCardKey(PaymentParams params) async {
    String token = await _getAuthToken();
    String orderId = await _getOrderId(token, params.amountInCents.toString());
    return await _getPaymentKey(token, orderId, params, cardIntegrationId);
  }

  @override
  Future<String> getWalletUrl(PaymentParams params) async {
    String token = await _getAuthToken();
    String orderId = await _getOrderId(token, params.amountInCents.toString());
    String paymentKey = await _getPaymentKey(
      token,
      orderId,
      params,
      walletIntegrationId,
    );

    final response = await dio.post(
      'https://accept.paymob.com/api/acceptance/payments/pay',
      data: {
        "source": {"identifier": params.phone, "subtype": "WALLET"},
        "payment_token": paymentKey,
      },
    );

    final redirectUrl = response.data['redirect_url'];
    if (redirectUrl == null || redirectUrl.toString().isEmpty) {
      throw Exception('Payment redirect URL not found. Please check your data.');
    }
    return redirectUrl.toString();
  }

  Future<String> _getAuthToken() async {
    final response = await dio.post(
      'https://accept.paymob.com/api/auth/tokens',
      data: {"api_key": apiKey},
    );
    return response.data['token'];
  }

  Future<String> _getOrderId(String token, String amount) async {
    final response = await dio.post(
      'https://accept.paymob.com/api/ecommerce/orders',
      data: {
        "auth_token": token,
        "delivery_needed": "false",
        "amount_cents": amount,
        "currency": "EGP",
        "items": [],
      },
    );
    return response.data['id'].toString();
  }

  Future<String> _getPaymentKey(
    String token,
    String orderId,
    PaymentParams params,
    String integrationId,
  ) async {
    final response = await dio.post(
      'https://accept.paymob.com/api/acceptance/payment_keys',
      data: {
        "auth_token": token,
        "amount_cents": params.amountInCents.toString(),
        "expiration": 3600,
        "order_id": orderId,
        "billing_data": {
          "apartment": "NA",
          "email": params.email,
          "floor": "NA",
          "first_name": params.firstName,
          "street": "NA",
          "building": "NA",
          "phone_number": params.phone,
          "shipping_method": "NA",
          "postal_code": "NA",
          "city": "NA",
          "country": "EG",
          "last_name": params.lastName,
          "state": "NA",
        },
        "currency": "EGP",
        "integration_id": integrationId,
      },
    );
    return response.data['token'];
  }
}
