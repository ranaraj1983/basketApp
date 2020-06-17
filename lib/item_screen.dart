import 'package:basketapp/database/Auth.dart';
import 'package:basketapp/database/DataCollection.dart';
import 'package:basketapp/item_details.dart';
import 'package:basketapp/widget/Custom_AppBar.dart';
import 'package:basketapp/widget/Custom_Drawer.dart';
import 'package:basketapp/widget/Navigation_Drwer.dart';
import 'package:flutter/material.dart';

class Item_Screen extends StatefulWidget {
  String categoryName;

  Item_Screen(this.categoryName);

  @override
  _itemPageState createState() => _itemPageState(categoryName);
}

class _itemPageState extends State<Item_Screen> {
  _itemPageState(categoryName);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      drawer: Navigation_Drawer(new Auth()),
      bottomNavigationBar: Custom_AppBar().getButtomNavigation(context, widget),
      appBar: Custom_AppBar().getAppBar(context),
      body: _getItemByCategory(widget.categoryName, context),
      /*FutureBuilder(
            future: DataCollection().getCategories(),
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
                      return //Text(snapshot.data[index].data['categoryName']);
                        FutureBuilder(
                            future: DataCollection().getSubCollection(
                                snapshot.data[index].documentID),
                            builder: (_, snp) {
                              if (snp.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                  child: Text("Loading...."),
                                );
                              } else
                              if (snp.connectionState == ConnectionState.done) {
                                return GridView.builder(
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2),
                                    itemCount: snp.data.documents.length,
                                    itemBuilder: (_, index) {
                                      return Row(
                                        children: <Widget>[
                                          FutureBuilder(
                                            future: DataCollection()
                                                .getImageFromStorage(context,
                                                snp.data.documents[index]
                                                    .data['imageUrl']),
                                            builder: (context, st) {
                                              if (st.connectionState ==
                                                  ConnectionState.done) {
                                                return Container(
                                                  child: st.data,
                                                );
                                              }

                                              if (st.connectionState ==
                                                  ConnectionState.waiting) {
                                                return Container(
                                                  child: CircularProgressIndicator(),
                                                );
                                              }

                                              return Container();
                                            },

                                          ),
                                          //DataCollection().getImageFromStorage();
                                          */ /*Image.network(
                                          snp.data.documents[index].data['imageUrl'],
                                          //snp.data.documents.data[index].data['imageUrl'],
                                          height: 100,
                                          width: 100,
                                          fit: BoxFit.cover,
                                        ),*/ /*

                                        ],
                                      );
                                      //Text(snp.data.documents[0].data['itemName']);
                                    }
                                );
                              }
                              return Row(
                                children: <Widget>[
                                  Text("Something went wrong"),
                                ],
                              );
                            }
                        );
                      */ /*Expanded(



                        child: Container(

                          padding:const EdgeInsets.all(4.0),
                          child:GestureDetector(
                            onTap: (){
                              print(snapshot.data[index]);

                              Navigator.push(context, MaterialPageRoute(
                                  builder:
                                      (context)=> Item_Details(
                                        toolbarname:snapshot.data[index].
                                        data['itemName'],
                                        dataSource:snapshot.data[index],)
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
                                          "\₹ " +
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
                                                1.toString(),
                                                snapshot.data[index]
                                                    .data['price']
                                            ), */ /* */ /*Navigator.push(context,
                                            MaterialPageRoute(builder: (context)=>
                                                Item_Details())),*/ /* */ /*
                                      )
                                    ],
                                  ),

                                  //new Text("INR " + snapshot.data[index].data['price']),
                                ],
                              ),

                            ),
                          ),

                        ),
                      );*/ /*
                    });
              }
            }
            )*/
    );
  }

  Widget _getItemByCategory(String categoryName, BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Stack(
            children: <Widget>[
              FutureBuilder(
                future:
                    DataCollection().getSubCollection("6scCjL6F4AvxjWGJyAlr"),
                builder: (_, snp) {
                  if (snp.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: Text("Loading...."),
                    );
                  } else if (snp.connectionState == ConnectionState.done) {
                    return GridView.builder(
                        itemCount: snp.data.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                        itemBuilder: (_, index) {
                          if (snp.connectionState == ConnectionState.waiting) {
                            return Center(
                              child: Text("Loading...."),
                            );
                          } else {
                            return Column(
                              children: <Widget>[
                                FutureBuilder(
                                    future: DataCollection()
                                        .getImageFromStorage(context,
                                            snp.data[index].data['imageUrl']),
                                    builder: (context, st) {
                                      if (st.connectionState ==
                                          ConnectionState.done) {
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Item_Details(
                                                          toolbarname: snp
                                                              .data[index]
                                                              .data['itemName'],
                                                          dataSource:
                                                              snp.data[index],
                                                        )));

                                            debugPrint("clicked item");
                                          },
                                          child: st.data,
                                        );
                                      } else {
                                        return Container(
                                            child: CircularProgressIndicator());
                                      }
                                    }),
                                Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        snp.data[index].data['itemName'],
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 0.0),
                                      child: Text(
                                        "\₹ " + snp.data[index].data['price'],
                                      ),
                                    ),
                                    IconButton(
                                      iconSize: 20,
                                      icon: const Icon(Icons.shopping_cart),
                                      onPressed: () => Custom_AppBar()
                                          .addItemToCart(
                                              snp.data[index].data['itemId'],
                                              snp.data[index].data['itemName'],
                                              snp.data[index].data['imageUrl'],
                                              snp.data[index]
                                                  .data['description'],
                                              1.toString(),
                                              snp.data[index].data['price']),
                                    )
                                  ],
                                ),
                              ],
                            );
                          }
                        });
                  } else {
                    return Container();
                  }
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}
