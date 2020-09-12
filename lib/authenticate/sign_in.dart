import 'package:flutter/material.dart';
import 'package:photouploader/services/auth.dart';
import 'package:photouploader/services/loading.dart';


class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      //backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: Text('Sign In'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          children: [
            RaisedButton(
              child: Text('Sign In Anonymously'),
              onPressed: () async {
                setState(() => loading = true);
                loading = true;
                dynamic result = await _auth.signInAnonym();
                if (result == null) {
                  setState(() => loading = false);
                  print('Error while signing in');
                } else {
                  setState(() => loading = false);
                  print('Signed in');
                  print(result.uid);
                }
              },
            ),
            RaisedButton(
              child: Text('Sign In With Google'),
              onPressed: () async {
                setState(() => loading = true);
                loading = true;
                dynamic result = await _auth.signInAnonym();
                if (result == null) {
                  setState(() => loading = false);
                  print('Error while signing in');
                } else {
                  setState(() => loading = false);
                  print('Signed in');
                  print(result.uid);
                }
              },
            ),
        ],
        ),
      )
    );
  }
}
