import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class EasyLoaderAnimation{
  static void showEasyLoader(){
    EasyLoading.instance
      ..displayDuration = const Duration(seconds: 3)
      ..indicatorType = EasyLoadingIndicatorType.circle
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 70.0
      ..radius = 10.0
      ..progressColor = Colors.transparent
      ..backgroundColor = Colors.transparent
      ..boxShadow =<BoxShadow>[]
      ..indicatorColor = Get.theme.colorScheme.primary
      ..textColor = Colors.white
      ..textStyle = const TextStyle(fontSize:22,fontStyle: FontStyle.italic)
      ..maskColor = Colors.grey.withOpacity(0.5)
      ..userInteractions = false
      ..maskType = EasyLoadingMaskType.custom;
    EasyLoading.show();
  }
}