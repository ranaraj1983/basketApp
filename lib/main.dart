import 'package:basketapp/Cart_Screen.dart';
import 'package:basketapp/HomeScreen.dart';
import 'package:basketapp/item_screen.dart';
import 'package:basketapp/model/ItemProduct.dart';
import 'package:basketapp/services/Cart.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'dart:async';

import 'package:provider/provider.dart';


void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  ObservableList<ItemProduct> addtoCartList = new ObservableList<ItemProduct>();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //final cart = Provider.of<Cart>(context, listen: false);

    return MaterialApp(
      theme: new ThemeData(

          primaryColor: Colors.white,
          primaryColorDark: Colors.white30,
          accentColor: Colors.blue

      ),
      home: Provider<Cart>(
        create: (context) =>  Cart(addtoCartList),
        child: new Item_Screen(),
        //dispose: (_,cart) => cart.dispose(),
      ),
    );


    /*return new MaterialApp(
        theme: new ThemeData(

            primaryColor: Colors.white,
            primaryColorDark: Colors.white30,
            accentColor: Colors.blue

        ),
        home: new Item_Screen(),
      //home: new MyHomePage(title: 'Groceries'),
    );*/
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Home_screen()));

  }

  @override
  void initState() {
    super.initState();
    startTime();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build


    return new Container(
      alignment: Alignment.center,
      decoration: new BoxDecoration(color: Colors.white),
      child: new Container(
        color: Colors.black12,
        margin: new EdgeInsets.all(30.0),
        width: 250.0,
        height: 250.0,
        child: new Image.asset(
          'images/gro.jpg',
        ),
      ),
    );
  }

}
