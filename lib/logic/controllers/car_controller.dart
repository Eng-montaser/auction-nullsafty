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
    // List<CarModel> returnData = [];
    switch (carStatus) {
      case CarStatus.all:
        return _allCars;
      //  break;
      case CarStatus.upComing:
        return _upComingCars;
      //break;
      case CarStatus.live:
        return _runningCars;
      //   break;

    }
    return [];
  }

  Future<List<CarModel>> loadAllCars(bool loading) async {
    if (loading) allCarsLoading = true;
    update();
    try {
      await FCIGetDataXApi().getAllCars().then((value) {
        if (value != null) {
          print('cval ${value.length}');
          _allCars = value;
          print('cval2 ${value.length}');

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
        // print('cval $value');
        if (value != null) {
          // print('cval ${value.length}');
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
      await FCIGetDataXApi().getRunning().then((value) {
        // print('cval $value');
        if (value != null) {
          // print('cval ${value.length}');
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


    // Timer.periodic(Duration(seconds: 15), (timer) {
    //   loadAllCars(false);
    //   loadUpComingCars(false);
    //   loadRunningCars(false);
    // });
    super.onInit();
    await loadRunningCars(true);
    loadAllCars(true);
    loadUpComingCars(true);
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}

enum CarStatus { all, upComing, live, expired }
