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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton.icon(
              label: Text('Sign In Anonymously'),
              icon: Icon(Icons.login),
              onPressed: () async {
                setState(() => loading = true);
                loading = true;
                dynamic result = await _auth.signInAnonym();
                if (result == null) {
                  setState(() => loading = false);
                  print('Error while signing in');
                } else {
                  setState(() => loading = false);
                  print('Signed in with result.uid:');
                  print(result.uid);
                }
              },
            ),
            RaisedButton.icon(
              label: Text('Sign In With Google'),
              icon: Icon(Icons.login),
              onPressed: () async {
                setState(() => loading = true);
                loading = true;
                dynamic result = await _auth.signInAnonym();
                if (result == null) {
                  setState(() => loading = false);
                  print('Error while signing in');
                } else {
                  setState(() => loading = false);
                  print('Signed in with result.uid:');
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
