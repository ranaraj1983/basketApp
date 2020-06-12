import 'package:basketapp/item_details.dart';
import 'package:basketapp/model/Address_model.dart';
import 'package:basketapp/widget/Custom_AppBar.dart';
import 'package:basketapp/widget/Custom_Drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class Item_Screen extends StatefulWidget {
  String toolbarname;

  Item_Screen(this.toolbarname);

  @override
  _itemPageState createState() => _itemPageState(toolbarname);
}

class _itemPageState extends State<Item_Screen> {
  _itemPageState(toolbarname);

  Future getCategories() async {
    var firestore = Firestore.instance;
    QuerySnapshot qs = await firestore.collection("categories").getDocuments();
    return qs.documents;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: Custom_AppBar().getAppBar(context),
        drawer: Custom_Drawer().getDrawer(context),
        body: FutureBuilder(
            future: getCategories(),
            builder: (_, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Text("Loading...."),
                );
              } else {
                return GridView.builder(

                    itemCount: snapshot.data.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemBuilder: (_, index) {
                      return new Expanded(

                        child: Container(

                          padding:const EdgeInsets.all(4.0),
                          child:GestureDetector(
                            onTap: (){
                              print(snapshot.data[index]);

                              Navigator.push(context, MaterialPageRoute(
                                  builder:
                                      (context)=> Item_Details(toolbarname:snapshot.data[index].data['itemName'],dataSource:snapshot.data[index],)
                              )
                              );
                            },
                            child:Card(
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Image.network(
                                        snapshot.data[index].data['imageUrl'],
                                        height: 100,
                                        width: 100,
                                        fit: BoxFit.cover,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 0.0),
                                        child: Text(
                                          snapshot.data[index].data['itemName'],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 0.0),
                                        child: Text(
                                          "INR " +
                                              snapshot.data[index].data['price'],
                                        ),
                                      ),
                                      IconButton(
                                        iconSize: 20,
                                        icon: const Icon(Icons.shopping_cart),
                                        onPressed: () =>
                                            Custom_AppBar().
                                            addItemToCart(
                                                snapshot.data[index]
                                                    .data['itemId'],
                                                snapshot.data[index]
                                                    .data['itemName'],
                                                snapshot.data[index]
                                                    .data['imageUrl'],
                                                snapshot.data[index]
                                                    .data['description'],
                                                snapshot.data[index]
                                                    .data['quantity'],
                                                snapshot.data[index]
                                                    .data['price']
                                            ), /*Navigator.push(context,
                                            MaterialPageRoute(builder: (context)=>
                                                Item_Details())),*/
                                      )
                                    ],
                                  ),

                                  //new Text("INR " + snapshot.data[index].data['price']),
                                ],
                              ),

                            ),
                          ),

                        ),
                      );
                    });
              }
            }));
  }

}
