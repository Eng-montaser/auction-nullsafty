import 'dart:async';
import 'dart:convert';

import 'package:auction/database/models/car_model.dart';
import 'package:auction/logic/controllers/car_controller.dart';
import 'package:auction/utils/utils.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

import '../../database/services/get_service.dart';
import 'package:timezone/standalone.dart' as tz;
var dubai = tz.getLocation('Asia/Dubai');
class CarDetailsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late CarModel carData;

  CarDetailsController({required this.carData });
  @override
  void onInit() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    getCarDetails(carData.id);
    getTimeOfAuction();
    Timer.periodic(Duration(seconds: 1), (timer) {
      getTimeOfAuction();
    });
    super.onInit();
  }

  late AnimationController controller;
  int selectedImageIndex = 0;
  RxString liveDuration = ''.obs;
  CarsStatus carsStatus = CarsStatus.all;
  DateTime time = tz.TZDateTime.now(dubai);
  CarDetails carDetails = CarDetails();
  decrementImageIndex() {
    if (selectedImageIndex > 0) {
      selectedImageIndex--;
      if (!controller.isAnimating) {
        if (controller.isDismissed) {
          controller.forward();
        } else {
          controller.reverse();
        }
      }
    }
    update();
  }

  incrementImageIndex() {
    selectedImageIndex < carData.images.length - 1
        ? selectedImageIndex++
        : selectedImageIndex = carData.images.length - 1;
    update();
  }

  getTimeOfAuction() {
    if (carData.start_date.isNotEmpty && carData.end_date.isNotEmpty) {
      carsStatus=Utils().getTypeOfAuction(
        start_date: carData.start_date,
        end_date: carData.end_date
      );
      if(carsStatus==CarsStatus.upComing){
        liveDuration.value = "Start after  ${Utils().printDuration(Utils().getUpcomingDuration(carData.start_date))} ";
      }else if(carsStatus==CarsStatus.live){
        liveDuration.value = "End after  ${Utils().printDuration(Utils().getLiveDuration(carData.end_date))} ";
      }else{
        liveDuration.value="";
      }
    }else{
      liveDuration.value="";
    }
    update();
  }

  getCarDetails(int _id) async {
    GetService _getService = new GetService();
    try {
      await _getService.getcarDetails(_id).then((response) async {
        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);

          if (data['success']) {
            carDetails = CarDetails.fromJosn(data['data']);
            carData = CarModel.fromJosn(data['data']);
            update();
          }


        } else {
          print(response.statusCode);
          update();
        }
      });
    } catch (e) {
      print(e);
      update();
    }
    update();
  }

  // format(Duration d) => d.toString().split('.').first.padLeft(8, "0");
  @override
  void onClose() {

    super.onClose();
  }

  @override
  void didChangeDependencies(BuildContext context) {
    print('get from readys');
  }
}
