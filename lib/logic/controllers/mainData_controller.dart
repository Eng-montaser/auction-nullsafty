import 'dart:async';

import 'package:auction/database/models/car_model.dart';
import 'package:get/get.dart';

import '../../database/getxApi/get_api.dart';
import '../../database/models/notifications_model.dart';
import '../../utils/utils.dart';

class MainDataController extends GetxController {
  bool dataLoading = true;
  String data='';
  String dataType='';
  MainDataController({required this.dataType});
  loadData( ) async {
    dataLoading = true;
    update();
    try {
      await FCIGetDataXApi().getPagesData(dataType).then((value) async{
        if (value != null) {
          data=value;
          dataLoading = false;
          update();
        }
      });
      dataLoading = false;
      update();
    } catch (e) {
      update();
    }
  }


  @override
  void onInit() async{
    super.onInit();
    await loadData();
  }

  @override
  void onClose() {
     super.onClose();
  }
}



