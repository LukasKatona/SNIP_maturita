import 'package:flutter/material.dart';
import 'package:maturita/Services/auth.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  final AuthService _auth = AuthService();

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
          RaisedButton(
            child: Text("Sign out"),
            onPressed: () async{
              await _auth.signOut();
            },
          ),
        ],
      ),
    );
  }
}
