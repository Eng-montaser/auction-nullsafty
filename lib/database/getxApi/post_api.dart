import 'dart:io';

import 'package:auction/database/services/post_service.dart';
import 'package:http/http.dart' as http;

class FCIPostDataXApi {
  Future<http.Response?> addBid(int id, String amount) async {
    //   http.Response res
    try {
      await PostService().addBid(id, amount).then((response) {
         if (response.statusCode == 200 || response.statusCode == 201) {
          return (response);
        }
      });
    } catch (e) {
      print('$e');
    }
  }

  Future<http.Response?> addCar(List<File> images, data) async {
    http.Response? res;
    try {
      await PostService().addCar(images, data).then((response) {
        if (response.statusCode == 200 || response.statusCode == 201) {
          res = response;
        }
      });
    } catch (e) {
      print('$e');
    }
    return res;
  }

  Future<http.Response?> setFCMToken(String token) async {
    http.Response? res;
    try {
      await PostService().setFCMToken(token).then((response) {
        if (response.statusCode == 200 || response.statusCode == 201) {
          res = response;
        }
      });
    } catch (e) {
      print('$e');
    }
    return res;
  }
}
