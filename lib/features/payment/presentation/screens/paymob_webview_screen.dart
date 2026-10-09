import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:new_medicaa/config/theme/app_colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CardPaymentScreen extends StatefulWidget {
  final String paymentKey;

  const CardPaymentScreen({super.key, required this.paymentKey});

  @override
  State<CardPaymentScreen> createState() => _CardPaymentScreenState();
}

class _CardPaymentScreenState extends State<CardPaymentScreen> {
  late final WebViewController _controller;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    const String iframeId = "1065212";

    final String url =
        "https://accept.paymob.com/api/acceptance/iframes/$iframeId?payment_token=${widget.paymentKey}";

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() {
              isLoading = true;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              isLoading = false;
            });
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.contains('success=true')) {
              Navigator.pop(context, true);
              return NavigationDecision.prevent;
            } else if (request.url.contains('success=false')) {
              Navigator.pop(context, false);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('card_payment'.tr()),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (isLoading) const Center(child: CircularProgressIndicator(color: AppColors.primaryColor)),
        ],
      ),
    );
  }
}
