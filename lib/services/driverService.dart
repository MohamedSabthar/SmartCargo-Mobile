import 'dart:convert';

import 'package:Smart_Cargo_mobile/services/authService.dart';
import 'package:http/http.dart' as http;
import 'api.dart';

class DriverService {
  static String jwt;
  static get header => {"Authorization": 'Bearer $jwt'};

  static Future profile() async {
     jwt = await AuthService.token();
    var res = await http.get('${API.base}/driver/profile', headers: header);
    return res.statusCode == 200
        ? json.decode(res.body)
        : " ";
  }

  static Future getSchedules() async {
    jwt = await AuthService.token();
    var res = await http.get('${API.base}/driver/', headers: header);
    return res.statusCode == 200
        ? json.decode(res.body)
        : " ";
  }

    static Future updateDeliveryStatus(String id) async {
    var res = await http.put("${API.base}/driver/deliverd/$id",
       headers: header);

    return res.statusCode == 200
        ? jsonDecode(res.body)
        : null; //return json token from the response
  }

  static Future updateSheduleStatus(String id) async {
    var res = await http.put("${API.base}/driver/schedule/$id",
       headers: header);

    return res.statusCode == 200
        ? jsonDecode(res.body)
        : null; //return json token from the response
  }

}
