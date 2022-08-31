import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Utils {
  static Widget loading() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircularProgressIndicator(),
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
}
