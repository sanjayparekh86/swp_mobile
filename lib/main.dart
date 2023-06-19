import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:socialworkportal/master/general_utils/app_themes.dart';

import 'app/routes/app_pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AwesomeNotifications().initialize('resource://drawable/splash_icon', [
    // notification icon
    NotificationChannel(
      channelGroupKey: 'basic_test',
      channelKey: 'basic',
      channelName: 'Basic notifications',
      channelDescription: 'Notification channel for basic tests',
      // channelShowBadge: false,
      importance: NotificationImportance.High,
      enableVibration: true,
    ),
    //add more notification type with different configuration
  ]);
  AwesomeNotifications().requestPermissionToSendNotifications();
  await Permission.storage.request();
  await Permission.manageExternalStorage.request();
  await Permission.notification.request();
  await Permission.phone.request();
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(
    GetMaterialApp(
      title: "Social Work Portal",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: AppThemes.light,
      builder: EasyLoading.init(),
    ),
  );
}
