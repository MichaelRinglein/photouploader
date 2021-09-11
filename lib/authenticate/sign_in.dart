import 'package:flutter/material.dart';
import 'package:photouploader/services/auth.dart';
import 'package:photouploader/services/loading.dart';
//import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: Text(
                'Sign In',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              backgroundColor: Color.fromRGBO(228, 92, 150, 1.0),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      primary: Color.fromRGBO(228, 92, 150, 1.0),
                    ),
                    label: Text(
                      'Sign In Anonymously',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    icon: Icon(
                      Icons.login,
                      color: Colors.white,
                    ),
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
                  /*
            RaisedButton.icon(
              color: Color.fromRGBO(228, 92, 150, 1.0),
              label: Text(
                'Sign In With Google',
                style: TextStyle(
                  color: Colors.white,
                )
              ),
              icon: Icon(
                Icons.login,
                color: Colors.white,
              ),
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
            ),*/
                ],
              ),
            ));
  }
}
