import 'package:flutter/material.dart';
import 'package:maturita/Services/auth.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF100B1F),

      appBar: AppBar(
        backgroundColor: Colors.orange,
        elevation: 0,
        title: Text("Sign In"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          child: RaisedButton(
            child: Text("Sign in anon"),
            onPressed: () async{
              dynamic result = await _auth.signInAnon();
              if (result == null){
                print("error signing IN");
              }else{
                print("signed in");
                print(result.uid);
              }
            },
          ),
        ),
      ),
    );
  }
}

//HomePage(key : myKey,)
