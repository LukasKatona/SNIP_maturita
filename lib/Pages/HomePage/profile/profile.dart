import 'dart:developer';

import 'package:flutter/cupertino.dart';
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

  Color getColor(Set<MaterialState> states) {
    return Color(0xFFFF6B00);
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
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                    SizedBox(height: 5,),
                    Text(
                      userData.role + " | " + userData.group,
                      style: TextStyle(
                        color: Colors.white,
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
                        style: TextStyle(color: Colors.white),
                        cursorColor: Color(0xFFFF6B00),
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
                            await DatabaseService(uid: snipers[i].uid).updateUserData(snipers[i].name, snipers[i].role, !lockAllCals, snipers[i].fulXp, snipers[i].lessXp, snipers[i].group);
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
    return RaisedButton(
      color: Color(0xFFFF6B00),
      child: Text("Sign out", style: TextStyle(color: Colors.white),),
      onPressed: () async{
        await _auth.signOut();
      },
    );
  }
}

