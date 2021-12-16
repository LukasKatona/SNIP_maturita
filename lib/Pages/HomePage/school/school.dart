import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maturita/Pages/HomePage/calculator/calculator.dart';
import 'package:maturita/Pages/HomePage/school/school_card.dart';
import 'package:maturita/Pages/HomePage/school/school_card_small.dart';
import 'package:provider/provider.dart';
import 'package:maturita/Models/user.dart';

class SchoolPage extends StatefulWidget {
  @override
  _SchoolPageState createState() => _SchoolPageState();
}

class _SchoolPageState extends State<SchoolPage> {
  @override
  Widget build(BuildContext context) {

    final userData = Provider.of<UserData>(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SchoolCard(name: 'CLASSFUL', desc: 'In this type of subnetting, we divide the whole IP range into subnets with equal amount of IP addresses.', currentXp: userData.fulXp, fulLess: true,),
            SizedBox(height: 5,),
            SchoolCard(name: 'CLASSLESS', desc: 'In this type of subnetting, we take only necessary amount of IP addresses for each individual subnet.', currentXp: userData.lessXp, fulLess: false,),
            SizedBox(height: 5,),
            IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(child: SchoolCardSmall(name: 'BYTES', desc: 'Divide numbers bigger than 255 into bytes.', questionID: 1,)),
                  SizedBox(width: 5,),
                  Expanded(child: SchoolCardSmall(name: 'BINARY', desc: 'Convert numbers between decimal and binary.', questionID: 2,)),
                ],
              ),
            ),
            SizedBox(height: 15,),
          ],
        ),
      ),
    );
  }
}
