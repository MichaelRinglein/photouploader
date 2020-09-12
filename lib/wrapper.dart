import 'package:photouploader/main.dart';
import 'package:photouploader/models/models.dart';
import 'package:photouploader/authenticate/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);

    if (user == null) {
      return Authenticate();
    } else {
      // return Home or Authenticate widget
      return MyHomePage(title: 'Photouploader');
    }
  }
}
