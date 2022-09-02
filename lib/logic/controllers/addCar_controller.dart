import 'dart:convert';
import 'dart:io';

import 'package:auction/database/getxApi/post_api.dart';
import 'package:auction/ui/add_car/AddPreview.dart';
import 'package:auction/utils/FCIStyle.dart';
import 'package:auction/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../database/getxApi/get_api.dart';

class AddCarController extends GetxController {
  //RxList<dynamic> makeList=<dynamic>[].obs;
  RxList<DropdownMenuItem<String>> makesItems =
      <DropdownMenuItem<String>>[].obs;
  RxList<DropdownMenuItem<String>> modelsItems =
      <DropdownMenuItem<String>>[].obs;
  RxList<DropdownMenuItem<String>> yearsItems =
      <DropdownMenuItem<String>>[].obs;
  RxList<DropdownMenuItem<String>> trimList = <DropdownMenuItem<String>>[
    DropdownMenuItem(child: Text("Full Option"), value: "Full Option"),
    DropdownMenuItem(child: Text("Mid Option"), value: "Mid Option"),
    DropdownMenuItem(child: Text("Basic Option"), value: "Basic Option"),
  ].obs;
  String make = '',
      model = '',
      year = '',
      mileago = '0',
      trim = '',
      color = '',
      type = '1';
  Color colorValue = Colors.grey;
  List<File> images = [];
  var isLoading = false.obs;
  getMakes() async {
    isLoading.value = true;

    update();
    try {
      FCIGetDataXApi().getMake().then((value) {
        // print('cval $value');

        if (value.length > 0) {
          makesItems.value.clear();
          value.forEach((element) {
            makesItems.value.add(
                DropdownMenuItem(child: Text("$element"), value: "$element"));
          });
          make = value[0].toString();
          getModels(value[0].toString());
          update();
        }
      });
      isLoading.value = false;
      update();
    } catch (e) {
      isLoading.value = false;
      update();
    }
  }

  getModels(String make) async {
    isLoading.value = true;
    update();
    try {
      FCIGetDataXApi().getModel(make).then((value) {
        // print('cval $value');

        if (value.length > 0) {
          modelsItems.value.clear();
          value.forEach((element) {
            modelsItems.value.add(
                DropdownMenuItem(child: Text("$element"), value: "$element"));
          });
          model = value[0].toString();
          getYears(make, value[0].toString());
          update();
        }
      });
      isLoading.value = false;
      update();
    } catch (e) {
      isLoading.value = false;
      update();
    }
  }

  getYears(String make, String model) async {
    isLoading.value = true;
    update();
    try {
      FCIGetDataXApi().getYear(make, model).then((value) {
        // print('cval $value');

        if (value.length > 0) {
          yearsItems.value.clear();
          value.forEach((element) {
            yearsItems.value.add(
                DropdownMenuItem(child: Text("$element"), value: "$element"));
          });
          year = value[0].toString();
          update();
        }
      });
      isLoading.value = false;
      update();
    } catch (e) {
      isLoading.value = false;
      update();
    }
  }

  @override
  void onInit() {
    trim = trimList[0].value.toString();
    getMakes();

    super.onInit();
  }

  showPreview() {
    if (make.isNotEmpty &&
        model.isNotEmpty &&
        year.isNotEmpty &&
        trim.isNotEmpty &&
        mileago.isNotEmpty &&
        type.isNotEmpty &&
        // _color.toString().isNotEmpty &&
        images.length > 0)
      Get.to(() => AddPreview(
          make: make,
          model: model,
          year: year,
          mileago: mileago,
          trim: trim,
          color: '${colorValue.value}',
          type: type,
          image: File(images[0].path)));
    else
      Get.snackbar('Error', 'Fill all data',
          backgroundColor: FCIColors.primaryColor(),
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
  }

  addCar(context, data) {
    isLoading.value = true;
    update();
    FCIPostDataXApi().addCar(images, data).then((value) {
      isLoading.value = false;
      update();
      if (value != null) {
        var res = jsonDecode(value.body);
        if (res['success']) {
          // reset();

          Utils().showMessage(context, 'success', res['message'], true);
        }
      }
    });
  }

  reset() {
    make = '';
    model = '';
    year = '';
    mileago = '';
    trim = '';
    color = '';
    type = '';
    images.clear();
    update();
  }
}
