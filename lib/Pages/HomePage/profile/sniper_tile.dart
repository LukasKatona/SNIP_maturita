import 'package:flutter/material.dart';
import 'package:maturita/Models/sniper.dart';
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
        color: MyColorTheme.Secondary,
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: Row(
          children: [
            Expanded(
              child: ListTile(
                leading: CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.red,
                ),
                title: Text(widget.sniper.name, style: TextStyle(color: Colors.white),),
                subtitle: Text(widget.sniper.role, style: TextStyle(color: Colors.white),),
              ),
            ),
            FlatButton(
              minWidth: 59,
              height: 59,
              onPressed: () async{
                if (userData.role != 'student'){
                  await DatabaseService(uid: widget.sniper.uid).updateUserData(widget.sniper.name, widget.sniper.role, !widget.sniper.anon);
                }
              },
              child: Icon(
                Icons.calculate,
                size: 40,
                color: widget.sniper.anon == false ? MyColorTheme.PrimaryAccent : MyColorTheme.GreyText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
