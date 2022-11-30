import 'dart:async';

import 'package:auction/database/models/car_model.dart';
import 'package:get/get.dart';

import '../../database/getxApi/get_api.dart';

class CarController extends GetxController {
  bool allCarsLoading = true;
  bool upComingLoading = true;
  bool runningLoading = true;
  List<CarModel> _allCars = [];
  List<CarModel> _upComingCars = [];
  List<CarModel> _runningCars = [];
  getData(CarStatus carStatus) {
     List<CarModel> returnData = [];
    switch (carStatus) {
      case CarStatus.all:
        returnData= _allCars;
        break;
      case CarStatus.upComing:
        returnData= _upComingCars;
      break;
      case CarStatus.live:
        returnData= _runningCars;
         break;
    }
    return returnData;
  }

  Future<List<CarModel>> loadAllCars(bool loading) async {
    if (loading) allCarsLoading = true;
    update();
    try {
      await FCIGetDataXApi().getAllCars().then((value) async{
        if (value != null) {
          _allCars = value;
          update();

        }
      });
      allCarsLoading = false;
      update();
      return _allCars;
    } catch (e) {
      allCarsLoading = false;
      update();
      return <CarModel>[];
    }
  }

  Future<List<CarModel>> loadUpComingCars(bool loading) async {
    if (loading) upComingLoading = true;
    update();
    try {
      await FCIGetDataXApi().getUpcoming().then((value) {
        if (value != null) {
          _upComingCars = value;
          update();
        }
      });
      upComingLoading = false;
      update();
      return _upComingCars;
    } catch (e) {
      upComingLoading = false;
      update();
      return <CarModel>[];
    }
  }

  Future<List<CarModel>> loadRunningCars(bool loading) async {
    if (loading) runningLoading = true;
    update();
    try {
      await FCIGetDataXApi().getRunning().then((value) async{
        if (value != null) {
          _runningCars = value;
          update();

        }
      });
      runningLoading = false;
      update();
      return _runningCars;
    } catch (e) {
      runningLoading = false;
      update();
      return <CarModel>[];
    }
  }

  @override
  void onInit() async{
    super.onInit();
    await loadRunningCars(true);
   /* await loadUpComingCars(true);
    await   loadAllCars(true);*/

  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}

enum CarStatus { all, upComing, live, expired }
