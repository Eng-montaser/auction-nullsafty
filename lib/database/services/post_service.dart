import 'package:http/http.dart' as http;

import '../api.dart';

class PostService extends BaseApi {
  Future<http.Response> register(registerData) async {
    return await api.httpPost("register", registerData);
  }

  Future<http.Response> login(loginData) async {
    return await api.httpPost("login", loginData);
  }

  Future<http.Response> logout() async {
    return await api.httpPost("logout", {});
  }

  Future<http.Response> addBid(int id, String amount) async {
    return await api.httpPost("bids", {'product_id': '$id', 'amount': amount});
  }
}
