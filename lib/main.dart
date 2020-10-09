import 'package:Smart_Cargo_mobile/pages/homePage.dart';
import 'package:Smart_Cargo_mobile/pages/loginPage.dart';
import 'package:Smart_Cargo_mobile/services/authService.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SmartCargo Driver',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
          future: AuthService.token(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return CircularProgressIndicator();
            if (snapshot.data != null) {
              var jwt = snapshot.data;
              return jwt.split(".").length != 3 ? LoginPage() : HomePage(jwt: jwt,);
            }
            return LoginPage();
          }),
    );
  }
}
