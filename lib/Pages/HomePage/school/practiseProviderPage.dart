import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:maturita/Pages/HomePage/HomePage.dart';
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
  void initState() {
    super.initState();
    InternetConnectionChecker().onStatusChange.listen((event) {
      final internetStatus = event == InternetConnectionStatus.connected;
      setState(() {
        isOnline = internetStatus;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<MyUser>(context);

    return !isOnline ? Scaffold(
      backgroundColor: myColorTheme.Background,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.wifi_off_sharp,
              color: myColorTheme.PrimaryAccent,
              size: 150,
            ),
            Text("You are offline, to continue, please check your internet connection.", style: TextStyle(color: myColorTheme.Text), textAlign: TextAlign.center,),
          ],
        ),
      ),
    ) : StreamProvider<MyUser>.value(
      value: AuthService().user,
      child: StreamProvider<UserData>.value(
        value: DatabaseService(uid: user.uid).userData,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: myColorTheme.Background,
            body: QuestionsPage(),
        ),
      ),
    );
  }
}
