import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:photouploader/models/models.dart';
import 'package:provider/provider.dart';

class Downloader extends StatefulWidget {
  @override
  _DownloaderState createState() => _DownloaderState();
}

class _DownloaderState extends State<Downloader> {

  final FirebaseStorage _storage = FirebaseStorage(storageBucket: 'gs://photouploader-bff44.appspot.com/');
  String _url;
  bool noImage = false;

  void _startDownload() async {
    try {
      final user = Provider.of<UserModel>(context, listen: false);
      String filePath = 'image/${user.uid}/${user.uid}.png';

      _url = await _storage.ref().child(filePath).getDownloadURL();

      setState(() {
        String url = _url;
      });
    } catch(e) {
      print(e.toString());

      setState(() {
        noImage = true;
      });
    }

    print(noImage);

  }

  void _deleteImage() {
    setState(() {
      _url = null;
    });
  }

    @override
    Widget build(BuildContext context) {
      return (
      _url != null ?
      Column(
        children: [
          RaisedButton.icon(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: Color.fromRGBO(228, 92, 150, 1.0),
            label: Text(
              'Delete image',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            icon: Icon(
              Icons.delete,
              color: Colors.white,
            ),
            onPressed: _deleteImage,
          )
        ],
      )
      :
      Column(
        children: [
          Image(
            image: AssetImage('assets/laptop.png'),
          ),
          RaisedButton(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: Color.fromRGBO(228, 92, 150, 1.0),
            child: Text(
              'Download Image from Cloud',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            onPressed: _startDownload,
          ),
          noImage == true ?
          Text(
              'No image in database yet. Please upload an image',
              style: TextStyle(
                color: Colors.red,
              ),
          ) :
          Container(),
        ],
      )
      );

    }

  }

