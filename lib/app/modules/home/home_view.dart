import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:socialworkprotal/master/general_utils/common_stuff.dart';
import 'package:socialworkprotal/master/general_utils/custom_appbar.dart';
//import 'package:webview_flutter/webview_flutter.dart';
import 'home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        controller.webViewController.goBack();
        return false;
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: CustomAppBar.buildAppBar(
            backgroundColor: Get.theme.colorScheme.tertiary,
            elevation: 0,
          ),
        ),
        body: SafeArea(
          child: InAppWebView(
            initialUrlRequest: URLRequest(url: Uri.parse("https://staging1.socialworkportal.com/mobile_api")),
            onWebViewCreated: (InAppWebViewController inAppWebViewController){
              controller.webViewController = inAppWebViewController;
            },
            initialOptions: InAppWebViewGroupOptions(
              crossPlatform: InAppWebViewOptions(
                useOnDownloadStart: true,
                transparentBackground: true,
              ),
            ),
            onLoadStart: (inAPpWebViewController, url){
              EasyLoaderAnimation.showEasyLoader();
            },
            onLoadStop: (inAPpWebViewController, url){
              EasyLoading.dismiss();
            },
            onUpdateVisitedHistory: (inAppWebViewController, url, androidIsReload){
              print("url!.host: ${url!}");
            },
          ),
        ),
      ),
    );
  }
}
