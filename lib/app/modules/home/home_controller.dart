import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:socialworkportal/app/data/model/file_model.dart';
import 'package:socialworkportal/master/general_utils/notification_controller.dart';
import 'package:url_launcher/url_launcher.dart';


class HomeController extends GetxController {
  //TODO: Implement HomeController
  RxBool isShowLoader = false.obs;
  late InAppWebViewController webViewController;
  RxList<FileModel> lstFileModel = <FileModel>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    AwesomeNotifications().setListeners(
        onActionReceivedMethod:         NotificationController.onActionReceivedMethod,
        onNotificationCreatedMethod:    NotificationController.onNotificationCreatedMethod,
        onNotificationDisplayedMethod:  NotificationController.onNotificationDisplayedMethod,
        onDismissActionReceivedMethod:  NotificationController.onDismissActionReceivedMethod
    );
  }

  void sendNotification(filePath, fileName) async {
    bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) {
      //no permission of local notification
      AwesomeNotifications().requestPermissionToSendNotifications();
    }else{
      //show notification
      AwesomeNotifications().createNotification(
          content: NotificationContent(
            id: 123,
            channelKey: 'basic',
            title: 'File Downloaded Successfully',
            body: fileName,
            summary: filePath,
            badge: 0

          )
      );
    }
  }

  Future<String> createFileFromString(base64String, fileType, fileName) async {
    Uint8List bytes = base64.decode(base64String);
    Directory directory = Directory("");
    if (Platform.isAndroid) {
      directory = Directory("/storage/emulated/0/Download");
    } else {
      directory = await getApplicationDocumentsDirectory();
    }
    final exPath = directory.path;
    await Directory(exPath).create(recursive: true);
    File file = File("$exPath/$fileName");
    if(await file.exists()){
      const snackBar = SnackBar(
        content: Text('Already Downloaded'),
      );
      ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
    }else{
      await file.writeAsBytes(bytes);
      sendNotification(file.path, fileName);
    }
    return file.path;
  }
}


