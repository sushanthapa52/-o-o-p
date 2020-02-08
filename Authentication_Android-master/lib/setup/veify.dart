import 'package:flutter/material.dart';
import 'login.dart';
class verify extends StatefulWidget {
  String _username;
  verify(this._username);
  @override
  _verifyState createState() => _verifyState(this._username);
}

class _verifyState extends State<verify> {
  String _username;
  _verifyState(this._username);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
         icon: Icon(
           Icons.arrow_back,
         ),
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Login()),
            );
          },
        ),
      ),
      body:Center(
       child: Text(
         "An email has been sent to ${_username}",
       ),
      )
    );
  }
}
