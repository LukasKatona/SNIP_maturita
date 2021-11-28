import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:maturita/Models/sniper.dart';
import 'package:maturita/Models/user.dart';
import 'package:maturita/Pages/HomePage/HomePage.dart';
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

  Color getColor(Set<MaterialState> states) {
    return MyColorTheme.PrimaryAccent;
  }

  String searchString = '';
  bool lockAllCals = false;

  @override
  Widget build(BuildContext context) {

    var snipers = Provider.of<List<Sniper>>(context);
    //final students = snipers.where((element) => element.role == 'student').toList();
    //final teachers = snipers.where((element) => element.role == 'teacher').toList();

    final userData = Provider.of<UserData>(context);

    if (snipers != null && userData != null){

      snipers = snipers.where((element) => element.role != 'deleted').toList();

      if (userData.role == 'admin'){
        snipers = snipers.where((element) => element.role != 'admin').toList();
      } else if (userData.role == 'teacher'){
        snipers = snipers.where((element) => element.role == 'student').toList();
      } else if (userData.role == 'student'){
        snipers = snipers.where((element) => element.role == 'student').toList(); // neskor upravit
      }

      if (searchString != ''){
        List<String> searchList = searchString.split(" ");
        for (int i = 0; i < searchList.length; i++) {
          snipers = snipers.where((element) =>
              element.name.toLowerCase().contains(searchList[i].toLowerCase()) ||
              element.role.toLowerCase().contains(searchList[i].toLowerCase()) ||
              element.group.toLowerCase().contains(searchList[i].toLowerCase())).toList();
        }
      }


      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 50,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: MyColorTheme.PrimaryAccent,
                  child: Visibility(
                      visible: userData.role == 'student',
                      replacement: Icon(Icons.work, color: MyColorTheme.Background,),
                      child: Icon(Icons.school, color: MyColorTheme.Background,)
                  ),
                ),
                SizedBox(width: 15,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userData.name,
                      style: TextStyle(
                        color: MyColorTheme.Text,
                        fontSize: 24,
                      ),
                    ),
                    SizedBox(height: 5,),
                    Text(
                      userData.role + " | " + userData.group,
                      style: TextStyle(
                        color: MyColorTheme.Text,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 50,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                        onChanged: (val) {setState(() => searchString = val);},
                        style: TextStyle(color: MyColorTheme.Text),
                        cursorColor: MyColorTheme.PrimaryAccent,
                        decoration: snipInputDecoration.copyWith(
                            suffixIcon: Icon(Icons.search, color: MyColorTheme.GreyText, size: 30,),
                        )
                    ),
                  ),
                  Visibility(
                    visible: userData.role != 'student',
                    child: IconButton(
                        onPressed: () async {
                          setState(() {
                            lockAllCals = !lockAllCals;
                          });
                          for (int i = 0; i < snipers.length; i++){
                            if (snipers[i].role == 'student'){
                              await DatabaseService(uid: snipers[i].uid).updateUserData(snipers[i].name, snipers[i].role, !lockAllCals, snipers[i].fulXp, snipers[i].lessXp, snipers[i].group);
                            }
                          }
                        },
                        icon: Icon(
                          Icons.calculate,
                          color: lockAllCals ? MyColorTheme.PrimaryAccent : MyColorTheme.GreyText,
                          size: 30,
                        ),
                    ),
                  )
                ],
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
    return ButtonTheme(
      padding: EdgeInsets.zero,
      child: FlatButton(
        onPressed: () async {
          await _auth.signOut();
        },
        child: Ink(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.red, Colors.redAccent],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
              ),
              borderRadius: BorderRadius.circular(10.0)
          ),
          child: Container(
            constraints: BoxConstraints(maxWidth: 350.0, minHeight: 59.0),
            alignment: Alignment.center,
            child: Text(
              "Sign Out",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

