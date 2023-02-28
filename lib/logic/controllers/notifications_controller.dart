import 'dart:async';

import 'package:auction/database/models/car_model.dart';
import 'package:get/get.dart';

import '../../database/getxApi/get_api.dart';
import '../../database/models/notifications_model.dart';
import '../../utils/utils.dart';

class NotificationsController extends GetxController {
  bool notificationsLoading = true;
  List<NotificationsModel>  notificationsDataList = [];
      loadNotifications( ) async {
       notificationsLoading = true;
    update();
    try {
      await FCIGetDataXApi().getNotifications().then((value) async{
        if (value != null) {
          notificationsDataList = value;
          update();
        }
      });
      notificationsLoading = false;
      update();
    } catch (e) {
      update();
    }
  }


  @override
  void onInit() async{
    super.onInit();
    await loadNotifications();
  }

  @override
  void onClose() {
     super.onClose();
  }
}


