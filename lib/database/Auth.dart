import 'dart:async';

import 'package:basketapp/model/Order.dart';
import 'package:basketapp/model/User.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

abstract class BaseAuth {
  Future<FirebaseUser>  signIn(String email, String password);

  Future<String> signUp(String email, String password);

  Future<FirebaseUser> getCurrentUser();

  Future<void> sendEmailVerification();

  Future<void> signOut();

  Future<bool> isEmailVerified();
}



class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<FirebaseUser> signIn(String email, String password)  async {
    AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    FirebaseUser user = result.user;
    //String userId = user.uid;
    return user;
  }
  void handleError(e) {
    print(e);
  }
  User _useValue(val){
    User u = new User(
      uid: val.uid,
      email: val.email,
      displayName: val.displayName,
      photoUrl: val.photoUrl,
    );

    return u;

    //print("this is my user value: " + val.email);
  }

  Future<FirebaseUser> getCurrentUserFuture() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user != null ? user : null;
    //return await _firebaseAuth.currentUser();
  }

  Future<String> getCurrentUserId() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    debugPrint("user :" + user.toString());
    return user.uid;
    //return await _firebaseAuth.currentUser();
  }

  User getUser(email, password) {
    Future<FirebaseUser> user = signIn(email, password);
    new Timer(new Duration(milliseconds: 5), () {
      user.then((usr) {
        return _useValue(usr);
      }, onError: (e) {
        handleError(e);
      });
    });
    return null;
  }

  Future<String> signUp(String email, String password) async {
    AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    FirebaseUser user = result.user;

    return user.uid;
  }

  List<Order> getOrderList() {}

  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user;
  }

  Future signOut() async {
    return _firebaseAuth.signOut();
  }

  Future<void> sendEmailVerification() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    user.sendEmailVerification();
  }

  Future<bool> isEmailVerified() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.isEmailVerified;
  }
}

