import 'dart:async';
import 'package:Smart_Cargo_mobile/model/scheduleResponse.dart';
import 'package:Smart_Cargo_mobile/services/authService.dart';
import 'package:Smart_Cargo_mobile/services/driverService.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({this.jwt});
  final String jwt;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //schedule details
  StreamController _schduleController;

  bool loading = false;
//load schedule from network
  loadSchedule() {
    setState(() {
      loading = true;
    });

    DriverService.getSchedules().then((res) async {
      _schduleController.add(res);

      setState(() {
        loading = false;
      });
      return res;
    });

    print("hit");
  }

  bool initLoad = true;
  refresh() {
    //refresh schedule every 2minutes
    if (initLoad) {
      loadSchedule();
      initLoad = false;
      this.refresh();
    } else {
      Timer.periodic(Duration(seconds: 120), (_) => {loadSchedule()});
    }
  }

  @override
  void initState() {
    super.initState();
    _schduleController = new StreamController();
    this.refresh();
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
          title: Column(children: [
            Text("Current Schedule",
                style: TextStyle(color: Colors.black, fontFamily: 'Exo')),
            FlatButton(
                onPressed: () {
                  AuthService.logout(context);
                },
                child: Text('LogOut'))
          ]),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: StreamBuilder(
            stream: _schduleController.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData && loading == false) {
                var data = ScheduleResponse.fromJson(snapshot.data);
                if (data.schedule == null)
                  return Column(
                    children: [
                      Expanded(
                        child: Container(
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Color(0xffF3F3F3),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Text("No Schedules yet!")),
                      ),
                    ],
                  );
                return Text(data.schedule.sId);
              }

              return Center(child: CircularProgressIndicator());
            }),
      );
}
