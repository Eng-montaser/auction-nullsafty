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
  Future<http.Response> updateProfileData(File? imagePath, updateData) async {
    print('In updateProfileData');
    if(imagePath!=null) {
      print('Image NOOOO  Nulllll');
      return await api.httpPostWithFile("update", updateData, file: imagePath);
    }else{
      print('Image Data Nulllll');
      return await api.httpPost("update", updateData);
    }
  }
}