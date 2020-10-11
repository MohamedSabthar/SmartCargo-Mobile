import 'package:flutter/material.dart';
import 'dart:async';
import 'package:Smart_Cargo_mobile/model/profileResponse.dart';
import 'package:Smart_Cargo_mobile/services/authService.dart';
import 'package:Smart_Cargo_mobile/services/driverService.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  StreamController _profileController;

  bool isLoading = false;

//load profile of driver
  loadProfile() {
    if (mounted)
      setState(() {
        isLoading = true;
      });

    DriverService.profile().then((res) async {
      _profileController.add(res);
      if (mounted)
        setState(() {
          isLoading = false;
        });
      return res;
    });

    print("profile");
  }

  @override
  void initState() {
    super.initState();

    _profileController = new StreamController();

    this.loadProfile();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     this.loadSchedule();
        //   },
        //   child: Icon(Icons.refresh),
        // ),
        appBar: AppBar(
                 centerTitle: true,
          title: Text("Driver Profile",
              style: TextStyle(color: Colors.black, fontFamily: 'Exo')),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
                      child: StreamBuilder(
                stream: _profileController.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var profileData = ProfileResponse.fromJson(snapshot.data);
                    return profileData.profile != null
                        ? Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.account_circle_outlined,
                                      color: Color(0xff4D5C84),
                                      size: 50,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${profileData.profile.name.first} ${profileData.profile.name?.middle} ${profileData.profile.name.last}",
                                          style: TextStyle(
                                              fontFamily: 'Exo',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                            "License Number : ${profileData.profile.licenseNo.toUpperCase()}",
                                            style: TextStyle(
                                                fontFamily: 'Exo',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16)),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Divider(
                                  indent: 20,
                                  endIndent: 20,
                                  color: Color(0xff4D5C84),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "Address",
                                  style: TextStyle(
                                      fontFamily: 'Exo',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 16),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "No : ${profileData.profile.address.no}",
                                        style: TextStyle(
                                            fontFamily: 'Exo',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        "Street : ${profileData.profile.address.street}",
                                        style: TextStyle(
                                            fontFamily: 'Exo',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        "City : ${profileData.profile.address.city}",
                                        style: TextStyle(
                                            fontFamily: 'Exo',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Divider(
                                  indent: 20,
                                  endIndent: 20,
                                  color: Color(0xff4D5C84),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "Contact",
                                  style: TextStyle(
                                      fontFamily: 'Exo',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 16),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Email : ${profileData.profile.contact.email}",
                                        style: TextStyle(
                                            fontFamily: 'Exo',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        "Phone number : ${profileData.profile.contact.phone}",
                                        style: TextStyle(
                                            fontFamily: 'Exo',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 16),
                                Center(
                                  child: FlatButton(
                                      padding: EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal:
                                    MediaQuery.of(context).size.width / 3),
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(5.0)),
                            color: Color(0xff4D5C84),
                                      onPressed: () {
                                        AuthService.logout(context);
                                      },
                                      child: Text(
                                    "Logout",
                                    style: TextStyle(
                                        fontFamily: 'Exo',
                                        color: Colors.white,
                                        fontSize: 16),
                                  ),),
                                )
                              ],
                            ),
                          )
                        : Center(child: CircularProgressIndicator());
                  }
                  return  Container(height:MediaQuery.of(context).size.height/1.5, child: Center(child: CircularProgressIndicator()));
                }),
          ),
        ),
      );
}
