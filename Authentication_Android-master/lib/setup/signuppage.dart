import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'veify.dart';

class navigatetosignup extends StatefulWidget {
  @override
  _navigatetosignupState createState() => _navigatetosignupState();
}

class _navigatetosignupState extends State<navigatetosignup> {
  String _username,_password;
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
        "Sign up",
      ),),
      body: Wrap(
        alignment: WrapAlignment.center,
        children: <Widget>[
          Form(
            key:formkey ,
            child: Column(
              children: <Widget>[
               SizedBox(
                 height: 20,
               ),
                Container(
                  padding: EdgeInsets.all(15.0),
                  child:
                     TextFormField(
                     obscureText: false,
                     decoration: InputDecoration(
                    hintText: "Enter Email",
                    border: OutlineInputBorder(),
                    labelText: "User Email"
                  ),
                  onSaved: (name){
                       _username = name;
                  },
                  validator: (name){
                    if(name.isEmpty)
                      {
                        return "Please Enter Email";
                      }
                  },
                ),
                ),
                Container(
                  padding: EdgeInsets.all(15.0),
                  child:
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: "Enter Password",
                        border: OutlineInputBorder(),
                        labelText: "Password"
                    ),
                    onSaved: (pass){
                      _password = pass;
                    },
                    validator: (pass){
                      if(pass.length<8)
                      {
                        return "Password must be more than 8 characters";
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  padding: EdgeInsets.all(15.0),
                  color: Colors.lightGreen,
                  child: Text(
                    "Sign up",style:
                    TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  splashColor: Colors.amber,
                  onPressed: ()
                  {
                    signup();
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
  Future<void> signup() async
  {
    final formState = formkey.currentState;
    if(formState.validate())
    {
      formState.save();
      try{
        final FirebaseUser user = (await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _username, password: _password)).user;
        user.sendEmailVerification();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => verify(_username)),
        );
      }catch(e){
        print(e.message);
      }
    }
  }
}
