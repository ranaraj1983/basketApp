import 'dart:io';

import 'package:basketapp/database/DataCollection.dart';
import 'package:basketapp/widget/Custom_AppBar.dart';
import 'package:basketapp/widget/Navigation_Drwer.dart';
import 'package:basketapp/widget/WidgetFactory.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

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
  File _image;
  final formKey = GlobalKey<FormState>();

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
            child: new Expanded(
              //elevation: 3.0,
              child: Column(
                children: <Widget>[
                  new Container(
                      alignment: Alignment.topCenter,
                      child: Container(
                        margin: const EdgeInsets.all(10.0),
                        // padding: const EdgeInsets.all(3.0),
                        child: ClipOval(
                          child: Row(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Container(
                                    child: WidgetFactory().getImageFromDatabase(
                                        context, firebaseUser.photoUrl),
                                  ),
                                ],
                              ),
                              /*WidgetFactory().getImageFromDatabase(
                                          context, firebaseUser.photoUrl),*/
                              Container(
                                child: IconButton(
                                  icon: Icon(
                                    FontAwesomeIcons.camera,
                                    size: 30.0,
                                  ),
                                  onPressed: () {
                                    _getImage(context);
                                    debugPrint("change image");
                                  },
                                ),
                              ),
                              FlatButton(
                                //onPressed: Auth().updateProfileImage(),
                                child: Text(
                                  'Change',
                                  style: TextStyle(
                                      fontSize: 13.0, color: Colors.blueAccent),
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(30.0),
                                    side: BorderSide(color: Colors.blueAccent)),
                                onPressed: () {
                                  DataCollection()
                                      .uploadImageToStorageAndProfileImge(
                                          context, _image, _scaffoldKey);
                                  debugPrint("change image");
                                },
                              ),
                            ],
                          ),
                        ),
                      )),

                  new Column(
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
                                      "${firebaseUser.phoneNumber}",
                                      style: TextStyle(
                                          color: Colors.black45,
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 0.5),
                                    ),
                                    _verticalDivider(),
                                    new Text(
                                      "${firebaseUser.email}",
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
                    EdgeInsets.only(
                        left: 12.0, top: 5.0, right: 0.0, bottom: 5.0),
                    child: new Text(
                      'Addresses',
                      style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),
                    ),
                  ),
                  WidgetFactory().getAddressBar(context, formKey),

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

  void _getImage(BuildContext context) async {
    final _picker = ImagePicker();
    PickedFile imagePath = await _picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(imagePath.path);
    });
  }


}
