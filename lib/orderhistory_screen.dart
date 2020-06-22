import 'dart:io';
import 'dart:async';
import 'package:basketapp/PdfViewerPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path_provider/path_provider.dart';
import 'package:basketapp/database/Auth.dart';
import 'package:basketapp/database/DataCollection.dart';
import 'package:basketapp/widget/Custom_AppBar.dart';
import 'package:basketapp/widget/Navigation_Drwer.dart';
import 'package:basketapp/widget/WidgetFactory.dart';
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pdf;

class Oder_History extends StatefulWidget {
  final String toolbarname;

  Oder_History({Key key, this.toolbarname}) : super(key: key);

  @override
  State<StatefulWidget> createState() => oder_history(toolbarname);
}


class oder_history extends State<Oder_History> {
  bool checkboxValueA = true;
  bool checkboxValueB = false;
  bool checkboxValueC = false;
  VoidCallback _showBottomSheetCallback;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String toolbarname;

  oder_history(this.toolbarname);

  String filePath;
  String appDocPath;

  @override
  void initState() {
    super.initState();
    //prepareDirPath();
  }

  _generatePdfAndView(BuildContext context, var itemData) async {
    final pdf.Document doc = pdf.Document(deflate: zlib.encode);
    print(itemData);
    doc.addPage(
      pdf.Page(
        build: (pdf.Context context) => pdf.Center(
          child: pdf.Container(
            child: pdf.Column(children: [
              pdf.Text(itemData['price']),
            ]),
          ),
        ),
      ),
    );
    final String dir = (await getApplicationDocumentsDirectory()).path;
    final String exDir = (await getExternalStorageDirectory()).path;
    final String path = '$dir/invoice.pdf';
    final File file = File(path);
    await file.writeAsBytes(doc.save());
    print(exDir);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => PdfViewerPage(path: path),
      ),
    );
  }

  void prepareDirPath() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    Stream<FileSystemEntity> files = appDocDir.list();

    files.listen((data) {
      print("Data: " + data.toString());
    });

    final doc = pdf.Document();
    doc.addPage(
      pdf.Page(
        build: (pdf.Context context) => pdf.Center(
          child: pdf.Text('Hello World!'),
        ),
      ),
    );

    appDocPath = appDocDir.path;
    filePath = "$appDocPath/text.txt";
    Directory output = await getTemporaryDirectory();
    final file = File('${appDocPath}/example.pdf');
    file.writeAsBytesSync(doc.save());

    /*setState(() {
      final doc = pdf.Document();
      doc.addPage(
        pdf.Page(
          build: (pdf.Context context) => pdf.Center(
            child: pdf.Text('Hello World!'),
          ),
        ),
      );
      //final file = File("example.pdf");
       //await file.writeAsBytes(doc.save());
      //final file = File('example.pdf');

    });*/
    //print(files);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    IconData _backIcon() {
      switch (Theme.of(context).platform) {
        case TargetPlatform.android:
        case TargetPlatform.fuchsia:
          return Icons.arrow_back;
        case TargetPlatform.iOS:
          return Icons.arrow_back_ios;
      }
      assert(false);
      return null;
    }

    var size = MediaQuery.of(context).size;


    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;

    final Orientation orientation = MediaQuery.of(context).orientation;
    return new Scaffold(
        key: _scaffoldKey,
        drawer: Navigation_Drawer(new Auth()),
        bottomNavigationBar:
            Custom_AppBar().getButtomNavigation(context, widget),
        appBar: Custom_AppBar().getAppBar(context),
        body: FutureBuilder(
          future: DataCollection().getOrderHistoryList(),
          builder: (_, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Text("Loading...."),
              );
            } else {
              return ListView.builder(

                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  var itemData = snapshot.data[index].data;

                  return SafeArea(
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(
                              left: 5.0, right: 5.0, bottom: 5.0),
                          color: Colors.black12,
                          child: Card(
                            elevation: 4.0,
                            child: Column(
                              children: <Widget>[

                                WidgetFactory().getImageFromDatabase(
                                    context, itemData['imageUrl']),
                                ListTile(
                                  leading: Icon(Icons.album, size: 50),
                                  title: Text(itemData['itemName']),
                                  subtitle: Text(itemData['price']),
                                ),

                              ],
                            ),

                          ),
                        ),
                        RaisedButton(
                          onPressed: () {
                            _generatePdfAndView(context, itemData);
                            print("clicked");
                          },
                          child: Text("Invoice"),
                        ),
                        //Text("test"),
                      ],
                    ),
                  );
                },
              );
            }
          },

        )

    );
  }

  _verticalDivider() => Container(
    padding: EdgeInsets.all(2.0),
  );

  Widget _status(status) {
    if(status == 'Cancel Order'){
      return FlatButton.icon(
          label: Text(status,style: TextStyle(color: Colors.red),),
          icon: const Icon(Icons.highlight_off, size: 18.0,color: Colors.red,),
          onPressed: () {
            // Perform some action
          }
      );
    }
    else{
      return FlatButton.icon(
          label: Text(status,style: TextStyle(color: Colors.green),),
          icon: const Icon(Icons.check_circle, size: 18.0,color: Colors.green,),
          onPressed: () {
            // Perform some action
          }
      );
    }
    if (status == "3") {
      return Text('Process');
    } else if (status == "1") {
      return Text('Order');
    } else {
      return Text("Waiting");
    }
  }

  erticalD() => Container(
    margin: EdgeInsets.only(left: 10.0, right: 0.0, top: 0.0, bottom: 0.0),
  );

  bool a = true;
  String mText = "Press to hide";
  double _lowerValue = 1.0;
  double _upperValue = 100.0;

  void _visibilitymethod() {
    setState(() {
      if (a) {
        a = false;
        mText = "Press to show";
      } else {
        a = true;
        mText = "Press to hide";
      }
    });
  }
}
