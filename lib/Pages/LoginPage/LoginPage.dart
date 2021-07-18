import 'package:flutter/material.dart';
import 'package:maturita/Pages/LoginPage/sign_in.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: SignIn(),
      ),
    );
  }
}
