import 'package:Smart_Cargo_mobile/services/authService.dart';
import 'package:flutter/material.dart';

import 'homePage.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void displayDialog(context, title, text) => showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(title: Text(title), content: Text(text)),
      );

  @override
  Widget build(BuildContext context) {
    double logoWidth = MediaQuery.of(context).size.width/2;
    double spaceFromTop = MediaQuery.of(context).size.height/8;
    return Scaffold(
      backgroundColor: Color(0xffF3F3F3),
        body: SafeArea(
                  child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView
      (
                child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height:spaceFromTop),
              Container(child: Image.asset('images/SmartCargoLogo.png'),height: logoWidth,width: logoWidth,),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email',labelStyle: TextStyle(fontFamily: 'Exo',fontSize: 16)),
              ),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Password', labelStyle: TextStyle(fontFamily: 'Exo',fontSize: 16)),
              ),
              SizedBox(height: 20,),
              FlatButton(
                padding: EdgeInsets.symmetric(vertical: 12,horizontal: MediaQuery.of(context).size.width/4),
                shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(5.0)),
                color: Color(0xff4D5C84),
                  onPressed: () async {
                    var email = _emailController.text;
                    var password = _passwordController.text;
                    var jwt = await AuthService.login(email, password);
                    if (jwt != null &&
                        AuthService.decodeToken(jwt)["role"] == "driver") {
                      AuthService.storeToken(jwt);
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => HomePage(jwt: jwt)));
                    } else {
                      if ( jwt != null && AuthService.decodeToken(jwt)["role"] != "driver")
                        displayDialog(context, "Unauthorized",
                            "You are not authorized to used this mobile appication");
                      else
                        displayDialog(context, "Invalid Credentials",
                            "Your credentials doesn't match with our record");
                    }
                  },
                  child: Text("Log In",style: TextStyle(fontFamily: 'Exo',color: Colors.white,fontSize: 16),)),
            ],
          ),
      ),
    ),
        ));
  }
}
