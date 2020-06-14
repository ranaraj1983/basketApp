import 'dart:async';
import 'dart:math';
import 'package:basketapp/database/Auth.dart';
import 'package:basketapp/model/Order.dart';
import 'package:basketapp/model/Product_Item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

class DataCollection {
  final firestoreInstance = Firestore.instance;

  Future getCategoryList() async {
    QuerySnapshot qs =
        await firestoreInstance.collection("categories").getDocuments();
    return qs.documents;
  }

  void getDataFromDatabase() {
    String itemId;
    String itemName;
    String imageUrl;
    List itemList;
    //debugPrint("inside database call");
    //QuerySnapshot querySnapshot = await Firestore.instance.collection("User").getDocuments();
    firestoreInstance
        .collection("categories")
        .getDocuments()
        .then((querySnapshot) {
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
    print("value from database : " +
        itemName +
        " :: " +
        itemId +
        " :: " +
        imageUrl);
    debugPrint("value from database : " +
        itemName +
        " :: " +
        itemId +
        " :: " +
        imageUrl);
  }

  Future getOrderHistoryList() async {
    String userId = await Auth().getCurrentUserId();

    Order order;

    QuerySnapshot qs = await firestoreInstance
        .collection("User")
        .document(userId)
        .collection("orders")
        .getDocuments();

    return qs.documents;
  }

  void addCustomerCartToDatabase(ObservableList<Product_Item> cartList) async {
    String userId = await Auth().getCurrentUserId();
    //List<Cart_List> listOfOrder = new List<Cart_List>();
    Random random = new Random();
    cartList.forEach((element) {
      int randomNumber = random.nextInt(100);
      try {
        firestoreInstance
            .collection("User")
            .document(userId)
            .collection("orders")
            .document()
            .setData(({
              'itemId': element.itemId,
              'itemName': element.itemName,
              'imageUrl': element.imageUrl,
              'description': element.description,
              'quantity': element.quantity,
              'price': element.price,
              'orderId': "#GM" + randomNumber.toString(),
              "timestamp": new DateTime.now(),
              //"location":
          "orderStatus": "PLACED",
          "paymentOption": "COD",
          "totoalAmount": "2000"
        }));
      } catch (error) {
        debugPrint(error.toString());
      }
    });
  }

  Future<Widget> getImageFromStorage(BuildContext context,
      String imageUrl) async {
    return await _getImageFromStorage(imageUrl);
  }

  Future getSubCollection(String documentId) async {
    return await firestoreInstance.collection("categories")
        .document(documentId)
        .collection("item")
        .getDocuments();
  }


  Future getCategories() async {
    QuerySnapshot qs = await firestoreInstance.collection("categories")
        .getDocuments();


    return qs.documents;
  }

  Future<Widget> _getImageFromStorage(imageUrl) async {
    Image m;
    StorageReference storageReference = await FirebaseStorage.instance
        .getReferenceFromUrl(imageUrl);

    return await storageReference.getDownloadURL().then((value) {
      print(value);
      return m = Image.network(
        value.toString(),
        fit: BoxFit.scaleDown,
      );
    });
  }

  void addCategoryToDB(
      String categoryName, String categoryId, String categoryImageUrl) async {
    try {
      print("inside add category");

      await firestoreInstance
          .collection("categories")
          .document(categoryName)
          .setData({
        'categoryId': categoryId,
        'categoryName': categoryName,
        'categoryImageUrl': categoryImageUrl
      });
      print("inside add category 2");
    } catch (er) {
      print(er);
    }
  }
}