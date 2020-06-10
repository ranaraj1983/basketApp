import 'dart:async';
import 'package:basketapp/model/ItemProduct.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';


class DataCollection {
  final firestoreInstance = Firestore.instance;

  void getDataFromDatabase(){
    String itemId;
    String itemName;
    String imageUrl;
    List itemList;
    //debugPrint("inside database call");
    //QuerySnapshot querySnapshot = await Firestore.instance.collection("User").getDocuments();
   firestoreInstance.collection("categories").getDocuments().then((querySnapshot) {
      querySnapshot.documents.forEach((result) {
        //debugPrint(result.data);
        //debugPrint("inside database call1");
        itemList.add(result);
        itemName = result.data['itemName'];
        imageUrl = result.data['imageUrl'];
        itemId = result.data['itemId'];

        print(result.data);
        return itemList;
      });
    });
    debugPrint("value from database : " + itemList.length.toString());
    print("value from database : " + itemName + " :: " + itemId + " :: " + imageUrl);
    debugPrint("value from database : " + itemName + " :: " + itemId + " :: " + imageUrl);
  }


}