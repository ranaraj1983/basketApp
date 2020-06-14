import 'package:basketapp/checkout_screen.dart';
import 'package:basketapp/widget/Navigation_Drwer.dart';
import 'package:basketapp/widget/Custom_Drawer.dart';
import 'package:flutter/material.dart';

//import 'package:flutter_mobx/flutter_mobx.dart';
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
        itemCount: cartCounter.cartList.length,
        itemBuilder: (BuildContext context, int index) {
          return SingleChildScrollView(
            //height: MediaQuery.of(context).size.height,
            child: Column(

              children: <Widget>[
                Divider(height: 15.0),
                Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height,
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
                Divider(height: 15.0),
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
      title: Text("Go Mudi"),
      backgroundColor: Colors.yellowAccent,
      actions: <Widget>[
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
