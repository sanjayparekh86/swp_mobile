import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:socialworkprotal/app/data/model/file_model.dart';
import 'package:socialworkprotal/master/general_utils/common_stuff.dart';
import 'package:socialworkprotal/master/general_utils/custom_appbar.dart';
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
            initialUrlRequest: URLRequest(
                url: Uri.parse(
                    "https://staging1.socialworkportal.com/mobile_api"),
                headers: {"mobile_api": "1"}),
            onWebViewCreated: (InAppWebViewController inAppWebViewController) {
              controller.webViewController = inAppWebViewController;
              controller.webViewController.addJavaScriptHandler(
                handlerName: "downloadFileInApp",
                callback: (data) {
                  if (data.isNotEmpty) {
                    controller.lstFileModel.clear();
                    controller.lstFileModel.value = List<FileModel>.from(
                        data.map((x) => FileModel.fromJson(x)));
                    printInfo(info: "data: ${controller.lstFileModel.length}");
                    controller
                        .createFileFromString(
                            controller.lstFileModel[0].content,
                            controller.lstFileModel[0].ext,
                            controller.lstFileModel[0].name)
                        .then((value) async {});
                  } else {
                    controller.lstFileModel.clear();
                  }
                },
              );
            },
            initialOptions: InAppWebViewGroupOptions(
              crossPlatform: InAppWebViewOptions(
                  transparentBackground: true,
                  allowFileAccessFromFileURLs: true,
                  allowUniversalAccessFromFileURLs: true),
            ),
            onLoadStart: (inAPpWebViewController, url) {
              print("started to load: $url");
              EasyLoaderAnimation.showEasyLoader();
              CookieManager.instance().setCookie(url: Uri.parse(
                  "https://staging1.socialworkportal.com"), name: "mobile_api", value: "1");
            },
            onLoadStop: (inAPpWebViewController, url) {
              EasyLoading.dismiss();
         //     inAPpWebViewController.webStorage.sessionStorage.setItem(key: "mymobile_view", value: "1");
            },
            /*onDownloadStart: (controller, url) async {
              print("url: ${url}");
              final filename = url.toString().substring(url.toString().lastIndexOf("/") + 1);
              var dir = await getExternalStorageDirectory();
              if(dir != null){
                 */ /*await FlutterDownloader.enqueue(
                  url: url.toString(),
                  fileName: filename,
                  saveInPublicStorage: true,
                  savedDir: dir.path,
                  showNotification: true, // show download progress in status bar (for Android)
                  openFileFromNotification: true, // click on notification to open downloaded file (for Android)
                );*/ /*
              }

            },*/
            onUpdateVisitedHistory:
                (inAppWebViewController, url, androidIsReload) {
              print("url!.host: ${url!.origin}");
            },
          ),
        ),
      ),
    );
  }
}
