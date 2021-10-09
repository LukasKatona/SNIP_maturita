import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maturita/Pages/HomePage/calculator/calculator.dart';
import 'package:maturita/Pages/HomePage/school/school_card.dart';
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

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SchoolCard(name: 'CLASSFUL', desc: 'In this type of subnetting, we divide the whole IP range into subnets with equal amount of IP addresses.', currentXp: userData.fulXp, fulLess: true,),
            SizedBox(height: 15,),
            SchoolCard(name: 'CLASSLESS', desc: 'In this type of subnetting, we take only necessary amount of IP addresses for each individual subnet.', currentXp: userData.lessXp, fulLess: false,),
          ],
        ),
      ),
    );
  }
}
