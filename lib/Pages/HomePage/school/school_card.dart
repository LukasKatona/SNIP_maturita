import 'dart:ui';
import 'package:flutter/material.dart';
import 'classful/classfulPractise.dart';
import 'package:maturita/Pages/HomePage/school/classlessPractise.dart';
import 'package:maturita/Services/database.dart';
import 'package:maturita/Services/height_meter.dart';
import 'package:maturita/shared/design.dart';
import 'package:provider/provider.dart';
import 'package:maturita/Models/user.dart';
import 'package:maturita/Models/rank.dart';
import 'dart:math';

class SchoolCard extends StatefulWidget {

  final String name;
  final String desc;
  final int currentXp;
  final bool fulLess;
  SchoolCard({ this.name, this.desc, this.currentXp, this.fulLess });

  @override
  _SchoolCardState createState() => _SchoolCardState();
}

int firstByte;
int subnets;
int hosts;
int xpMultiplier;

class _SchoolCardState extends State<SchoolCard> {

  int minXp = 0;
  int maxXp = 32;
  double minWidthOfXp = 100;
  String rank = 'beginner';

  int GenerateQuestionVars(){
    for (int i = 0; i < 9; i++) {
      if (widget.currentXp > rankList[i].minXp) {
        if (i < 3) {
          firstByte = new Random().nextInt(32) + 192;
        } else if (i < 6) {
          firstByte = new Random().nextInt(96) + 128;
        } else if (i <= 9) {
          do{
            firstByte = new Random().nextInt(223)+1;
          }while(firstByte == 127);
        }
      }
    }
    return firstByte;
  }

  int getXpMultiplier(){
    for (int i = 0; i < 9; i++) {
      if (widget.currentXp > rankList[i].minXp) {
        xpMultiplier = (i+1);
      }
    }
    return xpMultiplier;
  }

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<MyUser>(context);
    final userData = Provider.of<UserData>(context);

    for (int i = 0; i < 9; i++){
      if (widget.currentXp > rankList[i].minXp){
        minXp = rankList[i].minXp;
        minXp == 0 ? maxXp = 32 : maxXp = (rankList[i].minXp)*2;
        rank = rankList[i].rank;
      }
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(widget.name, style: TextStyle(color: MyColorTheme.PrimaryAccent, fontSize: 24, fontWeight: FontWeight.bold),),
            Text(widget.desc, style: TextStyle(color: MyColorTheme.Text), textAlign: TextAlign.center),
            SizedBox(height: 15,),
            Text('Rank: ' + rank, style: TextStyle(color: MyColorTheme.PrimaryAccent, fontSize: 16, fontWeight: FontWeight.bold),),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.currentXp.toString() + ' Xp', style: TextStyle(color: MyColorTheme.PrimaryAccent)),
                Text(maxXp.toString() + ' Xp', style: TextStyle(color: MyColorTheme.Text)),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Expanded(flex: widget.currentXp-minXp, child: Container(height: 5,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [Color(0xFFFF6B00), Color(0xFFFF8A00)],
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                      ),
                  ),)),
                Expanded(flex: maxXp-widget.currentXp, child: Container(height: 5, color: MyColorTheme.GreyText,)),
              ],
            ),
            SizedBox(height: 20,),
            ButtonTheme(
              padding: EdgeInsets.zero,
              child: FlatButton(
                onPressed: () async {
                  if(widget.fulLess){
                    setState(() {
                      firstByte = GenerateQuestionVars();
                      xpMultiplier = getXpMultiplier();
                      if (firstByte < 128){
                        subnets = new Random().nextInt(1024)+1;
                        hosts = new Random().nextInt(32768)+1;
                      } else if (firstByte > 127 && firstByte < 192){
                        subnets = new Random().nextInt(128)+1;
                        hosts = new Random().nextInt(1024)+1;
                      } else if (firstByte > 191){
                        subnets = new Random().nextInt(16)+1;
                        hosts = new Random().nextInt(32)+1;
                      }
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => classfulPractisePage()),
                    );
                  }else{
                    await DatabaseService(uid: user.uid).updateUserData(userData.name, userData.role, userData.anon, 7000, 10);
                    /*Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => classlessPractisePage()),
                    );*/
                  }
                },
                child: Ink(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [Color(0xFFFF6B00), Color(0xFFFF8A00)],
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                      ),
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: Container(
                    constraints: BoxConstraints(maxWidth: 350.0, minHeight: 59.0),
                    alignment: Alignment.center,
                    child: Text(
                      "Practise",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
      ),
      elevation: 0,
      color: MyColorTheme.Secondary,
    );
  }
}
