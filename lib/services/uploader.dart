import 'package:flutter/material.dart';
import 'package:photouploader/models/models.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:photouploader/models/models.dart';
import 'dart:io';
import 'package:provider/provider.dart';


import 'package:photouploader/services/auth.dart';

class Uploader extends StatefulWidget {

  final File file;

  Uploader({Key key, this.file}) : super(key: key);

  @override
  _UploaderState createState() => _UploaderState();
}

class _UploaderState extends State<Uploader> {

  final FirebaseStorage _storage = FirebaseStorage(storageBucket: 'gs://photouploader-bff44.appspot.com/');


  StorageUploadTask _uploadTask;

  void _startUpload() {
    final user = Provider.of<UserModel>(context, listen: false);

    String filePath = 'image/${user.uid}/${DateTime.now()}.png';
    print('the user is:');
    print(user.uid);
    print(filePath);

    setState(() {
      _uploadTask = _storage.ref().child(filePath).putFile(widget.file);
    });

  }

  @override
  Widget build(BuildContext context) {

    if (_uploadTask != null) {
      return StreamBuilder<StorageTaskEvent>(
        stream: _uploadTask.events,
        builder: (context, snapshot) {
          var event = snapshot?.data?.snapshot;

          double progressPercent = event != null ? event.bytesTransferred / event.totalByteCount : 0;

          return Column(
            children: [
              if(_uploadTask.isComplete) Text('Upload'),

              CircularProgressIndicator(value: progressPercent),
              Text(
                '${(progressPercent * 100).toStringAsFixed(2)} % '
              ),
            ],
          );
      });
    } else {
      return RaisedButton.icon(
        label: Text('Upload Image to Cloud'),
        icon: Icon(Icons.cloud_upload),
        onPressed: _startUpload,
      );
    } return Container();
  }
}
