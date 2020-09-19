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
          Image.network(_url, height: 300),
          RaisedButton.icon(
            label: Text('Delete image'),
            icon: Icon(Icons.delete),
            onPressed: _deleteImage,
          )
        ],
      )
      :
      Column(
        children: [
          RaisedButton.icon(
            label: Text('Download Image from Cloud'),
            icon: Icon(Icons.cloud_download),
            onPressed: _startDownload,
          ),
          noImage == true ?
          Text('No image in database yet. Please upload an image') :
          Container(),
        ],
      )
      );

    }

  }

