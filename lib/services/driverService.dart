import 'package:http/http.dart' as http;
import 'api.dart';

class DriverService {
  static String jwt;
  static get header => {"Authorization": 'Bearer $jwt'};

  static postTest() {
    return http.read('${API.base}/driver/', headers: header);
  }
}
