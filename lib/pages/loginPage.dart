import 'package:Smart_Cargo_mobile/services/authService.dart';
import 'package:Smart_Cargo_mobile/services/driverService.dart';
import 'package:flutter/material.dart';

import 'homePage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  String emailError;
  String passwordError;
  bool loading = false;

  void displayDialog(context, title, text) => showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(title: Text(title), content: Text(text)),
      );

  @override
  Widget build(BuildContext context) {
    double logoWidth = MediaQuery.of(context).size.width / 2;
    double spaceFromTop = MediaQuery.of(context).size.height / 10;
    return Scaffold(
        backgroundColor: Color(0xffF3F3F3),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: spaceFromTop),
                  Container(
                    child: Image.asset('images/SmartCargoLogo.png'),
                    height: logoWidth,
                    width: logoWidth,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Color(0xffF3F3F3),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: Colors.grey[100]))),
                          child: Theme(
                            data: ThemeData(
                              primaryColor: Color(0xff4D5C84),
                              accentColor: Color(0xff4D5C84),
                            ),
                            child: TextField(
                              onChanged: (email) {
                                email.isEmpty
                                    ? setState(() {
                                        emailError =
                                            "Email feild Can't be empty";
                                      })
                                    : setState(() {
                                        emailError = null;
                                      });
                              },
                              controller: _emailController,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                labelStyle: TextStyle(
                                    fontFamily: 'Exo',
                                    fontSize: 16,
                                    color: Color(0xff4D5C84)),
                              ),
                            ),
                          ),
                        ),
                        emailError != null
                            ? Text(
                                emailError,
                                style: TextStyle(
                                    color: Colors.red, fontFamily: 'Exo'),
                              )
                            : SizedBox(),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: Colors.grey[100]))),
                          child: Theme(
                            data: ThemeData(
                              primaryColor: Color(0xff4D5C84),
                              accentColor: Color(0xff4D5C84),
                            ),
                            child: TextField(
                              onChanged: (password) {
                                password.isEmpty
                                    ? setState(() {
                                        passwordError =
                                            "Password feild Can't be empty";
                                      })
                                    : setState(() {
                                        passwordError = null;
                                      });
                              },
                              controller: _passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                  labelText: 'Password',
                                  labelStyle: TextStyle(
                                      fontFamily: 'Exo',
                                      fontSize: 16,
                                      color: Color(0xff4D5C84))),
                            ),
                          ),
                        ),
                        passwordError != null
                            ? Text(
                                passwordError,
                                style: TextStyle(
                                    color: Colors.red, fontFamily: 'Exo'),
                              )
                            : SizedBox(),
                        SizedBox(
                          height: 20,
                        ),
                        FlatButton(
                          padding: EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal:
                                  MediaQuery.of(context).size.width / 3.5),
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(5.0)),
                          color: Color(0xff4D5C84),
                          onPressed: () async {
                            var email = _emailController.text;
                            var password = _passwordController.text;
                            setState(() {
                              loading = true;
                            });
                            var jwt = await AuthService.login(email, password);

                            if (email.isNotEmpty && password.isNotEmpty) {
                              if (jwt != null &&
                                  AuthService.decodeToken(jwt)["role"] ==
                                      "driver") {
                                AuthService.storeToken(jwt);
                                DriverService.jwt = jwt;
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            HomePage(jwt: jwt)));
                              }
                            }

                            if (password.isEmpty || email.isEmpty)
                              displayDialog(context, "Invalid Credentials",
                                  "Email and Password Fields can't be empty");
                            else if (jwt == null)
                              displayDialog(context, "Invalid Credentials",
                                  "Your credentials doesn't match with our record");
                            else if (jwt != null &&
                                AuthService.decodeToken(jwt)["role"] !=
                                    "driver")
                              displayDialog(context, "Unauthorized",
                                  "You are not authorized to used this mobile appication");

                            setState(() {
                              loading = false;
                            });
                          },
                          child: loading
                              ? CircularProgressIndicator(
                                  backgroundColor: Colors.white,
                                )
                              : Text(
                                  "LogIn",
                                  style: TextStyle(
                                      fontFamily: 'Exo',
                                      color: Colors.white,
                                      fontSize: 16),
                                ),
                        ),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
