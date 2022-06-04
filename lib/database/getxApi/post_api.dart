import 'package:auction/database/services/post_service.dart';
import 'package:http/http.dart' as http;

class FCIPostDataXApi {
  Future<http.Response?> addBid(int id, String amount) async {
    //   http.Response res
    try {
      await PostService().addBid(id, amount).then((response) {
        print('body is ${response.body}');
        if (response.statusCode == 200 || response.statusCode == 201) {
          return (response);
        }
      });
    } catch (e) {
      print('$e');
    }
  }
}
