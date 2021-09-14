import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:maturita/Models/sniper.dart';
import 'package:maturita/Models/user.dart';
import 'package:maturita/Services/auth.dart';
import 'package:maturita/Services/database.dart';
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

    final snipers = Provider.of<List<Sniper>>(context);

    if (snipers != null){
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 100,),
            Text(
              "You are signed in. Do you want to sign out?",
              style: TextStyle(color: Colors.white),
            ),
            SignOutButton(),

            Expanded(
              child: ListView.builder(
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

