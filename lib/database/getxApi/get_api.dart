import 'dart:convert';

import 'package:auction/database/models/car_model.dart';
import 'package:auction/database/services/get_service.dart';

class FCIGetDataXApi {
  Future<List<CarModel>?> getAllCars() async {
    List<CarModel>? carmodels;
    try {
      await GetService().getAllCars().then((response) {
        if (response.statusCode == 200 || response.statusCode == 201) {
          carmodels = [];
          var data = jsonDecode(response.body);
          if (data['success'])
            for (var car in data['data']) {
              carmodels?.add(CarModel.fromJosn(car));
            }
        }
      });
    } catch (e) {
      print('rrer $e');
    }
    return carmodels;
  }

  Future<List<CarModel>?> getRunning() async {
    List<CarModel>? carmodels;
    await GetService().getRunningCars().then((response) {
      if (response.statusCode == 200 || response.statusCode == 201) {
        // print('sss ${response.body}');
        //(response.body);
        carmodels = [];
        var data = jsonDecode(response.body);
        if (data['success'])
          for (var car in data['data']) {
            carmodels?.add(CarModel.fromJosn(car));
          }
      }
    });
    return carmodels;
  }

  Future<List<CarModel>?> getUpcoming() async {
    List<CarModel>? carmodels;
    await GetService().getUpcomingCars().then((response) {
      if (response.statusCode == 200 || response.statusCode == 201) {
        // print('sss ${response.body}');
        //(response.body);
        carmodels = [];
        var data = jsonDecode(response.body);
        if (data['success'])
          for (var car in data['data']) {
            carmodels?.add(CarModel.fromJosn(car));
          }
      }
    });
    return carmodels;
  }

  Future<List<CarModel>?> getExpired() async {
    List<CarModel>? carmodels;
    await GetService().getExpiredCars().then((response) {
      if (response.statusCode == 200 || response.statusCode == 201) {
        // print('sss ${response.body}');
        //(response.body);
        carmodels = [];
        var data = jsonDecode(response.body);
        if (data['success'])
          for (var car in data['data']) {
            carmodels?.add(CarModel.fromJosn(car));
          }
      }
    });
    return carmodels;
  }

  Future<CarDetails?> getCarDetails(int id) async {
    CarDetails? carDetails;
    await GetService().getcarDetails(id).then((response) {
      if (response.statusCode == 200 || response.statusCode == 201) {
        // print('sss ${response.body}');
        //(response.body);

        var data = jsonDecode(response.body);
        if (data['success']) carDetails = CarDetails.fromJosn(data['data']);
      }
    });
    return carDetails;
  }

  //////////////////////////
  Future<List<dynamic>> getMake() async {
    List<dynamic> makeList = [];
    await GetService().getMake().then((response) {
      if (response.statusCode == 200 || response.statusCode == 201) {
        //(response.body);

        final Map<String, dynamic> data = jsonDecode(response.body)['data'];
        makeList = data.values.toList();
      }
    });
    return makeList;
  }

  Future<List<dynamic>> getModel(String make) async {
    List<dynamic> makeList = [];
    await GetService().getModel(make).then((response) {
      if (response.statusCode == 200 || response.statusCode == 201) {
        // print('sss ${response.body}');
        //(response.body);

        final Map<String, dynamic> data = jsonDecode(response.body)['data'];
        makeList = data.values.toList();
      }
    });
    return makeList;
  }

  Future<List<dynamic>> getYear(String make, String model) async {
    List<dynamic> makeList = [];
    await GetService().getYear(make, model).then((response) {
      if (response.statusCode == 200 || response.statusCode == 201) {
        // print('sss ${response.body}');
        //(response.body);

        final Map<String, dynamic> data = jsonDecode(response.body)['data'];
        makeList = data.values.toList();
      }
    });
    return makeList;
  }
}
