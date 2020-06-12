import 'dart:async';

import 'dart:convert';
import 'dart:math';
import 'package:basketapp/database/Auth.dart';
import 'package:basketapp/model/ItemProduct.dart';
import 'package:basketapp/widget/Cart_List.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

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
    print("value from database : " + itemName + " :: " + itemId + " :: " +
        imageUrl);
    debugPrint("value from database : " + itemName + " :: " + itemId + " :: " +
        imageUrl);
  }

  void addCustomerCartToDatabase(ObservableList<Cart_Order> cartList) async {
    String userId = await Auth().getCurrentUserId();
    //List<Cart_List> listOfOrder = new List<Cart_List>();
    Random random = new Random();
    cartList.forEach((element) {
      int randomNumber = random.nextInt(100);

      firestoreInstance.collection("User").document(userId).collection(
          "#" + randomNumber.toString()).add(
          {
            'itemId': element.itemId,
            'itemName': element.itemName,
            'imageUrl': element.imageUrl,
            'description': element.description,
            'quantity': element.quantity,
            'price': element.price
          }
      );
    });
  }


}