import 'package:flutter/material.dart';
import 'package:photouploader/authenticate/sign_in.dart';
import 'package:photouploader/models/models.dart';
import 'package:provider/provider.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserModel>(context);
    print(user);

    return Container(
      child: SignIn(),
    );
  }
}

