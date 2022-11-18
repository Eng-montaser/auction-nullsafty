import 'dart:async';
import 'dart:convert';

import 'package:auction/database/models/car_model.dart';
import 'package:auction/logic/controllers/car_controller.dart';
import 'package:flutter/animation.dart';
import 'package:get/get.dart';

import '../../database/services/get_service.dart';
import 'package:timezone/standalone.dart' as tz;
var dubai = tz.getLocation('Asia/Dubai');
class CarDetailsController extends GetxController
    with SingleGetTickerProviderMixin {
  late CarModel carData;
  CarDetailsController({required this.carData});
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
  CarStatus carStatus = CarStatus.all;
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
      if (tz.TZDateTime.now(dubai).isBefore(DateTime.parse(carData.start_date))) {
        carStatus = CarStatus.upComing;
        liveDuration.value =
            "start after  ${DateTime.parse(carData.start_date).difference(tz.TZDateTime.now(dubai)).inDays}";
      } else if (tz.TZDateTime.now(dubai).isBefore(DateTime.parse(carData.end_date))) {
        carStatus = CarStatus.live;
        Duration runningDuration =
            DateTime.parse(carData.end_date).difference(tz.TZDateTime.now(dubai));
        liveDuration.value = "end after  ${_printDuration(runningDuration)} ";
      } else {
        carStatus = CarStatus.expired;
        liveDuration.value = "Expired";
      }
    }
    update();
  }

  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitDays = twoDigits(duration.inDays.remainder(24));
    String twoDigitHours = twoDigits(duration.inHours.remainder(24));
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitDays Days $twoDigitHours:$twoDigitMinutes:$twoDigitSeconds";
  }

  getCarDetails(int _id) async {
    GetService _getService = new GetService();
    try {
      await _getService.getcarDetails(_id).then((response) async {
        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);

          if (data['success']) {
            carDetails = CarDetails.fromJosn(data['data']);
          }

          update();
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
    // TODO: implement onClose
    super.onClose();
  }
}
