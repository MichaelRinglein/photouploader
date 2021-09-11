//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:photouploader/models/models.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:provider/provider.dart';

class Uploader extends StatefulWidget {
  final File file;

  Uploader({Key key, this.file}) : super(key: key);

  @override
  _UploaderState createState() => _UploaderState();
}

class _UploaderState extends State<Uploader> {
  final FirebaseStorage _storage = FirebaseStorage.instanceFor(
      bucket: 'gs://photouploader-bff44.appspot.com/');
  UploadTask _uploadTask;

  void _startUpload() async {
    final user = Provider.of<UserModel>(context, listen: false);
    String filePath = 'image/${user.uid}/${user.uid}.png';

    setState(() {
      _uploadTask = _storage.ref().child(filePath).putFile(widget.file);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_uploadTask != null) {
      return StreamBuilder<TaskSnapshot>(
          stream: _uploadTask.snapshotEvents,
          builder: (context, snapshot) {
            var event = snapshot?.data;
            double progressPercent =
                event != null ? event.bytesTransferred / event.totalBytes : 0;
            return Column(
              children: [
                if (event.state == TaskState.running)
                  Column(
                    children: [
                      CircularProgressIndicator(value: progressPercent),
                      Text('${(progressPercent * 100).toStringAsFixed(2)} % '),
                      Text('Uploading...'),
                    ],
                  ),
                if (event.state == TaskState.success)
                  Text(
                    'Image uploaded',
                    style: TextStyle(
                      color: Colors.green,
                    ),
                  )
              ],
            );
          });
    } else {
      return Column(
        children: [
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              primary: Color.fromRGBO(228, 92, 150, 1.0),
            ),
            label: Text(
              'Upload Image to Cloud',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            icon: Icon(
              Icons.cloud_upload_outlined,
              color: Colors.white,
            ),
            onPressed: _startUpload,
          ),
        ],
      );
    }
    //return Container();
  }
}
