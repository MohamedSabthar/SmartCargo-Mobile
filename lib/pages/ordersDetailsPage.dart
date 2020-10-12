import 'package:Smart_Cargo_mobile/model/orderResponse.dart';
import 'package:Smart_Cargo_mobile/model/scheduleResponse.dart' as sr;
import 'package:Smart_Cargo_mobile/services/driverService.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class OrdersDetailPage extends StatefulWidget {
  OrdersDetailPage({@required this.data});
  final sr.ScheduleResponse data;
  @override
  _OrdersDetailPageState createState() => _OrdersDetailPageState();
}

class _OrdersDetailPageState extends State<OrdersDetailPage> {
  List<sr.Route> orders;
  final lableStyle = TextStyle(
      color: Color(0xff4D5C84),
      fontFamily: 'Exo',
      fontSize: 14,
      fontWeight: FontWeight.bold);
  int activeIndex = 0;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    this.orders = widget.data.schedule.route;
    var index = 0;
    orders.forEach((order) {
      if (order.status == "delivered")
        index++;
      else
        return;
    });
    activeIndex = index;
    if(activeIndex==orders.length){
         DriverService.updateSheduleStatus(widget.data.schedule.sId)
              .then((val) async {
            if (val != null)
              Navigator.of(context).pop(activeIndex);
          });
    }
  }

  confirmDeleiveryStatusUpdate(id) {
    print(id);
    Alert(
      context: context,
      type: AlertType.warning,
      title: "Are you Sure!",
      style: AlertStyle(
          descStyle: TextStyle(fontSize: 16, fontFamily: 'Exo'),
          titleStyle: TextStyle(
              fontFamily: 'Exo', fontWeight: FontWeight.bold, fontSize: 20)),
      desc: "Did you deliver the order #$id ?",
      buttons: [
        DialogButton(
          child: Text(
            "cancel",
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
              fontFamily: 'Exo',
            ),
          ),
          onPressed: () => Navigator.pop(context),
          color: Colors.red.shade400,
        ),
        DialogButton(
          child: Text(
            "confirm",
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
              fontFamily: 'Exo',
            ),
          ),
          onPressed: () {
            updateDeliveryStatus();
            Navigator.pop(context);
          },
          color: Color.fromRGBO(0, 179, 134, 1.0),
        )
      ],
    ).show();
  }

  updateDeliveryStatus() {
    if (activeIndex < orders.length - 1) {
      setState(() {
            loading = true;
          });
      DriverService.updateDeliveryStatus(orders[activeIndex].sId)
          .then((value) async {
        if (value != null && OrderResponse.fromJson(value).order != null) {
          setState(() {
            orders[activeIndex].status = 'delivered';
            loading = false;
            activeIndex = activeIndex + 1;
          });
        }
      });
    } else if (activeIndex == orders.length - 1) {
      print('last');

      DriverService.updateDeliveryStatus(orders[activeIndex].sId)
          .then((value) async {
        if (value != null && OrderResponse.fromJson(value).order != null) {
          //update the scheudule to delivered on last
          DriverService.updateSheduleStatus(widget.data.schedule.sId)
              .then((val) async {
            if (val != null)
              setState(() {
                orders[activeIndex].status = 'delivered';
                activeIndex = activeIndex + 1;
              });
          });
        }
      });
    }
  }

  List<Widget> buildCardList() {
    var index = -1;
    return orders.map((order) {
      index++;
      return buildCard(order, index);
    }).toList();
  }

  Widget buildCard(sr.Route order, int index) {
    return Container(
        padding: EdgeInsets.all(16),
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
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: Row(
                  children: [
                    Text(
                      'Order Id : ',
                      style: lableStyle,
                    ),
                    Text('#${order.sId}'),
                  ],
                )),
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: Row(
                  children: [
                    Text('Customer\'s Phone : ', style: lableStyle),
                    Text('${order.phone}')
                  ],
                )),
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: Row(
                  children: [
                    Text('Delivery Status : ', style: lableStyle),
                   this.activeIndex==index && loading ? SizedBox(
                child: CircularProgressIndicator(),
                height: 8.0,
                width: 8.0,
              ): Text('${order.status}')
                  ],
                )),
              ],
            ),
            SizedBox(height: 8),
            order.status == "sheduled" && activeIndex == index
                ? Row(
                    children: [
                      Expanded(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FlatButton(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 35),
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(5.0)),
                            color: Color(0xff4D5C84),
                            onPressed: () {
                              print('view path');
                            },
                            child: Text(
                              "View Path",
                              style: TextStyle(
                                  fontFamily: 'Exo',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 13),
                            ),
                          ),
                          SizedBox(width: 20),
                          FlatButton(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 35),
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(5.0)),
                            color: Color(0xff4D5C84),
                            onPressed: () {
                              confirmDeleiveryStatusUpdate(order.sId);
                            },
                            child: Text(
                              "Delivered",
                              style: TextStyle(
                                  fontFamily: 'Exo',
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13),
                            ),
                          ),
                        ],
                      )),
                    ],
                  )
                : SizedBox(),
          ],
        ));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF3F3F3),
      appBar: AppBar(
        centerTitle: true,
        leading: BackButton(color: Color(0xff4D5C84),onPressed: (){
          Navigator.of(context).pop(activeIndex);
        },),
        title: Text("Delivery Details",
            style: TextStyle(color: Colors.black, fontFamily: 'Exo')),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: buildCardList(),
        ),
      ),
    );
  }
}
