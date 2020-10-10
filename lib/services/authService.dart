import 'dart:convert';

import 'package:Smart_Cargo_mobile/model/jwtResponse.dart';
import 'package:Smart_Cargo_mobile/pages/loginPage.dart';
import 'package:flutter/material.dart';

import 'api.dart';
import 'package:http/http.dart' as http;

class AuthService {
  //get token
  static Future<String> token() async =>
      await API.storage.read(key: "jwt") ?? "";

  //attemp login
  static Future<String> login(String email, String password) async {
    var res = await http.post("${API.base}/auth/sign-in",
        body: {"email": email, "password": password});

    return res.statusCode == 200
        ? JwtResponse.fromJson(jsonDecode(res.body)).token
        : null; //return json token from the response
  }

  //decode token and retrun Payload
  static Map<String, dynamic> decodeToken(token) => json.decode(
      ascii.decode(base64.decode(base64.normalize(token.split(".")[1]))));

  //store jwt token to storage
  static void storeToken(token) {
    API.storage.write(key: "jwt", value: token);
  }

  //logout the user and delete the token from storage and move to loginScreen
  static void logout(context) async {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LoginPage()),
        (Route<dynamic> route) => false);

    // Delete value
    await API.storage.delete(key: "jwt");
  }
}
