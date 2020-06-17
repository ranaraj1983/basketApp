import 'package:basketapp/widget/Custom_AppBar.dart';
import 'package:basketapp/widget/Navigation_Drwer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'database/Auth.dart';

class Account_Screen extends StatefulWidget {
  Account_Screen(this.auth);

  final Auth auth;

  @override
  State<StatefulWidget> createState() => account();
}

enum AuthStatus {
  noSignIn,
  SignIn,
}

class account extends State<Account_Screen> {
  FirebaseUser firebaseUser;
  AuthStatus authStatus = AuthStatus.noSignIn;

  @override
  void initState() {
    super.initState();
    widget.auth.getCurrentUser().then((userId) {
      setState(() {
        authStatus = userId == null ? AuthStatus.noSignIn : AuthStatus.SignIn;
      });
    }).catchError((onError) {
      debugPrint(onError);
    });

    widget.auth.getCurrentUser().then((user) {
      setState(() {
        firebaseUser = user;
      });
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> _userormKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    Icon ofericon = new Icon(
      Icons.edit,
      color: Colors.black38,
    );
    Icon keyloch = new Icon(
      Icons.vpn_key,
      color: Colors.black38,
    );
    Icon clear = new Icon(
      Icons.history,
      color: Colors.black38,
    );
    Icon logout = new Icon(
      Icons.do_not_disturb_on,
      color: Colors.black38,
    );

    Icon menu = new Icon(
      Icons.more_vert,
      color: Colors.black38,
    );
    bool checkboxValueA = true;
    bool checkboxValueB = false;
    bool checkboxValueC = false;


    //List<address> addresLst = loadAddress() as List<address> ;
    return new Scaffold(
      key: _scaffoldKey,
      drawer: Navigation_Drawer(new Auth()),
      bottomNavigationBar: Custom_AppBar().getButtomNavigation(context, widget),
      appBar: Custom_AppBar().getAppBar(context),
      body: new Container(
          child: SingleChildScrollView(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                textDirection: TextDirection.ltr,
                children: <Widget>[
                  new Container(
                    margin: EdgeInsets.all(7.0),
                    alignment: Alignment.topCenter,
                    height: 260.0,
                    child: new Card(
                      elevation: 3.0,
                      child: Column(
                        children: <Widget>[
                          new Container(
                              alignment: Alignment.topCenter,
                              child: Container(
                                width: 100.0,
                                height: 100.0,
                                margin: const EdgeInsets.all(10.0),
                                // padding: const EdgeInsets.all(3.0),
                                child: ClipOval(

                                  child: Image.network(
                                      'https://www.fakenamegenerator.com/images/sil-female.png'),
                                ),
                              )),

                          new FlatButton(
                            //onPressed: Auth().updateProfileImage(),
                            child: Text(
                              'Change',
                              style:
                              TextStyle(fontSize: 13.0, color: Colors.blueAccent),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0),
                                side: BorderSide(color: Colors.blueAccent)),
                          ),

                          new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              new Container(
                                margin: EdgeInsets.only(
                                    left: 10.0, top: 20.0, right: 5.0, bottom: 5.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    new Text(
                                      '${firebaseUser.displayName}',
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                    _verticalDivider(),
                                    new Text(
                                      "firebaseUser.phoneNumber",
                                      style: TextStyle(
                                          color: Colors.black45,
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 0.5),
                                    ),
                                    _verticalDivider(),
                                    new Text(
                                      firebaseUser.email,
                                      style: TextStyle(
                                          color: Colors.black45,
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 0.5),
                                    )
                                  ],
                                ),
                              ),
                              new Container(
                                alignment: Alignment.centerLeft,
                                child: IconButton(
                                    icon: ofericon,
                                    color: Colors.blueAccent,
                                    onPressed: () {
                                      _showEditPopUp();
                                    }
                                ),
                              )
                            ],
                          ),
                          // VerticalDivider(),
                        ],
                      ),
                    ),
                  ),
                  new Container(
                    margin:
                    EdgeInsets.only(left: 12.0, top: 5.0, right: 0.0, bottom: 5.0),
                    child: new Text(
                      'Addresses',
                      style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),
                    ),
                  ),
                  new Container(
                      height: 165.0,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          Container(
                            height: 165.0,
                            width: 230.0,
                            margin: EdgeInsets.all(7.0),
                            child: Card(
                              elevation: 3.0,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: <Widget>[
                                  new Column(


                                    children: <Widget>[
                                      new Container(
                                        margin:
                                        EdgeInsets.only(left: 12.0, top: 5.0, right: 0.0, bottom: 5.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,

                                          children: <Widget>[
                                            new Text(
                                              'Naomi A. Schultz',
                                              style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 0.5,
                                              ),
                                            ),
                                            _verticalDivider(),
                                            new Text(
                                              '2585 Columbia Boulevard',
                                              style: TextStyle(
                                                  color: Colors.black45,
                                                  fontSize: 13.0,
                                                  letterSpacing: 0.5),
                                            ),
                                            _verticalDivider(),
                                            new Text(
                                              'Salisbury',
                                              style: TextStyle(
                                                  color: Colors.black45,
                                                  fontSize: 13.0,
                                                  letterSpacing: 0.5),
                                            ),
                                            _verticalDivider(),
                                            new Text(
                                              ' MD 21801',
                                              style: TextStyle(
                                                  color: Colors.black45,
                                                  fontSize: 13.0,
                                                  letterSpacing: 0.5),
                                            ),

                                            new Container(
                                              margin: EdgeInsets.only(left: 00.0,top: 05.0,right: 0.0,bottom: 5.0),
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: <Widget>[
                                                  new Text(
                                                    'Delivery Address',
                                                    style: TextStyle(
                                                      fontSize: 15.0,
                                                      color: Colors.black26,
                                                    ),

                                                  ),
                                                  _verticalD(),

                                                  new Checkbox(
                                                    value: checkboxValueA,
                                                    onChanged: (bool value) {
                                                      setState(() {
                                                        checkboxValueA = value;
                                                      });
                                                    },
                                                  ),
                                                ],
                                              ),

                                            )

                                          ],
                                        ),
                                      ),

                                    ],
                                  ),
                                  new Container(
                                    alignment: Alignment.topLeft,
                                    child: IconButton(
                                        icon: menu,
                                        color: Colors.black38,
                                        onPressed: null),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 130.0,
                            width: 230.0,
                            margin: EdgeInsets.all(7.0),
                            child: Card(
                              elevation: 3.0,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: <Widget>[
                                  new Column(


                                    children: <Widget>[
                                      new Container(
                                        margin:
                                        EdgeInsets.only(left: 12.0, top: 5.0, right: 0.0, bottom: 5.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,

                                          children: <Widget>[
                                            new Text(
                                              'Bradford R. Butler',
                                              style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 0.5,
                                              ),
                                            ),
                                            _verticalDivider(),
                                            new Text(
                                              '4528 Filbert Street',
                                              style: TextStyle(
                                                  color: Colors.black45,
                                                  fontSize: 13.0,
                                                  letterSpacing: 0.5),
                                            ),
                                            _verticalDivider(),
                                            new Text(
                                              'Philadelphia',
                                              style: TextStyle(
                                                  color: Colors.black45,
                                                  fontSize: 13.0,
                                                  letterSpacing: 0.5),
                                            ),
                                            _verticalDivider(),
                                            new Text(
                                              ' PA 19103',
                                              style: TextStyle(
                                                  color: Colors.black45,
                                                  fontSize: 13.0,
                                                  letterSpacing: 0.5),
                                            ),
                                            new Container(
                                              margin: EdgeInsets.only(left: 00.0,top: 05.0,right: 0.0,bottom: 5.0),
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: <Widget>[
                                                  new Text(
                                                    'Delivery Address',
                                                    style: TextStyle(
                                                      fontSize: 15.0,
                                                      color: Colors.black12,
                                                    ),

                                                  ),
                                                  _verticalD(),

                                                  new Checkbox(
                                                    value: checkboxValueB,
                                                    onChanged: (bool value) {
                                                      setState(() {
                                                        checkboxValueB = value;
                                                      });
                                                    },
                                                  ),
                                                ],
                                              ),

                                            )
                                          ],
                                        ),
                                      ),

                                    ],
                                  ),
                                  new Container(
                                    alignment: Alignment.topLeft,
                                    child: IconButton(
                                        icon: menu,
                                        color: Colors.black38,
                                        onPressed: null),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 130.0,
                            width: 230.0,
                            margin: EdgeInsets.all(7.0),
                            child: Card(
                              elevation: 3.0,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: <Widget>[
                                  new Column(


                                    children: <Widget>[
                                      new Container(
                                        margin:
                                        EdgeInsets.only(left: 12.0, top: 5.0, right: 0.0, bottom: 5.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,

                                          children: <Widget>[
                                            new Text(
                                              'Elizabeth J. Schmidt',
                                              style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 0.5,
                                              ),
                                            ),
                                            _verticalDivider(),
                                            new Text(
                                              '3674 Oakway Lane',
                                              style: TextStyle(
                                                  color: Colors.black45,
                                                  fontSize: 13.0,
                                                  letterSpacing: 0.5),
                                            ),
                                            _verticalDivider(),
                                            new Text(
                                              'Long Beach',
                                              style: TextStyle(
                                                  color: Colors.black45,
                                                  fontSize: 13.0,
                                                  letterSpacing: 0.5),
                                            ),
                                            _verticalDivider(),
                                            new Text(
                                              'CA 90802',
                                              style: TextStyle(
                                                  color: Colors.black45,
                                                  fontSize: 13.0,
                                                  letterSpacing: 0.5),
                                            ),
                                            new Container(
                                              margin: EdgeInsets.only(left: 00.0,top: 05.0,right: 0.0,bottom: 5.0),
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: <Widget>[
                                                  new Text(
                                                    'Delivery Address',
                                                    style: TextStyle(
                                                      fontSize: 15.0,
                                                      color: Colors.black12,
                                                    ),

                                                  ),
                                                  _verticalD(),

                                                  new Checkbox(
                                                    value: checkboxValueC,
                                                    onChanged: (bool value) {
                                                      setState(() {
                                                        checkboxValueC = value;
                                                      });
                                                    },
                                                  ),
                                                ],
                                              ),

                                            )
                                          ],
                                        ),
                                      ),

                                    ],
                                  ),
                                  new Container(
                                    alignment: Alignment.topLeft,
                                    child: IconButton(
                                        icon: menu,
                                        color: Colors.black38,
                                        onPressed: null),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                  ),
                  new Container(
                    margin: EdgeInsets.all(7.0),
                    child: Card(
                      elevation: 1.0,
                      child: Row(
                        children: <Widget>[
                          new IconButton(icon: keyloch, onPressed: null),
                          _verticalD(),
                          new Text(
                            'Change Password',
                            style: TextStyle(fontSize: 15.0, color: Colors.black87),
                          )
                        ],
                      ),
                    ),
                  ),
                  new Container(
                    margin: EdgeInsets.all(7.0),
                    child: Card(
                      elevation: 1.0,
                      child: Row(
                        children: <Widget>[
                          new IconButton(icon: clear, onPressed: null),
                          _verticalD(),
                          new Text(
                            'Clear History',
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.black87,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  new Container(
                    margin: EdgeInsets.all(7.0),
                    child: Card(
                      elevation: 1.0,
                      child: Row(
                        children: <Widget>[
                          new IconButton(icon: logout, onPressed: null),
                          _verticalD(),
                          new Text(
                            'Deactivate Account',
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.redAccent,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )
          )
      ),
    );
  }

  _verticalDivider() =>
      Container(
        padding: EdgeInsets.all(2.0),
      );

  _verticalD() =>
      Container(
        margin: EdgeInsets.only(left: 3.0, right: 0.0, top: 0.0, bottom: 0.0),
      );

  String displayName;

  void _showEditPopUp() {
    var alert = new AlertDialog(
      content: Form(
        key: _userormKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Display Name'),
              // ignore: missing_return
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter your Display name';
                }
              },
              onSaved: (val) => setState(() => displayName = val),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
            onPressed: () {
              final FormState form = _userormKey.currentState;
              form.save();

              print(
                  'Email: ${displayName} ::  ');
              if (displayName != null) {
                //print("inside click : " + categoryController.text);
                Auth().updateDisplayName(displayName);
                //_categoryService.createCategory(categoryController.text);
              }
              //Fluttertoast.showToast(msg: 'category created');
              Navigator.pop(context);
            },
            child: Text('ADD')),
        FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('CANCEL')),
      ],
    );
    showDialog(context: context, builder: (_) => alert);
  }


}
