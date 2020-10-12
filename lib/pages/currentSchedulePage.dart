import 'package:Smart_Cargo_mobile/pages/ordersDetailsPage.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:Smart_Cargo_mobile/model/profileResponse.dart';
import 'package:async/async.dart';
import 'package:Smart_Cargo_mobile/model/scheduleResponse.dart';
import 'package:Smart_Cargo_mobile/services/driverService.dart';

class ScheduleOrderPage extends StatefulWidget {
  ScheduleOrderPage({Key key}) : super(key: key);

  @override
  _ScheduleOrderPageState createState() => _ScheduleOrderPageState();
}

class _ScheduleOrderPageState extends State<ScheduleOrderPage> {
  //schedule details
  StreamController _schduleController;



  bool isLoading = false;
  bool initLoad = true;

  setStateIfMounted(f) {
    if (mounted) 
    setState(f);
  }



//load schedule from network
  loadSchedule() {
    setStateIfMounted(() {
      isLoading = true;
    });

    DriverService.getSchedules().then((res) async {
      _schduleController.add(res);
      
      setStateIfMounted(() {
        isLoading = false;
      });
      return res;
    });

    print("schedule");
  }

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
          centerTitle: true,
          title: Text("Current Schedule",
              style: TextStyle(color: Colors.black, fontFamily: 'Exo')),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: StreamBuilder(
                stream: _schduleController.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData && isLoading == false) {
                    var data = ScheduleResponse.fromJson(snapshot.data);
                    var profileData =
                        ProfileResponse.fromJson(snapshot.data);
                        
                    if (data.schedule == null)
                      return Column(
                        children: [
                          Container(
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
                            child: Row(
                              children: [
                                
                                Expanded(child: Container(
                                  height: 80,
                                  child: Center(
                                    
                                    child: Column(
                                      children: [
                                        SizedBox(height: 16,),
                                        Text(
                                          "Hi ${profileData.profile.name.first} ${profileData.profile.name.last} !",
                                          style: TextStyle(
                                              color: Color(0xff4D5C84),
                                              fontFamily: 'Exo',
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Divider(indent: 10,endIndent: 10,),
                                        Text(  "Currently no schedules assinged to you.",
                                          style: TextStyle(
                                              color: Color(0xff4D5C84),
                                              fontFamily: 'Exo',
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                ),),
                              ],
                            ),
                          ),
                        ],
                      );
                    else {
                      var totalOrders = data.schedule.route.length;
                      var deliverdOrders = 0;
                      var pendingOrders = 0;
                      data.schedule.route.forEach((order) {
                        order.status == 'delivered'
                            ? deliverdOrders++
                            : pendingOrders++;
                      });
                      return Column(
                        children: [
                          Center(
                            child: Container(
                              padding: EdgeInsets.all(20),
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
                              child: profileData.profile != null
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Hi ${profileData.profile.name.first} ${profileData.profile.name.last}!",
                                          style: TextStyle(
                                              fontFamily: 'Exo',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          "You are assinged to a delivery schedule",
                                          style: TextStyle(
                                              fontFamily: 'Exo',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Divider(
                                          color: Color(0xff4D5C84),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          'Vehicle Number : ${data.schedule.vehicle.licensePlate}',
                                          style: TextStyle(
                                              fontFamily: 'Exo',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          'Vehicle Type : ${data.schedule.vehicle.vehicleType.type}',
                                          style: TextStyle(
                                              fontFamily: 'Exo',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        )
                                      ],
                                    )
                                  : Center(child: CircularProgressIndicator()),
                            ),
                          ),
                          Center(
                            child: Container(
                              padding: EdgeInsets.all(20),
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
                              child: profileData.profile != null
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Total Number of orders : $totalOrders",
                                          style: TextStyle(
                                              fontFamily: 'Exo',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Divider(
                                          color: Color(0xff4D5C84),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        IntrinsicHeight(
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'Pending',
                                                      style: TextStyle(
                                                          fontFamily: 'Exo',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16),
                                                    ),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    Text(
                                                      '$pendingOrders',
                                                      style: TextStyle(
                                                          fontFamily: 'Exo',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 30,
                                                          color: Color(
                                                              0xff4D5C84)),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              VerticalDivider(
                                                color: Color(0xff4D5C84),
                                                thickness: 0.5,
                                                width: 20,
                                                indent: 5,
                                                endIndent: 5,
                                              ),
                                              Expanded(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'Delivered',
                                                      style: TextStyle(
                                                        fontFamily: 'Exo',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    Text(
                                                      '$deliverdOrders',
                                                      style: TextStyle(
                                                          fontFamily: 'Exo',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 30,
                                                          color: Color(
                                                              0xff4D5C84)),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Center(
                                          child: FlatButton(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 60),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        5.0)),
                                            color: Color(0xff4D5C84),
                                            onPressed: () {
                                              print('details');
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          OrdersDetailPage(
                                                              data: data))).then((value) => this.loadSchedule());
                                            },
                                            child: Text(
                                              "Delivery Details",
                                              style: TextStyle(
                                                  fontFamily: 'Exo',
                                                  color: Colors.white,
                                                  fontSize: 16),
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  : Center(child: CircularProgressIndicator()),
                            ),
                          ),
                        ],
                      );
                    }
                  }

                  return Container(
                      height: MediaQuery.of(context).size.height / 1.5,
                      child: Center(child: CircularProgressIndicator()));
                }),
          ),
        ),
      );
}
