import 'dart:io';

import 'package:http/http.dart' as http;

import '../api.dart';

class PostService extends BaseApi {
  Future<http.Response> register(registerData) async {
    return await api.httpPost("register", registerData);
  }

  Future<http.Response> login(loginData) async {
    return await api.httpPost("login", loginData);
  }

  Future<http.Response> changePassword(changePasswordData) async {
    return await api.httpPost("change_password", changePasswordData);
  }

  Future<http.Response> logout() async {
    return await api.httpPost("logout", {});
  }

  Future<http.Response> addBid(int id, String amount) async {
    return await api.httpPost("bids", {'product_id': '$id', 'amount': amount});
  }

  Future<http.Response> setFCMToken(String fcmToken) async {
    return await api.httpPost("fcm", {'fcm_token': fcmToken});
  }

  Future<http.Response> updateProfileData(File? imagePath, updateData) async {
    if (imagePath != null) {
      return await api.httpPostWithFile("update", updateData, file: imagePath);
    } else {
      return await api.httpPost("update", updateData);
    }
  }

  Future<http.Response> addCar(List<File> images, data) async {
    if (images.length > 0) {
      return await api.httpPostWithFiles("products", data, filesList: images);
    } else {
      return await api.httpPost("products", data);
    }
  }
}
