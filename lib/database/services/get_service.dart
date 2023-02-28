import 'package:http/http.dart' as http;

import '../api.dart';

class GetService extends BaseApi {
  Future<http.Response> getAllCars() async {
    return await api.httpGet('products');
  }

  Future<http.Response> getRunningCars() async {
    return await api.httpGet('products/running');
  }

  Future<http.Response> getUpcomingCars() async {
    return await api.httpGet('products/upcoming');
  }

  Future<http.Response> getExpiredCars() async {
    return await api.httpGet('products/expired');
  }

  Future<http.Response> getcarDetails(int id) async {
    return await api.httpGet('products/show/$id');
  }

  Future<http.Response> getMyBids() async {
    return await api.httpGet('bids');
  }

  Future<http.Response> getProfileDetails() async {
    return await api.httpGet('user/details');
  }

  //////
  Future<http.Response> getMake() async {
    return await api.httpGet('products/make');
  }

  Future<http.Response> getModel(String make) async {
    return await api.httpGet('products/models', query: {'make': make});
  }

  Future<http.Response> getYear(String make, String model) async {
    return await api
        .httpGet('products/year', query: {'make': make, 'model': model});
  }
  Future<http.Response> getWonCars() async {
    return await api.httpGet('bids/wincars');
  }

  Future<http.Response> getOutBidCars() async {
    return await api.httpGet('bids/outbidded');
  }
  Future<http.Response> getNotifications() async {
    return await api.httpGet('bids/notifcations');
  }
  Future<http.Response> getPagesData() async {
    return await api.httpGet('pages');
  }
}
