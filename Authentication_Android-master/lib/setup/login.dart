import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_authentication/Pages/home.dart';
import 'signuppage.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Login"
        ),
        centerTitle: true,
      ),
      body: form(),
    );
  }
}
class form extends StatefulWidget {
  @override
  _formState createState() => _formState();
}

class _formState extends State<form> {
  String _email, _password;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: Form(
      key:_formKey,
     child: Column(
      children: <Widget>[
        SizedBox(
          height: 25,
        ),
        Container(
          padding: EdgeInsets.all(15.0),
          child: TextFormField(
            obscureText: false,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "User email",
            ),
           onSaved: (name){
              _email=name;
            },
           validator: (name){
              if(name.isEmpty)
                {
                  return "Enter your email";
                }
           },
          ),
        ),
        SizedBox(
          height: 25,
        ),
        Container(
          padding: EdgeInsets.all(15.0),
          child: TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              fillColor: Colors.white70,
              border: OutlineInputBorder(),
              labelText: "Password",
            ),
            onSaved: (pass){
              _password = pass;
            },
            validator: (pass){
              if(pass.length<8)
                {
                  return "Password must be of atleast 8 characters";
                }
            },
          ),
        ),
        SizedBox(
        height: 25,
        ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(50.0),
                ),
                color: Colors.lightGreen,
                padding: EdgeInsets.all(20.0),
                child: Text(
                  "Sign in",
                  style:TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: (){
                  signIn();
                },
                splashColor: Colors.amber[200],
                elevation: 2,
              ),
              SizedBox(
              width: 20,
              ),
              RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius:  new BorderRadius.circular(50.0),
                ),
                color: Colors.lightGreen,
                padding: EdgeInsets.all(20.0),
                child: Text(
                  "Sign up",style:
                  TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => navigatetosignup()),
                  );
                },
                splashColor: Colors.amber[200],
                elevation: 2,
              )
            ],
          )
      ],
    )
    )
    );
  }
 Future<void> signIn() async
 {
  final formState = _formKey.currentState;
  if(formState.validate())
    {
      formState.save();
      try{
        final FirebaseUser user = (await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password)).user;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
      }catch(e){
        print(e.message);
      }
    }
 }
}
