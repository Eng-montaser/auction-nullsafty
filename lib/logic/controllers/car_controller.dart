import 'package:auction/database/models/car_model.dart';
import 'package:auction/utils/FCIStyle.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../database/getxApi/get_api.dart';

class CarController extends GetxController{
  bool allCarsLoading=true;
  bool upComingLoading=true;
  bool runningLoading=true;
  List<CarModel> _allCars = [];
  List<CarModel> _upComingCars = [];
  List<CarModel> _runningCars = [];
  getData(CarStatus carStatus){
    switch(carStatus){
      case CarStatus.all:
        return _allCars;
        break;
      case CarStatus.upComing:
        return _upComingCars;
        break;
      case CarStatus.live:
        return _runningCars;
        break;
    }
  }
  Future<List<CarModel>> loadAllCars() async {
 _allCars = [];
 allCarsLoading=true;
 update();
 update();
    try {
      await FCIGetDataXApi().getAllCars().then((value) {
        // print('cval $value');
        if (value != null) {
          //  print('cval ${value.length}');
          _allCars = value;
          update();
        }
      });
      allCarsLoading=false;
      update();
      return _allCars;
    } catch (e) {
      allCarsLoading=false;
      update();
      return <CarModel>[];
    }
  }

  Future<List<CarModel>> loadRunningCars() async {
    _runningCars = [];
    runningLoading=true;
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
      runningLoading=false;
      update();
      return _runningCars;
    } catch (e) {
      runningLoading=false;
      update();
      return <CarModel>[];
    }
  }

  Future<List<CarModel>> loadUpComingCars() async {

    _upComingCars= [];
    upComingLoading=true;
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
      upComingLoading=false;
      update();
      return _upComingCars;

    } catch (e) {
      upComingLoading=false;
      update();
      return <CarModel>[];
    }
  }
  @override
  void onInit() {
    loadAllCars();
    loadUpComingCars();
    loadRunningCars();
    super.onInit();
  }
  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
enum CarStatus{
  all,
  upComing,
  live,
  expired
}