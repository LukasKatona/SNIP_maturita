import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maturita/Models/sniper.dart';
import 'package:maturita/Pages/HomePage/profile/deleteCard.dart';
import 'package:maturita/shared/design.dart';
import 'package:provider/provider.dart';
import 'package:maturita/Models/user.dart';
import 'package:maturita/Services/database.dart';

class SniperTile extends StatefulWidget {

  final Sniper sniper;
  SniperTile({ this.sniper });

  @override
  _SniperTileState createState() => _SniperTileState();
}

class _SniperTileState extends State<SniperTile> {
  @override
  Widget build(BuildContext context) {

    final userData = Provider.of<UserData>(context);

    return Padding(
      padding: EdgeInsets.only(bottom: 8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        ),
        elevation: 0,
        color: myColorTheme.Secondary,
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: Row(
          children: [
            Expanded(
              child: ListTile(
                leading: CircleAvatar(
                  radius: 20,
                  backgroundColor: myColorTheme.PrimaryAccent,
                  child: Visibility(
                    visible: widget.sniper.role == 'student',
                    replacement: Icon(Icons.work, color: myColorTheme.Secondary,),
                      child: Icon(Icons.school, color: myColorTheme.Secondary,)
                  ),
                ),
                title: Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(widget.sniper.name, style: TextStyle(color: myColorTheme.Text, fontWeight: FontWeight.bold),),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.sniper.role + " | " + widget.sniper.group, style: TextStyle(color: myColorTheme.Text),),
                      Text("XP: " + widget.sniper.fulXp.toString() + " | " + widget.sniper.lessXp.toString(), style: TextStyle(color: myColorTheme.Text),),
                    ],
                  ),
                ),
              ),
            ),
            Visibility(
              visible: widget.sniper.role == 'student',
              child: IconButton(
                onPressed: () async{
                  if (userData.role != 'student'){
                    await DatabaseService(uid: widget.sniper.uid).updateUserData(widget.sniper.name, widget.sniper.role, !widget.sniper.isCalLocked, widget.sniper.fulXp, widget.sniper.lessXp, widget.sniper.group, widget.sniper.darkOrLight);
                  }
                },
                icon: Icon(
                  Icons.calculate,
                  size: 30,
                  color: widget.sniper.isCalLocked == false ? myColorTheme.PrimaryAccent : myColorTheme.GreyText,
                ),
              ),
            ),
            Visibility(
              visible: userData.role == 'admin',
              child: IconButton(
                onPressed: () => showDialog(context: context, builder: (_) => DeleteDialog(uid: widget.sniper.uid, name: widget.sniper.name, role: widget.sniper.role, fulXp: widget.sniper.fulXp, lessXp: widget.sniper.lessXp,)),
                icon: Icon(Icons.delete, color: myColorTheme.PrimaryAccent, size: 30,),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
