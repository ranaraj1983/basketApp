import 'package:basketapp/checkout_screen.dart';
import 'package:basketapp/database/Auth.dart';
import 'package:basketapp/item_screen.dart';
import 'package:basketapp/model/Product_Item.dart';
import 'package:basketapp/widget/Custom_AppBar.dart';
import 'package:basketapp/widget/Navigation_Drwer.dart';
import 'package:basketapp/widget/WidgetFactory.dart';

//import 'package:basketapp/model/ItemProduct.dart';
import 'package:flutter/material.dart';

enum DialogDemoAction {
  cancel,
  discard,
  disagree,
  agree,
}

class Cart_screen extends StatefulWidget {
  List<Product_Item> list;

  Cart_screen({Key key, this.list}) : super(key: key);

  @override
  State<StatefulWidget> createState() => Cart_Product_Item(list);
}



class Cart_Product_Item extends State<Cart_screen> {
  List<Product_Item> itemList;

  Cart_Product_Item(this.itemList);

  String toolbarname = 'My Cart (4)';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  IconData _backIcon() {
    switch (Theme
        .of(context)
        .platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        return Icons.arrow_back;
      case TargetPlatform.iOS:
        return Icons.arrow_back_ios;
    }
    assert(false);
    return null;
  }

  String pincode;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    IconData _add_icon() {
      switch (Theme.of(context).platform) {
        case TargetPlatform.android:
        case TargetPlatform.fuchsia:
          return Icons.add_circle;
        case TargetPlatform.iOS:
          return Icons.add_circle;
      }
      assert(false);
      return null;
    }
    IconData _sub_icon() {
      switch (Theme.of(context).platform) {
        case TargetPlatform.android:
        case TargetPlatform.fuchsia:
          return Icons.remove_circle;
        case TargetPlatform.iOS:
          return Icons.remove_circle;
      }
      assert(false);
      return null;
    }
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;

    double dd = width * 0.77;
    double hh = height - 215.0;
    int item = 0;
    final ThemeData theme = Theme.of(context);
    final TextStyle dialogTextStyle = theme.textTheme.subhead.copyWith(
        color: theme.textTheme.caption.color);

    return new Scaffold(
      key: _scaffoldKey,
      drawer: Navigation_Drawer(new Auth()),
      bottomNavigationBar: Custom_AppBar().getButtomNavigation(context, widget),
      appBar: Custom_AppBar().getAppBar(context),

      body: Column(
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(left: 0.0, right: 0.0, bottom: 10.0),
              child: Card(
                  child: Container(
                      padding:
                      const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                      child: GestureDetector(
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              // three line description
                              Row(
                                children: <Widget>[
                                  Text(
                                    'Pincode : ',
                                    style: TextStyle(
                                      fontSize: 17.0,
                                      fontStyle: FontStyle.normal,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 2.0),
                                  ),
                                  GestureDetector(
                                    child: Text(
                                      '383310',
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.underline,
                                          color: Colors.black),
                                    ),
                                    onTap: () {
                                      showDemoDialog<DialogDemoAction>(
                                          context: context,
                                          child: AlertDialog(
                                              title: const Text(
                                                  'Location/Area Pincode'),
                                              content:SizedBox(
                                                height: 24.0,
                                              child: TextFormField(
                                                  keyboardType: TextInputType.emailAddress, // Use email input type for emails.
                                                  decoration: new InputDecoration(
                                                      hintText: '******',
                                                      labelText: 'Pincode'
                                                  ),
                                                //  validator: this._validateEmail,
                                                  onSaved: (String value) {
                                                    this.pincode = value;
                                                  }
                                              ),),

                                              actions: <Widget>[
                                                FlatButton(
                                                    child: const Text(
                                                        'CANCEL'),
                                                    onPressed: () {
                                                      Navigator.pop(context,
                                                          DialogDemoAction
                                                              .disagree);
                                                    }
                                                ),
                                                FlatButton(
                                                    child: const Text('SAVE'),
                                                    onPressed: () {
                                                      Navigator.pop(context,
                                                          DialogDemoAction
                                                              .agree);
                                                    }
                                                )
                                              ]
                                          )
                                      );
                                    },
                                  )

                                ],
                              ),
                            ],
                          ))))),
          Container(
              margin: EdgeInsets.only(
                  left: 12.0, top: 5.0, right: 12.0, bottom: 10.0),
              height: hh,
              child: ListView.builder(
                  itemCount: this.itemList.length,
                  itemBuilder: (BuildContext cont, int ind) {
                    return SafeArea(
                        child: Container(
                          alignment: Alignment.topLeft,
                          child: Column(
                            children: <Widget>[
                              Container(

                                  alignment: Alignment.topLeft,
                                  child: Row(
                                    children: <Widget>[
                                      Container(

                                        height: 120.0,
                                        width: dd,
                                        child: Card(
                                          child: Row(
                                            children: <Widget>[
                                              SizedBox(
                                                  height: 110.0,
                                                width: 100.0,
                                                child:
                                                Image.network(
                                                  itemList[ind]
                                                      .imageUrl,
                                                  height: 100,
                                                  width: 100,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 110.0,
                                                width: 100.0,
                                                child: WidgetFactory()
                                                    .getImageFromDatabase(
                                                    context, itemList[ind]
                                                    .imageUrl),
                                              ),
                                              SizedBox(
                                                  height: 110.0,
                                                  child: Container(
                                                    alignment: Alignment
                                                        .topLeft,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                      children: <Widget>[
                                                        _verticalD(),
                                                        Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                          children: <Widget>[
                                                            Text(
                                                              itemList[ind]
                                                                  .itemName,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                                  fontSize: 18.0,
                                                                  color:
                                                                  Colors.black),
                                                            ),
                                                          ],
                                                        ),
                                                        _verticalD(),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          mainAxisSize: MainAxisSize.max,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: <Widget>[
                                                            Text(
                                                              itemList[ind]
                                                                  .price,
                                                              style: TextStyle(
                                                                  fontSize: 15.0,
                                                                  color:
                                                                  Colors
                                                                      .black54),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisSize: MainAxisSize.max,
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: <Widget>[
                                                            new IconButton(
                                                              icon: Icon(
                                                                  _add_icon(),
                                                                  color: Colors
                                                                      .amber
                                                                      .shade500),
                                                              onPressed: () {
                                                                // item = item + 1;
                                                              },

                                                            ),
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                  left: 2.0),
                                                            ),
                                                            Text(
                                                              item.toString(),

                                                            ),
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                  right: 2.0),
                                                            ),
                                                            new IconButton(
                                                              icon: Icon(
                                                                  _sub_icon(),
                                                                  color: Colors
                                                                      .amber
                                                                      .shade500),
                                                              onPressed: () {

                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ))
                                            ],
                                          ),
                                        ),
                                      ),

                                      SizedBox(
                                          height: 110.0,
                                          width: 50.0,
                                          child: Container(
                                            alignment: Alignment.center,
                                            child: Text(
                                              itemList[ind].price,
                                            ),
                                          )

                                      ),

                                    ],
                                  )),

                            ],
                          ),
                        ));
                  })),
          Container(
              alignment: Alignment.bottomLeft,
              height: 60.0,
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
                      '\₹ 524',
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
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Checkout()));
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

  verticalDivider() =>
      Container(
        padding: EdgeInsets.all(2.0),
      );

  _verticalD() =>
      Container(
        margin: EdgeInsets.only(left: 3.0, right: 0.0, top: 07.0, bottom: 0.0),
      );

  void showDemoDialog<T>({ BuildContext context, Widget child }) {
    showDialog<T>(
      context: context,
      builder: (BuildContext context) => child,
    )
        .then<void>((T value) { // The value passed to Navigator.pop() or null.
      if (value != null) {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text('You selected: $value')
        ));
      }
    });
  }
}