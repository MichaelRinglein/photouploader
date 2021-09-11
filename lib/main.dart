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
import 'package:flutter/foundation.dart' show kIsWeb;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserModel>.value(
      initialData: UserModel(),
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
    final pickedFile =
        await _picker.pickImage(source: ImageSource.gallery, maxHeight: 300);

    setState(() {
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
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromRGBO(228, 92, 150, 1.0),
        actions: <Widget>[
          TextButton.icon(
            icon: Icon(
              Icons.person_outline,
              color: Colors.white,
            ),
            label: Text('Logout',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                )),
            onPressed: () async {
              await _auth.signOut();
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _image == null
                  ? Column(children: [
                      Downloader(),
                    ])
                  : Column(
                      children: [
                        kIsWeb == true
                            ? Image.network(
                                _image.path,
                              )
                            : Image.file(File(
                                _image.path,
                              )),
/*
                        Image.file(
                          _image,
                          height: 300,
                        ),
                        */
                        Uploader(file: _image),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            primary: Color.fromRGBO(228, 92, 150, 1.0),
                          ),
                          label: Text('Delete image',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              )),
                          icon: Icon(
                            Icons.delete_outline,
                            color: Colors.white,
                          ),
                          onPressed: deleteImage,
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(247, 17, 115, 1.0),
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
