import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:maturita/Models/sniper.dart';
import 'package:maturita/Models/user.dart';
import 'package:maturita/Services/auth.dart';
import 'package:maturita/Services/database.dart';
import 'package:maturita/shared/design.dart';
import 'package:provider/provider.dart';
import 'sniper_tile.dart';
import 'package:maturita/shared/loading.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {

    var snipers = Provider.of<List<Sniper>>(context);
    //final students = snipers.where((element) => element.role == 'student').toList();
    //final teachers = snipers.where((element) => element.role == 'teacher').toList();

    final userData = Provider.of<UserData>(context);

    if (snipers != null && userData != null){

      if (userData.role == 'teacher'){
        snipers = snipers.where((element) => element.role == 'student').toList();
      } else if (userData.role == 'student'){
        snipers = snipers.where((element) => element.role == 'student').toList(); // neskor upravit
      }

      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 50,),
            CircleAvatar(
              radius: 75,
              backgroundColor: MyColorTheme.Primary,
              child: Icon(
                Icons.person,
                size: 100,
              ),
            ),
            SizedBox(height: 15,),
            Text(
              userData.name,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
            SizedBox(height: 5,),
            Text(
              userData.role,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 15,),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(0.0),
                itemCount: snipers.length,
                itemBuilder: (context, index) {
                  return SniperTile(sniper: snipers[index]);
                },
              ),
            ),
          ],
        ),
      );
    }else{
      return Loading();
    }
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

