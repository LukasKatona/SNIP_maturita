import 'package:flutter/material.dart';
import 'package:maturita/Services/auth.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "You are signed in. Do you want to sign out?",
            style: TextStyle(color: Colors.white),
          ),
          SignOutButton(),
        ],
      ),
    );
  }
}

class SignOutButton extends StatefulWidget {
  @override
  _SignOutButtonState createState() => _SignOutButtonState();
}

class _SignOutButtonState extends State<SignOutButton> {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Color(0xFFFF6B00),
      child: Text("Sign out", style: TextStyle(color: Colors.white),),
      onPressed: () async{
        await _auth.signOut();
      },
    );
  }
}

