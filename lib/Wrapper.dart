import 'package:flutter/material.dart';
import 'package:maturita/Models/user.dart';
import 'package:maturita/Pages/LoginPage/LoginPage.dart';
import 'package:provider/provider.dart';
import 'Pages/HomePage/HomePage.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<MyUser>(context);

    if (user == null) {
      return LoginPage();
    } else {
      return HomePage(key: myKey,);
    }
  }
}
