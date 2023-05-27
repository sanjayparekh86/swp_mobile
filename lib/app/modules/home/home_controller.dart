import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
//import 'package:webview_flutter/webview_flutter.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  //late final WebViewController webViewController;
  RxBool isShowLoader = false.obs;
  RxDouble progressValue = 0.0.obs;
  late InAppWebViewController webViewController;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    /*webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Get.theme.colorScheme.onPrimary)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
          },
          onPageStarted: (String url) {
            EasyLoaderAnimation.showEasyLoader();
          },
          onPageFinished: (String url) {
            EasyLoading.dismiss();
          },
          onWebResourceError: (WebResourceError error) {},
        ),
      )
      ..loadRequest(Uri.parse('https://staging1.socialworkportal.com'));*/
  }
}
