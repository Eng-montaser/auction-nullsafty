import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FCITextStyle {
  static TextStyle normal(int fontSize,
      {Color? color, String? fontFamily, double? height, FontStyle? fontStyle}) {
    return TextStyle(
        color: color != null ? color : Colors.black,
        fontFamily: fontFamily != null ? fontFamily : "Changa",
        fontWeight: FontWeight.normal,
        fontSize: ScreenUtil().setSp(fontSize),
        height: height,
        fontStyle: fontStyle != null ? FontStyle.normal : FontStyle.normal);
  }

  static TextStyle bold(int fontSize,
      {Color? color, String? fontFamily, double? height, FontStyle? fontStyle}) {
    return TextStyle(
        color: color != null ? color : Colors.black,
        fontFamily: fontFamily != null ? fontFamily : "Changa",
        fontWeight: FontWeight.bold,
        fontSize: ScreenUtil().setSp(fontSize),
        height: height,
        fontStyle: fontStyle != null ? FontStyle.normal : FontStyle.normal);
  }
}

class FCIColors {
  static Color primaryColor() => Color(0xffF14E23);
  static Color accentColor() => Color(0xffe9ecf1);
  static Color iconGrey() => Color(0xff53618b);
  static Color indicatorColor() => Color(0xff3c3575);
  static Color borderOrange() => Color(0xfff3ae61);
  static Color starGrey() => Color(0xffd5d5d5);
  static Color diverOrange() => Color(0xffcf7d60);
  static Color shadow() => Color(0xffc5b0af);
  static Color menuBack() => Color(0xff454456);
  static Color buttonGreen() => Color(0xff68b956);
  static Color textFieldBackGrey() => Color(0xfff1f1f1);
  static Color textFieldHintGrey() => Color(0xffd3d3d3);
  static Color yellowRate() => Color(0xffffba1f);
  static Color finishMark() => Color(0xff26db87);
  static Color textFieldBack() => Color(0xff001401);
  final Color facebookColor = const Color(0xff39579A);
  // final Color twitterColor = const Color(0xff00ABEA);
  // final Color instaColor = const Color(0xffBE2289);
  // final Color whatsappColor = const Color(0xff075E54);
  // final Color linkedinColor = const Color(0xff0085E0);
  // final Color githubColor = const Color(0xff202020);
  final Color googleColor = const Color(0xffDF4A32);

}

class FCISize {
  static double width(context) => MediaQuery.of(context).size.width;
  static double height(context) => MediaQuery.of(context).size.height;
}

class FCIPadding {
  static double cardMarginHorizontal = ScreenUtil().setWidth(20);
  static double cardMarginVertical = ScreenUtil().setHeight(20);
  static double textFieldPaddingHorizontal = ScreenUtil().setWidth(5);
  static double textFieldPaddingVertical = ScreenUtil().setHeight(5);
  static double cardPadding = 20;
  static EdgeInsets symmetric({double? width, double? height}) {
    return EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(width ?? 0),
        vertical: ScreenUtil().setHeight(height ?? 0));
  }

  static EdgeInsets only(
      {double? top, double? bottom, double? left, double? right}) {
    return EdgeInsets.only(
        left: ScreenUtil().setWidth(left ?? 0),
        right: ScreenUtil().setWidth(right ?? 0),
        top: ScreenUtil().setHeight(top ?? 0),
        bottom: ScreenUtil().setHeight(bottom ?? 0));
  }
}

ThemeData appTheme() {
  return ThemeData(
    primaryColor: Color(0xFFfbe4b2),
    primarySwatch: Colors.amber,
    primaryColorDark: Color(0xFFC7B285),
    primaryColorLight: Color(0xFFFCF3E1),
    accentColor: Color(0xFFA3A3A3),
    hintColor: Color(0xff8D8D8D),
    dividerColor: Color(0xffEDEDED),
    buttonColor: Color(0xff252B2E),
    scaffoldBackgroundColor: Color(0xffffffff),
    canvasColor: Color(0xffFfffff),
  );
}
