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
// Future<http.Response> getNotifications() async {
//   return await api.httpGetByToken('notifications');
// }
//
// Future<http.Response> getAddressesData() async {
//   return await api.httpGetByToken('addresses');
// }
//
// Future<http.Response> getOrders() async {
//   return await api.httpGetByToken('orders');
// }
}
