import 'dart:io';

import 'package:basketapp/database/Auth.dart';
import 'package:basketapp/database/DataCollection.dart';
import 'package:basketapp/widget/Custom_AppBar.dart';
import 'package:basketapp/widget/Navigation_Drwer.dart';
import 'package:basketapp/widget/WidgetFactory.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddProduct_Screen extends StatefulWidget {
  @override
  _AddProduct_Screen createState() => _AddProduct_Screen();
}

class _AddProduct_Screen extends State<AddProduct_Screen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> _categoryFormKey = GlobalKey();
  GlobalKey<FormState> _brandFormKey = GlobalKey();
  File _image;
  String categoryName;

  @override
  void initState() {
    super.initState();
    setState(() {
      categoryName = "Beverrages";
    });
    //prepareDirPath();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Navigation_Drawer(new Auth()),
      bottomNavigationBar: Custom_AppBar().getButtomNavigation(context, widget),
      appBar: Custom_AppBar().getAppBar(context),
      body: _addProductScreenBody(context),
    );
  }

  Widget _addProductScreenBody(BuildContext context) {
    String itemName;
    String itemId;
    String imageUrl;
    String price;
    String stock;
    String description;
    String brandName;
    String unit;
    String offer;
    String quantity = 1.toString();

    return StatefulBuilder(builder: (context, setState) {
      return SingleChildScrollView(
          child: AlertDialog(
        content: Form(
          key: _categoryFormKey,
          child: Column(
            children: <Widget>[
              FutureBuilder(
                  future: DataCollection().getCategoryList(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      return const Text("Loading.....");
                    else {
                      List<DropdownMenuItem> itemValues = [];
                      for (int i = 0; i < snapshot.data.length; i++) {
                        //DocumentSnapshot snap = snapshot.data.documents[i];
                        itemValues.add(
                          DropdownMenuItem(
                            child: Text(
                              snapshot.data[i].documentID,
                              style: TextStyle(color: Color(0xff11b719)),
                            ),
                            value: "${snapshot.data[i].documentID}",
                          ),
                        );
                      }
                      return Row(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              DropdownButton(
                                items: itemValues,
                                isDense: true,
                                value: categoryName,
                                onChanged: (itemValue) {
                                  setState(() {
                                    //selectedCurrency = currencyValue;
                                    categoryName = itemValue;
                                    print(itemValue + " :: " + categoryName);
                                  });
                                  return Text(itemValue);
                                  /*SnackBar(
                                  content: Text(
                                    'Selected Currency value is $itemValue',
                                    style: TextStyle(color: Color(0xff11b719)),
                                  ),
                                );*/
                                },
                              ),
                            ],
                          ),
                        ],
                      );
                    }

                    //return Container();
                  }),
              /*GridView.count(
              crossAxisCount: 3,

            ),*/
              /*GridView.count(
                          crossAxisCount: 3,
                          crossAxisSpacing: 4,
                          mainAxisSpacing: 4,
                          primary: false,
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(20),
                          children: <Widget>[
                            GestureDetector(
                              onTap: (){},
                              child: Container(
                                color: Colors.black12,
                                child: Icon(FontAwesomeIcons.plusCircle),
                              ),
                            ),
                          ],

                        ),*/
              GestureDetector(
                child: _image == null
                    ? WidgetFactory().getImageFromDatabase(context,
                        "gs://gomodi-ee0d7.appspot.com/category/OIL/Screenshot 2020-06-19 at 20.01.36.png")
                    : Image.file(_image),
                onTap: () async {
                  final _picker = ImagePicker();
                  PickedFile imagePath =
                      await _picker.getImage(source: ImageSource.gallery);
                  setState(() {
                    _image = File(imagePath.path);
                    print("imagePath $_image");

                    /*DataCollection().uploadImageToStorageAndProfileImge(
                                  context, _image, null);*/
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Product Name'),
                // ignore: missing_return
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your Product name';
                  }
                },

                onSaved: (val) => setState(() => itemName = val),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Product Id'),
                // ignore: missing_return
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your Product id';
                  }
                },
                onSaved: (val) => setState(() => itemId = val),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Unit'),
                // ignore: missing_return
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your unit';
                  }
                },
                onSaved: (val) => setState(() => unit = val),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Product Brand'),
                // ignore: missing_return
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your Product brand name';
                  }
                },
                onSaved: (val) => setState(() => brandName = val),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Stock'),
                // ignore: missing_return
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your Product Stock';
                  }
                },
                onSaved: (val) => setState(() => stock = val),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                // ignore: missing_return
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your Description';
                  }
                },
                onSaved: (val) => setState(() => description = val),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Price'),
                // ignore: missing_return
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your Product Price';
                  }
                },
                onSaved: (val) => setState(() => price = val),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
              onPressed: () async {
                final FormState form = _categoryFormKey.currentState;
                form.save();

                print('Email: ${itemName} ::  ${itemId} ::  ${description}');
                if (itemName != null) {
                  //print("inside click : " + categoryController.text);
                  String imageUrl = await DataCollection()
                      .uploadImageToStorageAndProductImge(
                          context, _image, null, categoryName, itemName);

                  DataCollection().addProductToDB(
                      itemName,
                      itemId,
                      description,
                      price,
                      quantity,
                      stock,
                      categoryName,
                      brandName,
                      imageUrl,
                      unit,
                      offer);
                  //_categoryService.createCategory(categoryController.text);
                }
                //Fluttertoast.showToast(msg: 'category created');
                Navigator.pop(context);
              },
              child: Text('ADD')),
          FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('CANCEL')),
        ],
      ));
    });
  }
}
