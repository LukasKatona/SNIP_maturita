import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maturita/Pages/HomePage/profile/profile.dart';
import 'package:maturita/Pages/LoginPage/LoginPage.dart';
import 'package:maturita/shared/design.dart';
import 'package:provider/provider.dart';
import 'package:maturita/Models/user.dart';

class LockedCal extends StatefulWidget {
  @override
  _LockedCalState createState() => _LockedCalState();
}

class _LockedCalState extends State<LockedCal> {
  @override
  Widget build(BuildContext context) {

    final userData = Provider.of<UserData>(context);

    return Visibility(
      visible: userData.isCalLocked == true,
      child: SizedBox.expand(
          child: Container(
            color: Color(0xFF100B1F),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.block,
                  color: MyColorTheme.PrimaryAccent,
                  size: 200,
                ),
                Text("The calculator is locked.\nTo continue, please contact your teacher.", style: TextStyle(color: MyColorTheme.Text), textAlign: TextAlign.center,),
              ],
            ),
          )
      ),
    );
  }
}
