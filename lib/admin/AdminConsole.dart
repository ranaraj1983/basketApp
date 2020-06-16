import 'package:basketapp/database/DataCollection.dart';
import 'package:basketapp/model/Category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

//import 'package:fluttertoast/fluttertoast.dart';
//import '../db/category.dart';
//import '../db/brand.dart';

enum Page { dashboard, manage }

class AdminConsole extends StatefulWidget {
  @override
  _AdminConsole createState() => _AdminConsole();
}

class _AdminConsole extends State<AdminConsole> {
  var categoryName = "baby food";
  var selectedCurrency, selectedType;
  Page _selectedPage = Page.dashboard;
  MaterialColor active = Colors.red;
  MaterialColor notActive = Colors.grey;
  TextEditingController categoryController = TextEditingController();
  TextEditingController brandController = TextEditingController();
  GlobalKey<FormState> _categoryFormKey = GlobalKey();
  GlobalKey<FormState> _brandFormKey = GlobalKey();

  //BrandService _brandService = BrandService();
  //CategoryService _categoryService = CategoryService();

  final _category = new Category(null, null, null, null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: <Widget>[
              Expanded(
                  child: FlatButton.icon(
                      onPressed: () {
                        setState(() => _selectedPage = Page.dashboard);
                      },
                      icon: Icon(
                        Icons.dashboard,
                        color: _selectedPage == Page.dashboard
                            ? active
                            : notActive,
                      ),
                      label: Text('Dashboard'))),
              Expanded(
                  child: FlatButton.icon(
                      onPressed: () {
                        setState(() => _selectedPage = Page.manage);
                      },
                      icon: Icon(
                        Icons.sort,
                        color:
                        _selectedPage == Page.manage ? active : notActive,
                      ),
                      label: Text('Manage'))),
            ],
          ),
          elevation: 0.0,
          backgroundColor: Colors.white,
        ),
        body: _loadScreen());
  }

  Widget _loadScreen() {
    switch (_selectedPage) {
      case Page.dashboard:
        return Column(
          children: <Widget>[
            ListTile(
              subtitle: FlatButton.icon(
                onPressed: null,
                icon: Icon(
                  Icons.attach_money,
                  size: 30.0,
                  color: Colors.green,
                ),
                label: Text('12,000',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30.0, color: Colors.green)),
              ),
              title: Text(
                'Revenue',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24.0, color: Colors.grey),
              ),
            ),
            Expanded(
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Card(
                      child: ListTile(
                          title: FlatButton.icon(
                              onPressed: null,
                              icon: Icon(Icons.people_outline),
                              label: Text("Users")),
                          subtitle: Text(
                            '7',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: active, fontSize: 60.0),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Card(
                      child: ListTile(
                          title: FlatButton.icon(
                              onPressed: null,
                              icon: Icon(Icons.category),
                              label: Text("Categories")),
                          subtitle: Text(
                            '23',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: active, fontSize: 60.0),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(22.0),
                    child: Card(
                      child: ListTile(
                          title: FlatButton.icon(
                              onPressed: null,
                              icon: Icon(Icons.track_changes),
                              label: Text("Producs")),
                          subtitle: Text(
                            '120',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: active, fontSize: 60.0),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(22.0),
                    child: Card(
                      child: ListTile(
                          title: FlatButton.icon(
                              onPressed: null,
                              icon: Icon(Icons.tag_faces),
                              label: Text("Sold")),
                          subtitle: Text(
                            '13',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: active, fontSize: 60.0),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(22.0),
                    child: Card(
                      child: ListTile(
                          title: FlatButton.icon(
                              onPressed: null,
                              icon: Icon(Icons.shopping_cart),
                              label: Text("Orders")),
                          subtitle: Text(
                            '5',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: active, fontSize: 60.0),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(22.0),
                    child: Card(
                      child: ListTile(
                          title: FlatButton.icon(
                              onPressed: null,
                              icon: Icon(Icons.close),
                              label: Text("Return")),
                          subtitle: Text(
                            '0',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: active, fontSize: 60.0),
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
        break;
      case Page.manage:
        return ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.add),
              title: Text("Add product"),
              onTap: () {
                _createProduct();
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.change_history),
              title: Text("Products list"),
              onTap: () {},
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.add_circle),
              title: Text("Add category"),
              onTap: () {
                _categoryAlert();
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.category),
              title: Text("Category list"),
              onTap: () {},
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.add_circle_outline),
              title: Text("Add brand"),
              onTap: () {
                _brandAlert();
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.library_books),
              title: Text("brand list"),
              onTap: () {},
            ),
            Divider(),
          ],
        );
        break;
      default:
        return Container();
    }
  }

  void _createProduct() {
    String itemName;
    String itemId;
    String imageUrl;
    String price;
    String stock;
    String description;
    String quantity = 1.toString();

    String dropdownValue = 'One';
    List<String> val = ["1", "2"];
    var alert = SingleChildScrollView(
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
                    List<DropdownMenuItem> currencyItems = [];
                    for (int i = 0; i < snapshot.data.length; i++) {
                      //DocumentSnapshot snap = snapshot.data.documents[i];
                      currencyItems.add(
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
                        DropdownButton(
                          items: currencyItems,
                          onChanged: (currencyValue) {
                            final snackBar = SnackBar(
                              content: Text(
                                'Selected Currency value is $currencyValue',
                                style: TextStyle(color: Color(0xff11b719)),
                              ),
                            );
                            //Scaffold.of(context).showSnackBar(snackBar);
                            setState(() {
                              print(currencyValue + " :: ");
                              //selectedCurrency = currencyValue;
                              categoryName = currencyValue;
                              print(currencyValue + " :: " + categoryName);
                            });
                          },
                          value: categoryName,
                        ),
                        SizedBox(width: 50.0),
                      ],
                    );
                  }
                  //return Container();
                }),
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
            onPressed: () {
              final FormState form = _categoryFormKey.currentState;
              form.save();

              print('Email: ${itemName} ::  ${itemId} ::  ${description}');
              if (itemName != null) {
                //print("inside click : " + categoryController.text);
                DataCollection().addProductToDB(itemName, itemId, description,
                    price, quantity, stock, categoryName);
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
    showDialog(context: context, builder: (_) => alert);
  }

  void _categoryAlert() {
    String categoryName;
    String categoryId;
    String categoryImageUrl;

    var alert = new AlertDialog(
      content: Form(
        key: _categoryFormKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Category Name'),
              // ignore: missing_return
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter your first name';
                }
              },
              onSaved: (val) => setState(() => categoryName = val),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Category Id'),
              // ignore: missing_return
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter your first name';
                }
              },
              onSaved: (val) => setState(() => categoryId = val),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Category Image Url'),
              // ignore: missing_return
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter your first name';
                }
              },
              onSaved: (val) => setState(() => categoryImageUrl = val),
            ),

          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
            onPressed: () {
              final FormState form = _categoryFormKey.currentState;
              form.save();

              print(
                  'Email: ${categoryName} ::  ${categoryId} ::  ${categoryImageUrl}');
              if (categoryName != null) {
                //print("inside click : " + categoryController.text);
                DataCollection().addCategoryToDB(
                    categoryName, categoryId, categoryImageUrl);
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
    );

    showDialog(context: context, builder: (_) => alert);
  }

  void _brandAlert() {
    var alert = new AlertDialog(
      content: Form(
        key: _brandFormKey,
        child: TextFormField(
          controller: brandController,
          validator: (value) {
            if (value.isEmpty) {
              return 'category cannot be empty';
            }
          },
          decoration: InputDecoration(hintText: "add brand"),
        ),
      ),
      actions: <Widget>[
        FlatButton(
            onPressed: () {
              if (brandController.text != null) {
                //_brandService.createBrand(brandController.text);
              }
              //Fluttertoast.showToast(msg: 'brand added');
              Navigator.pop(context);
            },
            child: Text('ADD')),
        FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('CANCEL')),
      ],
    );

    showDialog(context: context, builder: (_) => alert);
  }
}
