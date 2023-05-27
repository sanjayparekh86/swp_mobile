import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomAppBar{
  static buildAppBar({
    Widget? leadingWidget,
    bool automaticallyImplyLeading = true,
    String title = '',
    Color? backgroundColor,
    double? elevation,
    List<Widget>? actionWidget,
    bool? centerTitle,
    SystemUiOverlayStyle? systemOverlayStyle,
    bool? isCustomTitle = false,
    Widget? customTitleWidget,
    PreferredSizeWidget? bottomWidet,
    double? leadingWidth,
  }){
    return AppBar(
      leading: leadingWidget,
      leadingWidth: leadingWidth,
      systemOverlayStyle: systemOverlayStyle,
      automaticallyImplyLeading: automaticallyImplyLeading,
      title: isCustomTitle! ?
      customTitleWidget :
      Text(
        title,
        maxLines: 2,
      ),
      backgroundColor: backgroundColor,
      elevation: elevation,
      actions: actionWidget,
      centerTitle: centerTitle ?? false,
      bottom: bottomWidet,
    );
  }
}