import 'dart:io';

import 'package:auction/logic/controllers/auth_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class BaseApi {
  Api api = Api();
}

class Api {
  static final _api = Api._internal();

  factory Api() {
    return _api;
  }
  Api._internal();

  ///*****************************************************
  ///    set Api Url
  ///*****************************************************
//https://demo.treblle.com/api/v1/
//  String path = '/api/v2/client';
//   https://tradeinsolutions.ae/auction/api/register
  String baseUrl = 'tradeinsolutions.ae';
  String path = '/auction/api';

  ///*****************************************************
  ///    set Headers
  ///*****************************************************
  getHeaders() {
    AuthenticationController authenticationController =
        Get.put(AuthenticationController());
    authenticationController.getUserData();
    String token =authenticationController.userData?.token??'';
    print("/*/*/*/*/* ${token}");
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    };
    return headers;
  }

  ///*****************************************************
  ///    Http Get
  ///*****************************************************
  Future<http.Response> httpGet(String endPath,
      {Map<String, String>? query}) async {
    Uri uri = Uri.https(baseUrl, '$path/$endPath');
    if (query != null) {
      uri = Uri.https(baseUrl, '$path/$endPath', query);
    }
    return http.get(uri, headers: getHeaders());
  }

  ///*****************************************************
  ///    Http Post
  ///*****************************************************
  Future<http.Response> httpPost(String endPath, Object body) async {
    Uri uri = Uri.https(baseUrl, '$path/$endPath');
    print('uri ${body.toString()}');
    return http.post(uri, body: body, headers: getHeaders());
  }

  ///*****************************************************
  ///    Http Post With One File
  ///*****************************************************
  Future<http.Response> httpPostWithFile(
      String endPath, Map<String, String> body,
      {File? file}) async {
    Uri uri = Uri.https(baseUrl, '$path/$endPath');
    var length = await file?.length();


    print('BBBBBBBBBBEEEEEEEGINNNNNNNNNNNNNNNNNNNN');
    print(file.toString());
    print(file?.path.toString());
    print('EEEEEEEEEEEEEEEEEEENNNNNNNNNNNNDDDDDDDD');
    http.MultipartRequest request = new http.MultipartRequest('POST', uri)
      ..headers.addAll(getHeaders())
      ..fields.addAll(body)
      ..files.add(
        ///set name parametter of file in api
        http.MultipartFile('image', file!.openRead(), length??0,
            filename: basename(file.path)),
      );
    return await http.Response.fromStream(await request.send())
        .timeout(Duration(seconds: 10));
  }

  ///*****************************************************
  ///    Http Post With List Of Files
  ///*****************************************************
  Future<http.Response> httpPostWithFiles(
      String endPath, Map<String, String> body,
      {List<File>? filesList}) async {
    List<http.MultipartFile> multipartFilesList = [];
    Uri uri = Uri.https(baseUrl, '$path/$endPath');
    for (var file in filesList!) {
      print(file.path);
      var length = await file.length();
      multipartFilesList.add(http.MultipartFile(

          ///set name parametter of file in api
          'trade_licence[]',
          file.openRead(),
          length,
          filename: basename(file.path)));
    }
    http.MultipartRequest request = new http.MultipartRequest('POST', uri)
      ..headers.addAll(getHeaders())
      ..fields.addAll(body)
      ..files.addAll(multipartFilesList);
    return await http.Response.fromStream(await request.send());
  }
}
