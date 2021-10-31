import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'questionsPage.dart';
import 'package:maturita/Pages/HomePage/school/school_card.dart';
import 'package:maturita/shared/design.dart';
import 'dart:math';
import 'package:provider/provider.dart';
import 'package:maturita/Models/user.dart';
import 'package:maturita/Services/auth.dart';
import 'package:maturita/Services/database.dart';

class PractiseProviderPage extends StatefulWidget {
  @override
  _PractiseProviderPageState createState() => _PractiseProviderPageState();
}

class _PractiseProviderPageState extends State<PractiseProviderPage>{
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<MyUser>(context);

    return StreamProvider<MyUser>.value(
      value: AuthService().user,
      child: StreamProvider<UserData>.value(
        value: DatabaseService(uid: user.uid).userData,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: MyColorTheme.Background,
            body: QuestionsPage(),
        ),
      ),
    );
  }
}
