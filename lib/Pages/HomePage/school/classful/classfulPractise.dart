import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'classFulQuestionsPage.dart';
import 'package:maturita/Pages/HomePage/school/school_card.dart';
import 'package:maturita/shared/design.dart';
import 'dart:math';
import 'package:provider/provider.dart';
import 'package:maturita/Models/user.dart';
import 'package:maturita/Services/auth.dart';
import 'package:maturita/Services/database.dart';

class classfulPractisePage extends StatefulWidget {
  @override
  _classfulPractisePageState createState() => _classfulPractisePageState();
}

class _classfulPractisePageState extends State<classfulPractisePage>{
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<MyUser>(context);

    return StreamProvider<MyUser>.value(
      value: AuthService().user,
      child: StreamProvider<UserData>.value(
        value: DatabaseService(uid: user.uid).userData,
        child: Scaffold(
          backgroundColor: MyColorTheme.Background,
            body: ClassFulQuestionsPage(),
        ),
      ),
    );
  }
}
