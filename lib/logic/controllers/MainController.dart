import 'package:auction/utils/FCIStyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  double xOffset = 0;
  double yOffset = 0;
  bool isDrawerOpen = false;
  int selectedMenuItem = 0;
  changeSideBar(context) {
    if (isDrawerOpen) {
      xOffset = 0;
      yOffset = 0;
      isDrawerOpen = false;
    } else {
      xOffset = Get.locale == Locale('en', 'US')
          ? (FCISize.width(context) - ScreenUtil().setWidth(120))
          : (-FCISize.width(context) + ScreenUtil().setWidth(240));
      yOffset = ScreenUtil().setHeight(100);
      isDrawerOpen = true;
    }
    update();
  }

  changeMenuItem(int index) {
    selectedMenuItem = index;
    update();
  }
}
