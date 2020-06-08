import 'dart:async';

import 'package:basketapp/HomeScreen.dart';
import 'package:basketapp/database/Auth.dart';
import 'package:basketapp/model/User.dart';
import 'package:basketapp/signup_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'database/DataCollection.dart';


class Login_Screen extends StatefulWidget {


  final Key fieldKey;
  final String hintText;
  final String labelText;
  final String helperText;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onFieldSubmitted;

  const Login_Screen({Key key, this.fieldKey, this.hintText, this.labelText,
    this.helperText, this.onSaved, this.validator,
    this.onFieldSubmitted}) : super(key: key);

  ThemeData buildTheme() {
    final ThemeData base = ThemeData();
    return base.copyWith(
      hintColor: Colors.red,
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(
            color: Colors.yellow,
            fontSize: 24.0
        ),
      ),
    );
  }
  @override
  State<StatefulWidget> createState() => login();
}

class login extends State<Login_Screen> {

  ShapeBorder shape;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  String _email;
  String _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _autovalidate = false;
  bool _formWasEdited = false;

  String _validateName(String value) {
    _formWasEdited = true;
    if (value.isEmpty)
      return 'Name is required.';
    final RegExp nameExp = RegExp(r'^[A-Za-z ]+$');
    if (!nameExp.hasMatch(value))
      return 'Please enter only alphabetical characters.';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    bool _obscureText = true;
    return new Scaffold(
        key: scaffoldKey,
        appBar: new AppBar(
          title: Text('Login'),
          backgroundColor: Colors.deepOrangeAccent,
        ),
        body: SafeArea(
          child: new SingleChildScrollView(
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Container(
                  height: 50.0,
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(top: 7.0),
                  child: new Row(
                    children: <Widget>[
                      _verticalD(),
                      new GestureDetector(
                        onTap: () {

                          /* Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => login_screen()));*/
                        },
                        child: new Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      _verticalD(),
                      new GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Signup_Screen()));
                        },
                        child: new Text(
                          'Signup',
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.black26,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                new SafeArea(

                    top: false,
                    bottom: false,
                    child: Card(
                        elevation: 5.0,
                        child: Form(
                            key: formKey,
                            autovalidate: _autovalidate,
                            child: SingleChildScrollView(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    const SizedBox(height: 24.0),
                                    TextFormField(
                                      decoration: const InputDecoration(
                                          border: UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.black87,style: BorderStyle.solid),
                                          ),
                                          focusedBorder:  UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.black87,style: BorderStyle.solid),
                                          ),
                                          icon: Icon(Icons.email,color: Colors.black38,),
                                          hintText: 'Your email address',
                                          labelText: 'E-mail',
                                          labelStyle: TextStyle(color: Colors.black54)
                                      ),
                                      keyboardType: TextInputType.emailAddress,
                                      validator: (val) =>
                                      !val.contains('@') ? 'Not a valid email.' : null,
                                      onSaved: (val) => _email = val,
                                    ),

                                    const SizedBox(height: 24.0),
                                    TextFormField(
                                      obscureText: true,
                                      decoration: const InputDecoration(
                                          border: UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.black87,style: BorderStyle.solid),
                                          ),
                                          focusedBorder:  UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.black87,style: BorderStyle.solid),
                                          ),
                                          icon: Icon(Icons.lock,color: Colors.black38,),
                                          hintText: 'Your password',
                                          labelText: 'Password',
                                          labelStyle: TextStyle(color: Colors.black54)
                                      ),

                                      validator: (val) =>
                                      val.length < 6 ? 'Password too short.' : null,
                                      onSaved: (val) => _password = val,
                                    ),

                                    SizedBox(height: 35.0,),
                                    new Container(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[

                                          new Container(
                                            alignment: Alignment.bottomLeft,
                                            margin: EdgeInsets.only(left: 10.0),
                                            child: new GestureDetector(
                                              onTap: (){
                                                  debugPrint("inside forgot password");
                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext context){
                                                        return AlertDialog(
                                                          title: Text("test"),
                                                          content: Text("test")
                                                        );
                                                      }
                                                  );

                                              },
                                              child: Text('FORGOT PASSWORD?',style: TextStyle(
                                                  color: Colors.blueAccent,fontSize: 13.0
                                              ),),

                                            ),

                                          ),
                                          new Container(
                                            alignment: Alignment.bottomRight,
                                            child: new GestureDetector(
                                              onTap: (){
                                                _submit();
                                              },
                                              child: Text('LOGIN',style: TextStyle(
                                                  color: Colors.orange,fontSize: 20.0,fontWeight: FontWeight.bold
                                              ),),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    /*   const SizedBox(height:24.0),

                            new Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[

                                new GestureDetector(
                                  onTap: (){

                                  },
                                  child: Text('FORGOT PASSWORD?',style: TextStyle(
                                    color: Colors.blueAccent,fontSize: 13.0
                                  ),),
                                ),

                                new GestureDetector(
                                  onTap: (){

                                  },
                                  child: Text('LOGIN',style: TextStyle(
                                      color: Colors.orange,fontSize: 15.0
                                  ),),
                                ),

                              ],
                            )


*/
                                  ]
                              ),
                            )

                        )        //login,
                    ))
              ],
            ),
          )
        ));
  }

  void _submit() {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();

      // Email & password matched our validation rules
      // and are saved to _email and _password fields.
      performLogin(_email,_password);
    }
    else{
      showInSnackBar('Please fix the errors in red before submitting.');

    }
  }

  void showInSnackBar(String value) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(value)
    ));
  }
    User x = new User();
    void useValue(val){
      User u = new User(
        uid: val.uid,
        email: val.email,
        displayName: val.displayName,
        photoUrl: val.photoUrl,
      );
      x = u;

      debugPrint("this is my user value: " + x.email);
    }
    void _getItem(){
      new DataCollection().getDataFromDatabase();
    }
   void performLogin (email, password) async{

    _getItem();
   /* Future<FirebaseUser> user = new Auth().signIn(email, password);
    new Timer(new Duration(milliseconds: 2), () {

      user.then((value) { useValue(value); },
          onError: (e) { handleError(e); });
    });


    //auth.then((user) => userId = user.uid);
    debugPrint("inside log in function _performLogin: " + x.uid);*/
    
    //Navigator.push(context, MaterialPageRoute(builder: (context)=> Home_screen()));
  }

  _verticalD() => Container(
        margin: EdgeInsets.only(left: 10.0, right: 0.0, top: 0.0, bottom: 0.0),
      );

  void handleError(e) {
    debugPrint(e);
  }

  }
