import 'package:basketapp/Account_screen.dart';
import 'package:basketapp/HomeScreen.dart';
import 'package:basketapp/checkout_screen.dart';
import 'package:basketapp/database/Auth.dart';
import 'package:basketapp/database/DataCollection.dart';
import 'package:basketapp/item_details.dart';
import 'package:basketapp/item_screen.dart';
import 'package:basketapp/widget/WidgetFactory.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import 'package:basketapp/widget/Cart_Counter.dart';
import 'package:basketapp/model/Product_Item.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

final cartCounter = Cart_Counter();

class Custom_AppBar {
  void addValueToState() {
    cartCounter.increment();
  }

  int getCartTotalPrice() {
    int price = 0;
    cartCounter.cartList.forEach((element) {
      price += int.parse(element.price);
    });

    return price;
  }

  ObservableList<Product_Item> getCartList() {
    return cartCounter.cartList;
  }

  Widget getCartListWidgetListView() {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: cartCounter.cartList.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            //height: MediaQuery.of(context).size.height,
            child: Column(
              children: <Widget>[
                Divider(height: 15.0),
                Container(
                  padding: EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(cartCounter.cartList[index].itemName,
                          style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold)),
                      Text(cartCounter.cartList[index].quantity,
                          style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold)),
                      Text(cartCounter.cartList[index].price,
                          style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold)),
                      FlatButton(
                        color: Colors.blue,
                        textColor: Colors.white,
                        disabledColor: Colors.grey,
                        disabledTextColor: Colors.black,
                        padding: EdgeInsets.all(8.0),
                        splashColor: Colors.blueAccent,
                        onPressed: () {
                          Custom_AppBar().removeItemFromCart(cartCounter
                              .cartList[index].itemId);
                        },
                        child: Text(
                          "Cancel",
                        ),
                      )
                    ],
                  ),

                ),
                // Divider(height: 15.0),
              ],
            ),
          );
        });
  }

  void addItemToCart(String itemId, String itemName, String imageUrl,
      String description, String quantity, String price) {
    cartCounter.addCartItemToBusket(
        itemId, itemName, imageUrl, description, quantity, price);
  }

  void removeItemFromCart(String itemId) {
    cartCounter.cartList.removeWhere((element) => element.itemId == itemId);
    //cartCounter.removeCartItemFromBusket();
  }

  Widget getAppBar(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'images/goMudilogo.png',
            fit: BoxFit.contain,
            height: 32,
          ),

        ],

      ),
      backgroundColor: Colors.lime[400],
      actions: <Widget>[
        IconButton(
          tooltip: 'Search',
          icon: const Icon(Icons.search),
          onPressed: () {
            showSearch(
              context: context,
              delegate: ItemSearchDelegate(),
            );
          },
        ),
        IconButton(
          icon: Icon(Icons.shopping_cart, color: Colors.black),
          onPressed: () => {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Checkout(),
                ))
          },
        ),
        Observer(
          builder: (_) => Text(
            "${cartCounter.cartList.length}",
            style: TextStyle(fontSize: 30),
          ),
        ),
      ],
    );
  }

  void clearCart() {
    cartCounter.clearBusketCart();
  }

  int selectedPosition = 0;

  void _navigateToPage(int index, BuildContext context) {
    if (index == 0) {
      Navigator.push(context, MaterialPageRoute(
        builder: (context) => Home_screen(),
      )
      );
    } else if (index == 1) {
      print("inside offer");
      var categoryList = DataCollection().getCategories();
      categoryList.then((value) {
        value.documents.forEach((element) {
          //element.documentID;
          print(element.documentID);
        });
      });
    } else if (index == 2) {
      Navigator.push(context, MaterialPageRoute(
        builder: (context) => Account_Screen(new Auth()),
      )
      );
    }
  }

  Widget getButtomNavigation(BuildContext context, Widget widget) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text('Home'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.card_giftcard),
          title: Text('Offer'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.assignment_ind),
          title: Text('Profile'),
        ),
      ],
      currentIndex: selectedPosition,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.grey.shade100,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.black,
      onTap: (index) {
        selectedPosition = index;

        _navigateToPage(index, context);
        debugPrint(index.toString() + " :: " + selectedPosition.toString());
      },
    );
  }
/* Widget getAppBar(BuildContext context) {
    return AppBar(

      title: Text("Demo state app"),
      leading: IconButton(
        icon: Icon(Icons.shopping_cart, color: Colors.black),
        onPressed: () => {
          cartCounter.increment()
        },

      ),
      actions: <Widget>[
        Observer(
          builder: (_) => Text(
              "${cartCounter.cartList.length}",
                style: TextStyle(fontSize: 30),
          ),
        ),
        IconButton(
            icon: Icon(Icons.arrow_right),
            onPressed: () =>Navigator.push(context, MaterialPageRoute(
              builder: (context) =>State_Check_Screen(),
            ))
        ),
        IconButton(
            icon: Icon(Icons.home),
            onPressed: () =>Navigator.push(context, MaterialPageRoute(
              builder: (context) =>MyHomePage(),
            ))
        ),
        IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () =>Navigator.pop(context)
        ),
      ],
    );
  }*/
}

class ItemSearchDelegate extends SearchDelegate<Product_Item> {
  //DataCollection().getListOfProductItem();
  //loadItemList();
  //DataCollection().getListOfProductItem(output);
  List<Product_Item> output = new List<Product_Item>();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(icon: Icon(Icons.clear), onPressed: () {
      query = "";
    })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(onPressed: () async {
      await DataCollection().getListOfProductItem();
      //print(output);
      close(context, null);
    }, icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //Future result =  DataCollection().getListOfProductItem(output);

    //print(value);
    /*output = query.isEmpty? output:
     output.where((element) => element.itemName.toUpperCase().
        startsWith(query.toUpperCase())).toList();*/
    return Container(
      child: FutureBuilder(
        future: DataCollection().getCategoryList(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Searching");
          } else {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (_, index) {
                return query.isEmpty ? Container() :
                Container(
                  child: FutureBuilder(
                    future: DataCollection().getSubCollectionWithSearchKey(
                        snapshot.data[index].documentID, query),
                    builder: (_, snp) {
                      if (snp.connectionState == ConnectionState.waiting) {
                        return Text("");
                      } else {
                        return ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: snp.data.length,
                            itemBuilder: (_, ind) {
                              return !snp.data[ind].data['itemName']
                                  .toString()
                                  .toLowerCase()
                                  .
                              contains(query.toLowerCase())
                                  ? Text("")
                                  : Container(
                                child: WidgetFactory().getSearchListView(
                                    context, snapshot.data[index],
                                    snp.data[ind]),
                                /*title: Text(snp.data[ind].data['itemName'] + " :: " + snapshot.data[index].documentID),
                                        onTap: (){

                                        },*/
                              );
                            }
                        );
                      }
                    },
                  ),
                );
              },

            );
          }
        },
      ),
    );
  }


}
