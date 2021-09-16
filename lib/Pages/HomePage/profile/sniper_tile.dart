import 'package:flutter/material.dart';
import 'package:maturita/Models/sniper.dart';
import 'package:maturita/shared/design.dart';

class SniperTile extends StatelessWidget {

  final Sniper sniper;
  SniperTile({ this.sniper });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        ),
        elevation: 0,
        color: MyColorTheme.Secondary,
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 20,
            backgroundColor: Colors.red,
          ),
          title: Text(sniper.name, style: TextStyle(color: Colors.white),),
          subtitle: Text(sniper.role, style: TextStyle(color: Colors.white),),
        ),
      ),
    );
  }
}
