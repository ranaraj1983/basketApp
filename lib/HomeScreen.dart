import 'package:basketapp/Cart_Screen.dart';
import 'package:basketapp/database/Auth.dart';
import 'package:basketapp/database/DataCollection.dart';
import 'package:basketapp/help_screen.dart';
import 'package:basketapp/item_screen.dart';
import 'package:basketapp/logind_signup.dart';
import 'package:basketapp/orderhistory_screen.dart';
import 'package:basketapp/widget/Navigation_Drwer.dart';
import 'package:basketapp/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:loader_search_bar/loader_search_bar.dart';
import 'package:flutter/foundation.dart';
import 'Account_screen.dart';

const String _kGalleryAssetsPackage = 'flutter_gallery_assets';

class Home_screen extends StatefulWidget {
  //final Auth auth;

  @override
  State<StatefulWidget> createState() => new home();
// TODO: implement createState

}

class Photo {
  Photo({
    this.assetName,
    this.assetPackage,
    this.title,
    this.caption,
  });

  final String assetName;
  final String assetPackage;
  final String title;
  final String caption;
}

class home extends State<Home_screen> {
  List list = ['12', '11', '2'];

  List<Photo> photos = <Photo>[
    Photo(
      assetName: 'images/veg.jpg',
      title: 'Fruits & Vegetables',
    ),
    Photo(
      assetName: 'images/frozen.jpg',
      title: 'Frozen Veg',
    ),
    Photo(
      assetName: 'images/bev.jpg',
      title: 'Beverages',
    ),
    Photo(
      assetName: 'images/brand_f.jpg',
      title: 'Brannded Food',
    ),
    Photo(
      assetName: 'images/be.jpg',
      title: 'Beauty & Personal Care',
    ),
    Photo(
      assetName: 'images/home.jpg',
      title: 'Home Care & Fashion',
    ),
    Photo(
      assetName: 'images/nonveg.jpg',
      title: 'Non Veg',
    ),
    Photo(
      assetName: 'images/eggs.jpg',
      title: 'Dairy, Bakery & Eggs',
    ),
  ];

  static const double height = 366.0;
  String name ='My Wishlist';
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final Orientation orientation = MediaQuery.of(context).orientation;
    final ThemeData theme = Theme.of(context);
    final TextStyle titleStyle =
        theme.textTheme.headline5.copyWith(color: Colors.black54);
    final TextStyle descriptionStyle = theme.textTheme.subhead;
    ShapeBorder shapeBorder;


    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.greenAccent,

        title: Text("Grocery store"),
        actions: <Widget>[
          IconButton(
            tooltip: 'Search',
            icon: const Icon(Icons.search),
            onPressed: () async {
              final int selected = await showSearch<int>(
                context: context,
                //delegate: _delegate,
              );

            },
          ),
          new Padding(
            padding: const EdgeInsets.all(10.0),
            child: new Container(
              height: 150.0,
              width: 30.0,
              child: new GestureDetector(
                onTap: () {
                  /*Navigator.of(context).push(
                  new MaterialPageRoute(
                      builder:(BuildContext context) =>
                      new CartItemsScreen()
                  )
              );*/
                },
                child: Stack(
                  children: <Widget>[
                    new IconButton(
                        icon: new Icon(
                          Icons.add_shopping_cart,
                          color: Colors.black,
                        ),
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Cart_screen()));
                        }),
                    list.length == 0
                        ? new Container()
                        : new Positioned(
                            child: new Stack(
                            children: <Widget>[
                              new Icon(Icons.brightness_1,
                                  size: 20.0, color: Colors.orange.shade500),
                              new Positioned(
                                  top: 4.0,
                                  right: 5.5,
                                  child: new Center(
                                    child: new Text(
                                      list.length.toString(),
                                      style: new TextStyle(
                                          color: Colors.white,
                                          fontSize: 11.0,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  )),
                            ],
                            )),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      drawer: Navigation_Drawer(new Auth()),
      body: new SingleChildScrollView(
        child: Container(
          child: new Column(children: <Widget>[
            new Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _verticalD(),
                  new GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Item_Screen('Best value Products')));
                    },
                    child: new Text(
                      'Best value',
                      style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  _verticalD(),
                  new GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) =>
                              Item_Screen('Top sellers')));
                    },
                    child: new Text(
                      'Top sellers',
                      style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black26,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  _verticalD(),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      new GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => Item_Screen('All Product')
                          ));
                        },
                        child: new Text(
                          'All',
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.black26,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      _verticalD(),
                      IconButton(
                        icon: keyloch,
                        color: Colors.black26,
                      )
                    ],
                  )
                ]),
            new Container(
              height: 188.0,
              margin: EdgeInsets.only(left: 5.0),
              child:
                  ListView(scrollDirection: Axis.horizontal, children: <Widget>[
                SafeArea(
                  top: true,
                  bottom: true,
                  child: Container(
                    width: 270.0,

                    child: Card(
                      shape: shapeBorder,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 180.0,
                            child: Stack(
                              children: <Widget>[
                                Positioned.fill(
                                  child: Image.asset(
                                    'images/grthre.jpg',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            ),
                          )


                        ],
                      ),
                    ),
                    // description and share/explore buttons
                    // share, explore buttons
                  ),
                ),
                SafeArea(
                  top: true,
                  bottom: true,
                  child: Container(
                    width: 270.0,

                    child: Card(
                      shape: shapeBorder,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 180.0,
                            child: Stack(
                              children: <Widget>[
                                Positioned.fill(
                                  child: Image.asset(
                                    'images/grtwo.jpg',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            ),
                          )


                        ],
                      ),
                    ),
                    // description and share/explore buttons
                    // share, explore buttons
                  ),
                ),
                SafeArea(
                  top: true,
                  bottom: true,
                  child: Container(
                    width: 270.0,

                    child: Card(
                      shape: shapeBorder,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 180.0,
                            child: Stack(
                              children: <Widget>[
                                Positioned.fill(
                                  child: Image.asset(
                                    'images/groceries.jpg',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            ),
                          )


                        ],
                      ),
                    ),
                    // description and share/explore buttons
                    // share, explore buttons
                  ),
                ),
                SafeArea(
                  top: true,
                  bottom: true,
                  child: Container(
                    width: 270.0,

                    child: Card(
                      shape: shapeBorder,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 180.0,
                            child: Stack(
                              children: <Widget>[
                                Positioned.fill(
                                  child: Image.asset(
                                    'images/back.jpg',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            ),
                          )


                        ],
                      ),
                    ),
                    // description and share/explore buttons
                    // share, explore buttons
                  ),
                ),
              ]),
            ),
            new Container(
              margin: EdgeInsets.only(top: 7.0),
              child: new Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _verticalD(),
                    new GestureDetector(
                      onTap: () {
                        //Navigator.push(context, MaterialPageRoute(builder: (context)=> Item_Screen(toolbarname: 'Fruits & Vegetables',)));
                      },
                      child: new Text(
                        'Categories',
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    _verticalD(),
                    new GestureDetector(
                      onTap: () {
                        //Navigator.push(context, MaterialPageRoute(builder: (context)=> Item_Screen(toolbarname: 'Fruits & Vegetables',)));
                      },
                      child: new Text(
                        'Popular',
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black26,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    _verticalD(),

                    new Row(
                      children: <Widget>[
                        new GestureDetector(
                          onTap: () {
                            //Navigator.push(context, MaterialPageRoute(builder: (context)=> Item_Screen(toolbarname: 'Fruits & Vegetables',)));
                          },
                          child: new Text(
                            'Whats New',
                            style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.black26,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    )
                  ]),
            ),
            new Container(
              alignment: Alignment.topCenter,
              height: 700.0,

              child: FutureBuilder(
                  future: DataCollection().getCategoryList(),
                  builder: (_, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: Text("Loading...."),
                      );
                    } else {
                      return GridView.builder(
                          primary: false,
                          physics: NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(10.0),
                          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            var d = snapshot.data;
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) =>
                                        Item_Screen(
                                            d[index].data['categoryName'])));
                              },
                              child: Column(
                                children: <Widget>[
                                  FutureBuilder(
                                    future: DataCollection()
                                        .getImageFromStorage(context,
                                        d[index].data['categoryImageUrl']),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.done) {
                                        return Container(
                                          child: snapshot.data,
                                        );
                                      }

                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Container(
                                          child: CircularProgressIndicator(),
                                        );
                                      }

                                      return Container();
                                    },

                                  ),
                                  Text(d[index].data['categoryName']),
                                  //Image.network(d[index].data['categoryImageUrl']),

                                ],
                              ),


                            );
                          }
                      );
                    }
                  }
              ),
              /* new GridView.builder(
                  itemCount: photos.length,
                  primary: false,
                  physics: NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(10.0),
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (BuildContext context, int index) {
                    return new GestureDetector(
                      onTap: (){

                        //Navigator.push(context, MaterialPageRoute(builder: (context)=> Item_Screen(toolbarname: 'Fruits & Vegetables',)));
                      },

                        child: new Container(
                            margin: EdgeInsets.all(5.0),
                            child: new Card(
                              shape: shapeBorder,
                              elevation: 3.0,
                              child: new Container(
                                //  mainAxisSize: MainAxisSize.max,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    SizedBox(
                                      height: 152.0,
                                      child: Stack(
                                        children: <Widget>[
                                          Positioned.fill(
                                              child: Image.asset(
                                            photos[index].assetName,
                                            fit: BoxFit.cover,
                                          )),
                                          Container(
                                            color: Colors.black38,
                                          ),
                                          Container(
                                            //margin: EdgeInsets.only(left: 10.0),
                                            padding: EdgeInsets.only(
                                                left: 3.0, bottom: 3.0),
                                            alignment: Alignment.bottomLeft,
                                            child: new GestureDetector(
                                              onTap: () {
                                                //Navigator.push(context, MaterialPageRoute(builder: (context)=> Item_Screen(toolbarname: 'Fruits & Vegetables',)));
                                              },
                                              child: new Text(
                                                photos[index].title,
                                                style: TextStyle(
                                                    fontSize: 18.0,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),


                                        ],
                                      ),
                                    ),

                                    // new Text(photos[index].title.toString()),
                                  ],
                                ),
                              ),
                            )
                        )

                    );
                  }),*/
            )
          ]),
        ),
      ),
    );
  }


  Icon keyloch = new Icon(
    Icons.arrow_forward,
    color: Colors.black26,
  );

  _verticalD() => Container(
        margin: EdgeInsets.only(left: 5.0, right: 0.0, top: 5.0, bottom: 0.0),
      );


}
