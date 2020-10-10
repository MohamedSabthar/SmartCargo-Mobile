import 'dart:convert';

import 'package:Smart_Cargo_mobile/services/authService.dart';
import 'package:http/http.dart' as http;
import 'api.dart';

class DriverService {
  static String jwt;
  static get header => {"Authorization": 'Bearer $jwt'};

  static Future getSchedules() async {
    jwt = await AuthService.token();
    var res = await http.get('${API.base}/driver/', headers: header);
    return res.statusCode == 200
        ? json.decode(res.body)
        : " ";
  }
}
