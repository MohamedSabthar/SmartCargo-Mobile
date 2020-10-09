import 'package:Smart_Cargo_mobile/pages/loginPage.dart';
import 'package:Smart_Cargo_mobile/services/api.dart';
import 'package:Smart_Cargo_mobile/services/authService.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatelessWidget {
  HomePage({this.jwt});
  final String jwt;
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text("Secret Data Screen")),
        body: Center(
          child: FutureBuilder(
              future: http.read('${API.base}/driver/',
                  headers: {"Authorization": 'Bearer $jwt'}),
              builder: (context, snapshot) => snapshot.hasData
                  ? Column(
                      children: <Widget>[
                        Text(
                            "${AuthService.decodeToken(jwt)["_id"]}, here's the data:"),
                        Text(snapshot.data),
                        FlatButton(
                            onPressed: () async {
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()),
                                  (Route<dynamic> route) => false);

                              // Delete value
                              await API.storage.delete(key: "jwt");
                            },
                            child: Text("logout"))
                      ],
                    )
                  : snapshot.hasError
                      ? Column(
                          children: [
                            Text("An error occurred"),
                            FlatButton(
                                onPressed: () async {
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) => LoginPage()),
                                      (Route<dynamic> route) => false);

                                  // Delete value
                                  await API.storage.delete(key: "jwt");
                                },
                                child: Text("logout"))
                          ],
                        )
                      : CircularProgressIndicator()),
        ),
      );
}
