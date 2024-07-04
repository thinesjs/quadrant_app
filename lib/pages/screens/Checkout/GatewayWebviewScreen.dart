import 'package:flutter/material.dart';
import 'package:quadrant_app/pages/screens/Orders/OrdersScreen.dart';
import 'package:webview_flutter/webview_flutter.dart';
// Import for Android features.
import 'package:webview_flutter_android/webview_flutter_android.dart';
// Import for iOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class PaymentWebViewScreen extends StatefulWidget {
  final String url;

  const PaymentWebViewScreen({super.key, required this.url});

  @override
  _PaymentWebViewScreenState createState() => _PaymentWebViewScreenState();
}

class _PaymentWebViewScreenState extends State<PaymentWebViewScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    // #docregion platform_features
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller = WebViewController.fromPlatformCreationParams(params);
    // #enddocregion platform_features


    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            print(request.url);
            if (request.url.startsWith('https://quadrant-api.thinesjs.com/v1/cart/redirect-app')) {
            // if (request.url.startsWith('http://localhost:3000/api/v1/')) {
              // https://api.thinesjaishankar.com/v1/cart/redirect-app?billplz%5Bid%5D=s1lteul0&billplz%5Bpaid%5D=true&billplz%5Bpaid_at%5D=2024-05-30+03%3A21%3A42+%2B0800&billplz%5Bx_signature%5D=aaac23b6d0d6aafa6601760dc29faf8709d7bfda34afd893cd318c4fc29dd917
              Navigator.push(context, OrdersScreen.route());
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SecurePayment'),
      ),
      body: WebViewWidget(
        controller: _controller,
      ),
    );
  }
}
