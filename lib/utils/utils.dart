import 'package:auction/logic/controllers/car_controller.dart';
import 'package:auction/utils/FCIStyle.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:intl/intl.dart';

import 'package:timezone/standalone.dart' as tz;
import 'package:timezone/timezone.dart';

var dubai = tz.getLocation('Asia/Dubai');
class Utils {
   static Widget loading() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircularProgressIndicator(color: FCIColors.primaryColor()),
      ) /* Image.asset(
        'assets/images/loading.gif',
        width: ScreenUtil().setWidth(100),
        height: ScreenUtil().setHeight(100),
        fit: BoxFit.fill,
      )*/
      ,
    );
  }

  static Widget loadingTow(width) {
    return Center(
      child: Image.asset(
        'assets/images/loading.gif',
        width: ScreenUtil().setWidth(width),
        height: ScreenUtil().setWidth(width),
        fit: BoxFit.fill,
      ),
    );
  }

//  static Future<File> selectImageAndCrop(
//      BuildContext context, String activityTitle) async {
//    PickedFile pickedFile = await ImagePicker().getImage(
//      source: ImageSource.gallery,
//    );
//    //crop
//    File croppedImage;
//    if (pickedFile != null) {
//      croppedImage = await ImageCropper.cropImage(
//          sourcePath: pickedFile.path,
//          aspectRatioPresets: [
//            CropAspectRatioPreset.square,
//            CropAspectRatioPreset.ratio3x2,
//            CropAspectRatioPreset.original,
//            CropAspectRatioPreset.ratio4x3,
//            CropAspectRatioPreset.ratio16x9
//          ],
//          androidUiSettings: AndroidUiSettings(
//              toolbarTitle: activityTitle,
//              toolbarColor: Theme.of(context).primaryColor,
//              toolbarWidgetColor: Colors.white,
//              initAspectRatio: CropAspectRatioPreset.original,
//              lockAspectRatio: false),
//          iosUiSettings: IOSUiSettings(
//            minimumAspectRatio: 1.0,
//          ));
//      print(croppedImage.path);
//    }
//    showNotification(text: croppedImage.path, color: Colors.green);
//    return croppedImage;
//  }
  showMessage(
    context,
    String title,
    String desc,
    bool success,
  ) {
    AwesomeDialog(
        context: context,
        animType: AnimType.LEFTSLIDE,
        headerAnimationLoop: false,
        dialogType: success ? DialogType.SUCCES : DialogType.ERROR,
        dismissOnBackKeyPress: false,
        dismissOnTouchOutside: false,
        title: title,
        desc: desc,
        btnOkText: "ok",
        btnOkColor: success ? Color(0xff00d164) : Colors.red,
        btnOkOnPress: () {
          Get.back();
        },
        onDissmissCallback: (type) {})
      ..show();
  }

  showMessageInfo(
    context,
    String title,
    String desc,
  ) {
    AwesomeDialog(
        context: context,
        animType: AnimType.LEFTSLIDE,
        headerAnimationLoop: false,
        dialogType: DialogType.INFO,
        dismissOnBackKeyPress: false,
        dismissOnTouchOutside: false,
        title: title,
        desc: desc,
        btnOkText: "ok",
        //  btnOkColor: success ? Color(0xff00d164) : Colors.red,
        btnOkOnPress: () {
          Get.back();
        },
        onDissmissCallback: (type) {})
      ..show();
  }
  // Duration calculateDur(String end_date) {
  //   var dateNow = tz.TZDateTime.now(dubai);
  //
  //   if (end_date != null && end_date.isNotEmpty) {
  //     if(intl.DateFormat('yyyy-mm-dd hh:mm:ss').parse(end_date).isAfter(intl.DateFormat('yyyy-mm-dd hh:mm:ss').parse(dateNow.toString())))
  //
  //        return intl.DateFormat('yyyy-mm-dd hh:mm:ss').parse(end_date).difference(intl.DateFormat('yyyy-mm-dd hh:mm:ss').parse(dateNow.toString()));
  //
  //     else
  //       return Duration(seconds: 0);
  //
  //   }
  //   return Duration(seconds: 0);
  // }
  //
  // CarsStatus getTimeOfAuction(start_date,end_date) {
  //   CarsStatus carStatus;
  //    var dateNow = tz.TZDateTime.now(dubai);
  //   if (start_date.isNotEmpty && end_date.isNotEmpty) {
  //     if ( intl.DateFormat('yyyy-mm-dd hh:mm:ss').parse(dateNow.toString()).isBefore(intl.DateFormat('yyyy-mm-dd hh:mm:ss')
  //         .parse( start_date.toString()))) {
  //       print('Now ${ dateNow.toString() }');
  //       print('start_date: ${start_date}');
  //       print('end_date: ${end_date}');
  //       carStatus = CarsStatus.upComing;
  //     } else if (( intl.DateFormat('yyyy-mm-dd hh:mm:ss').parse(dateNow.toString()).isBefore(intl.DateFormat('yyyy-mm-dd hh:mm:ss')
  //         .parse( end_date)))) {
  //       carStatus = CarsStatus.live;
  //     } else {
  //       carStatus = CarsStatus.expired;
  //     }
  //   }
  //   else {
  //     carStatus =CarsStatus.all;
  //   }
  //   return carStatus;
  // }
  String printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitDays = twoDigits(duration.inDays.remainder(31));
    String twoDigitHours = twoDigits(duration.inHours.remainder(24));
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitDays ${duration.inDays.remainder(31)>0?'Days':''} $twoDigitHours:$twoDigitMinutes:$twoDigitSeconds";
    }

  DateTime  getTimeZoneNow() {
    var time=tz.TZDateTime.now( dubai);
    return  DateTime (time.year,time.month,time.day,time.hour,time.minute,time.second);
  }
  CarsStatus getTypeOfAuction({start_date, end_date}) {
    if (start_date.isNotEmpty && end_date.isNotEmpty) {
      if ( Utils().getTimeZoneNow().isBefore(DateTime.parse(start_date) )) {
        return  CarsStatus.upComing;
      } else if ( Utils().getTimeZoneNow().isBefore(DateTime.parse(end_date))){
        return CarsStatus.live;
      } else {
        return CarsStatus.expired;
      }
    }
    else {
      return CarsStatus.all;
    }
  }
  Duration getLiveDuration(String end_date) {
    if ((end_date != null && end_date.isNotEmpty)||
          getTimeZoneNow().isBefore(DateTime.parse(end_date))) {
        return DateTime.parse(end_date).difference(getTimeZoneNow());
    }
    return Duration(seconds: 0);
  }
  Duration getUpcomingDuration(String start_date) {
    if ((start_date != null && start_date.isNotEmpty)||
        getTimeZoneNow().isBefore(DateTime.parse(start_date))) {
      return DateTime.parse(start_date).difference(getTimeZoneNow());
    }
    return Duration(seconds: 0);
  }
}
