import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:photouploader/models/models.dart';
import 'package:photouploader/services/auth.dart';
import 'package:photouploader/services/downloader.dart';
import 'package:photouploader/services/uploader.dart';
import 'package:photouploader/wrapper.dart';
import 'package:provider/provider.dart';

Future<void> main()  async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return StreamProvider<UserModel>.value(
      value: AuthService().user,
      child: MaterialApp(
        title: 'Photouploader',
        theme: ThemeData(
          primarySwatch: Colors.pink,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Wrapper(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  File _image;
  final _picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);

    setState((){
      _image = File(pickedFile.path);
    });
  }

  void deleteImage() {
    setState(() {
      _image = null;
    });
  }

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(
          color: Colors.white),
        ),
        backgroundColor: Color.fromRGBO(228, 92, 150, 1.0),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(
              Icons.person_outline,
              color: Colors.white,
            ),
            label: Text(
              'Logout',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              )
            ),
            onPressed: () async {
              await _auth.signOut();
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _image == null ?
            Column(
              children: [
                Downloader(),
              ]
            )
            :
            Column(
              children: [
                Image.file(_image, height: 300),
                Uploader(file: _image),
                RaisedButton.icon(
                  label: Text('Delete image'),
                  icon: Icon(Icons.delete),
                  onPressed: deleteImage,
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(228, 92, 150, 1.0),
        onPressed: getImage,
        tooltip: 'Increment',
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
