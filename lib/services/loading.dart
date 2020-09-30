import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text('Signing in...'),
        backgroundColor: Color.fromRGBO(228, 92, 150, 1.0),
        ),
      body: Center(
          child: SpinKitRing(
            color: Color.fromRGBO(228, 92, 150, 1.0),
            size: 60,
          ),
      ),
    );
  }
}
