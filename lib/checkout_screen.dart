import 'package:basketapp/HomeScreen.dart';
import 'package:basketapp/Payment_Screen.dart';
import 'package:basketapp/database/Auth.dart';
import 'package:basketapp/database/DataCollection.dart';
import 'package:basketapp/main.dart';
import 'package:basketapp/widget/Custom_AppBar.dart';
import 'package:basketapp/widget/Custom_Drawer.dart';
import 'package:basketapp/widget/WidgetFactory.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class Checkout extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => check_out();
}

class Item {
  final String itemName;
  final String itemQun;
  final String itemPrice;

  Item({this.itemName, this.itemQun, this.itemPrice});
}

class check_out extends State<Checkout> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  bool checkboxValueA = true;
  bool checkboxValueB = false;
  bool checkboxValueC = false;
  String _email;
  String _password;
  final formKey = GlobalKey<FormState>();

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



  @override
  Widget build(BuildContext context) {


    final double height = MediaQuery.of(context).size.height;
    int totalPrice = Custom_AppBar().getCartTotalPrice();

    AppBar appBar = AppBar(
      leading: IconButton(
        icon: Icon(_backIcon()),
        alignment: Alignment.centerLeft,
        tooltip: 'Back',
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text("toolbarname"),
      backgroundColor: Colors.white,
      actions: <Widget>[
        new Padding(
          padding: const EdgeInsets.all(10.0),
          child: new Container(
            height: 150.0,
            width: 30.0,
            child: new GestureDetector(
              onTap: () {
                /*Navigator.of(context).push(
                  new MaterialPageRoute(
                      builder:(BuildContext context) =>
                      new CartItemsScreen()
                  )
              );*/
              },
            ),
          ),
        )
      ],
    );

    return new Scaffold(
      key: _scaffoldKey,
      drawer: Custom_Drawer().getDrawer(context),
      appBar: Custom_AppBar().getAppBar(context),
      bottomNavigationBar: Custom_AppBar().getButtomNavigation(context, widget),
      //Custom_Drawer().getButtomNavigation(),
      body: new Column(
        children: <Widget>[
          Container(
              margin: EdgeInsets.all(5.0),
              child: Card(
                  child: Container(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          // three line description
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Container(
                                    alignment: Alignment.center,
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          'Delivery',
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                        IconButton(
                                            icon: Icon(
                                              Icons.play_circle_outline,
                                              color: Colors.blue,
                                            ),
                                            onPressed: null)
                                      ],
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Container(
                                    alignment: Alignment.center,
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          'Payment',
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black38),
                                        ),
                                        IconButton(
                                            icon: Icon(
                                              Icons.check_circle,
                                              color: Colors.black38,
                                            ),
                                            onPressed: null)
                                      ],
                                    )),
                              ),
                            ],
                          ),
                        ],
                      )))),
          _verticalDivider(),
          new Container(
            alignment: Alignment.topLeft,
            margin:
                EdgeInsets.only(left: 12.0, top: 5.0, right: 0.0, bottom: 5.0),
            child: new Text(
              'Delivery Address',
              style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0),
            ),
          ),
          WidgetFactory().getAddressBar(context, formKey),
          _verticalDivider(),
          new Container(
            alignment: Alignment.topLeft,
            margin:
                EdgeInsets.only(left: 12.0, top: 5.0, right: 0.0, bottom: 5.0),
            child: Text(
              'Order Summary',
              style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0),
            ),
          ),
          Column(
            children: <Widget>[
              Observer(

                  builder: (_) =>
                      Custom_AppBar().getCartListWidgetListView()
              ),
            ],
          ),

          Container(
              alignment: Alignment.bottomLeft,
              height: 50.0,
              child: Card(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(icon: Icon(Icons.info), onPressed: null),
                    Text(
                      'Total :',
                      style: TextStyle(
                          fontSize: 17.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '\₹ ${totalPrice}',
                      style: TextStyle(fontSize: 17.0, color: Colors.black54),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        alignment: Alignment.center,
                        child: OutlineButton(
                            borderSide:
                            BorderSide(color: Colors.amber.shade500),
                            child: const Text('CONFIRM ORDER'),
                            textColor: Colors.amber.shade500,
                            onPressed: () async {
                              if (await Auth().getCurrentUserFuture() != null) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Payment_Screen(totalPrice)
                                    )
                                );
                              } else {
                                WidgetFactory().logInDialog(
                                    context, _scaffoldKey, formKey);
                              }
                            },
                            shape: new OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            )),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  IconData _add_icon() {
    switch (Theme.of(context).platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        return Icons.add;
      case TargetPlatform.iOS:
        return Icons.arrow_back_ios;
    }
    assert(false);
    return null;
  }

  IconData _sub_icon() {
    switch (Theme.of(context).platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        return Icons.remove;
      case TargetPlatform.iOS:
        return Icons.arrow_back_ios;
    }
    assert(false);
    return null;
  }

  _verticalDivider() => Container(
    padding: EdgeInsets.all(2.0),
  );

  _verticalD() => Container(
    margin: EdgeInsets.only(left: 3.0, right: 0.0, top: 0.0, bottom: 0.0),
  );
}
