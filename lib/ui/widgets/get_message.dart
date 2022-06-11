import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/FCIStyle.dart';

GetMessage( title, message){
  Get.snackbar('','',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.white,
      titleText: Text(
        '${title}',
        style: FCITextStyle.bold(15,
            color: FCIColors.primaryColor()),
      ),
      messageText: Text(
        '${message}',
        style: FCITextStyle.bold(15,
            color: FCIColors.primaryColor()),
      ));
}