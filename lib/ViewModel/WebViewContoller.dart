import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewController extends GetxController {
  late WebViewController webViewController;

  Future<void> loadUrl(String url) async {
    if (webViewController != null) {
      await webViewController.loadUrl(url);
    }
  }
}
