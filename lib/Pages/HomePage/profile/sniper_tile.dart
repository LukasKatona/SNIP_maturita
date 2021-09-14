import 'package:flutter/material.dart';
import 'package:maturita/Models/sniper.dart';

class SniperTile extends StatelessWidget {

  final Sniper sniper;
  SniperTile({ this.sniper });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 20,
            backgroundColor: Colors.red,
          ),
          title: Text(sniper.name),
          subtitle: Text(sniper.role + " " + sniper.anon.toString()),
        ),
      ),
    );
  }
}
