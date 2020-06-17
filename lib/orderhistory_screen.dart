import 'dart:async';

import 'package:basketapp/Cart_Screen.dart';
import 'package:basketapp/database/Auth.dart';
import 'package:basketapp/database/DataCollection.dart';
import 'package:basketapp/item_details.dart';
import 'package:basketapp/model/Order.dart';
import 'package:basketapp/model/Product_Item.dart';
import 'package:basketapp/widget/Custom_AppBar.dart';
import 'package:basketapp/widget/Navigation_Drwer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_range_slider/flutter_range_slider.dart';

class Oder_History extends StatefulWidget {
  final String toolbarname;

  Oder_History({Key key, this.toolbarname}) : super(key: key);

  @override
  State<StatefulWidget> createState() => oder_history(toolbarname);
}

class Item {
  final String name;
  final String deliveryTime;
  final String oderId;
  final String oderAmount;
  final String paymentType;
  final String address;
  final String cancelOder;

  Item({this.name,
    this.deliveryTime,
    this.oderId,
    this.oderAmount,
    this.paymentType,
    this.address,
    this.cancelOder});
}

class oder_history extends State<Oder_History> {
  bool checkboxValueA = true;
  bool checkboxValueB = false;
  bool checkboxValueC = false;
  VoidCallback _showBottomSheetCallback;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String toolbarname;

  oder_history(this.toolbarname);


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    IconData _backIcon() {
      switch (Theme.of(context).platform) {
        case TargetPlatform.android:
        case TargetPlatform.fuchsia:
          return Icons.arrow_back;
        case TargetPlatform.iOS:
          return Icons.arrow_back_ios;
      }
      assert(false);
      return null;
    }

    var size = MediaQuery.of(context).size;


    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;

    final Orientation orientation = MediaQuery.of(context).orientation;
    return new Scaffold(
        key: _scaffoldKey,
        drawer: Navigation_Drawer(new Auth()),
        bottomNavigationBar:
            Custom_AppBar().getButtomNavigation(context, widget),
        appBar: Custom_AppBar().getAppBar(context),
        body: FutureBuilder(
          future: DataCollection().getOrderHistoryList(),
          builder: (_, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Text("Loading...."),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  var d = snapshot.data;
                  return SafeArea(
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(
                              left: 5.0, right: 5.0, bottom: 5.0),
                          color: Colors.black12,
                          child: Card(
                            elevation: 4.0,
                            child: Column(
                              children: <Widget>[
                                ListTile(
                                  leading: Icon(Icons.album, size: 50),
                                  title: Text(d[index].data['itemName']),
                                  subtitle: Text(d[index].data['price']),
                                ),
                                //Text(d[index].data['itemName']),

                                //Text(d[index].data['imageUrl']),
                                //Text(d[index].data['itemId'])
                              ],
                            ),
                          ),
                        ),

                      ],
                    ),
                  );
                },
              );
            }
          },

        )

    );
  }

  _verticalDivider() => Container(
    padding: EdgeInsets.all(2.0),
  );

  Widget _status(status) {
    if(status == 'Cancel Order'){
      return FlatButton.icon(
          label: Text(status,style: TextStyle(color: Colors.red),),
          icon: const Icon(Icons.highlight_off, size: 18.0,color: Colors.red,),
          onPressed: () {
            // Perform some action
          }
      );
    }
    else{
      return FlatButton.icon(
          label: Text(status,style: TextStyle(color: Colors.green),),
          icon: const Icon(Icons.check_circle, size: 18.0,color: Colors.green,),
          onPressed: () {
            // Perform some action
          }
      );
    }
    if (status == "3") {
      return Text('Process');
    } else if (status == "1") {
      return Text('Order');
    } else {
      return Text("Waiting");
    }
  }

  erticalD() => Container(
    margin: EdgeInsets.only(left: 10.0, right: 0.0, top: 0.0, bottom: 0.0),
  );

  bool a = true;
  String mText = "Press to hide";
  double _lowerValue = 1.0;
  double _upperValue = 100.0;

  void _visibilitymethod() {
    setState(() {
      if (a) {
        a = false;
        mText = "Press to show";
      } else {
        a = true;
        mText = "Press to hide";
      }
    });
  }
}
