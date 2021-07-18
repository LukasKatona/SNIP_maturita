import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maturita/Pages/HomePage/profile/profile.dart';
import 'package:maturita/Pages/LoginPage/sign_in.dart';


class LockedCal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: lockedCal == true,
      child: SizedBox.expand(
          child: Container(
            color: Color(0xFF100B1F),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.block,
                  color: Color(0xFFFF6B00),
                  size: 200,
                ),
                Text("This content is locked.\nTo continue, please sign in with a verified account.", style: TextStyle(color: Colors.white), textAlign: TextAlign.center,),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: SignOutButton(),
                ),
              ],
            ),
          )
      ),
    );
  }
}
