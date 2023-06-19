import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:socialworkportal/app/data/model/file_model.dart';
import 'package:socialworkportal/master/general_utils/common_stuff.dart';
import 'package:socialworkportal/master/general_utils/custom_appbar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'home_controller.dart';
String url = '';
Uri webURi = Uri.parse("https://casework.socialworkportal.com/mobile_api");
final urlController = TextEditingController();

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

            onPrint: (controller, url) => {
              print("print_url => $url")
            },
            initialUrlRequest: URLRequest(
                url: webURi,
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
              controller.webViewController.addJavaScriptHandler(
                handlerName: "remember_me",
                callback: (data) {
                  if (data.isNotEmpty) {
                    controller.lstFileModel.clear();
                    controller.lstFileModel.value = List<FileModel>.from(
                        data.map((x) => FileModel.fromJson(x)));
                    inAppWebViewController.evaluateJavascript(source: "window.localStorage.setItem('username', '${controller.lstFileModel[0].username}');window.localStorage.setItem('password', '${controller.lstFileModel[0].password}');");

                 //   inAppWebViewController.webStorage.localStorage.setItem(key: "username", value: controller.lstFileModel[0].username);
                  //  inAppWebViewController.webStorage.localStorage.setItem(key: "password", value: controller.lstFileModel[0].password);
                  } else {

                  }
                },
              );
            },
            initialOptions: InAppWebViewGroupOptions(
              crossPlatform: InAppWebViewOptions(
                useShouldOverrideUrlLoading: true,
                  transparentBackground: true,
                  allowFileAccessFromFileURLs: true,
                  allowUniversalAccessFromFileURLs: true,
                  javaScriptCanOpenWindowsAutomatically: true,
                  useOnDownloadStart: true,
               //   useOnDownloadStart:true
              ),
            ),
            shouldOverrideUrlLoading: (controller, shouldOverrideUrlLoadingRequest) async {
              var uri = shouldOverrideUrlLoadingRequest.request.url!;
              if (uri.scheme.startsWith("tel") || uri.scheme.startsWith("mailto")) {
                print("tel url: ${uri}");
                await launchUrl(
                   uri,
                  mode: LaunchMode.externalNonBrowserApplication
                );
                return NavigationActionPolicy.CANCEL;
              }else if(!uri.host.startsWith('casework.socialworkportal') && !uri.host.contains('stripe')){
                await launchUrl(
                    uri,
                    mode: LaunchMode.externalApplication
                );
                return NavigationActionPolicy.CANCEL;
              }
              return NavigationActionPolicy.ALLOW;
            },
            onLoadStart: (inAPpWebViewController, url) {
              print("started to load: $url");

              EasyLoaderAnimation.showEasyLoader();
              CookieManager.instance().setCookie(url: webURi, name: "mobile_api", value: "1");
            },
            onLoadStop: (inAPpWebViewController, url) async {
              EasyLoading.dismiss();


                await inAPpWebViewController.evaluateJavascript(source: ""
                    "if(document.querySelector('#txtUsername') != null) {"
                    "if(window.localStorage.getItem('username')){ "
                    "document.querySelector('#txtUsername').value = window.localStorage.getItem('username');"
                    "}"
                    "if(window.localStorage.getItem('password')){"
                    "document.querySelector('#txtPassword').value= window.localStorage.getItem('password');"
                    "}"
                    "if(window.localStorage.getItem('username') && window.localStorage.getItem('password')){"
                    "document.querySelector('#remember_me').checked=true;"
                    "}"
                    "}"
                    "");


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
