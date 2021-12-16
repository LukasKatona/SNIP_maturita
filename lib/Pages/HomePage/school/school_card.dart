import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:maturita/Pages/HomePage/school/classless/questionThreeLess.dart';
import 'package:maturita/Pages/HomePage/school/questionsPage.dart';
import 'practiseProviderPage.dart';
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
        widget.currentXp == 0 ? rank = rankList[0].rank : rank = rankList[i].rank;
      }
      if (widget.currentXp == 0){
        rank = rankList[0].rank;
      }
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(widget.name, style: TextStyle(color: myColorTheme.PrimaryAccent, fontSize: 24, fontWeight: FontWeight.bold),),
            //Text(widget.desc, style: TextStyle(color: MyColorTheme.Text), textAlign: TextAlign.center),
            SizedBox(height: 15,),
            Text('Rank: ' + rank, style: TextStyle(color: myColorTheme.PrimaryAccent, fontSize: 16, fontWeight: FontWeight.bold),),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.currentXp.toString() + ' Xp', style: TextStyle(color: myColorTheme.PrimaryAccent)),
                Text(maxXp.toString() + ' Xp', style: TextStyle(color: myColorTheme.Text)),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Expanded(flex: widget.currentXp-minXp, child: Container(height: 5,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [myColorTheme.PrimaryAccent, myColorTheme.SecondaryAccent],
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                      ),
                  ),)),
                Expanded(flex: maxXp-widget.currentXp, child: Container(height: 5, color: myColorTheme.GreyText,)),
              ],
            ),
            SizedBox(height: 20,),
            ButtonTheme(
              padding: EdgeInsets.zero,
              child: FlatButton(
                onPressed: () async {
                  setState(() {
                    otherQuestions = 0;
                  });
                  if(widget.fulLess){
                    setState(() {
                      fulOrLessQuestions = true;
                      firstByte = GenerateQuestionVars();
                      xpMultiplier = getXpMultiplier();
                      if (firstByte < 128){
                        subnets = new Random().nextInt(512)+1;
                        hosts = new Random().nextInt(32768)+1;
                      } else if (firstByte > 127 && firstByte < 192){
                        subnets = new Random().nextInt(64)+1;
                        hosts = new Random().nextInt(1024)+1;
                      } else if (firstByte > 191){
                        subnets = new Random().nextInt(8)+1;
                        hosts = new Random().nextInt(32)+1;
                      }
                    });
                  }else{
                    setState(() {
                      fulOrLessQuestions = false;
                      firstByte = GenerateQuestionVars();
                      xpMultiplier = getXpMultiplier();
                      if (firstByte < 128){
                        hostListForQuestionThree = [Random().nextInt(65536) + 1, Random().nextInt(65536) + 1, Random().nextInt(65536) + 1, Random().nextInt(65536) + 1];
                      } else if (firstByte > 127 && firstByte < 192){
                        hostListForQuestionThree = [Random().nextInt(16382) + 1, Random().nextInt(16382) + 1, Random().nextInt(16382) + 1, Random().nextInt(16382) + 1];
                      } else if (firstByte > 191){
                        hostListForQuestionThree = [Random().nextInt(62) + 1, Random().nextInt(62) + 1, Random().nextInt(62) + 1, Random().nextInt(62) + 1];
                      }
                    });
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PractiseProviderPage()),
                  );
                },
                child: Ink(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [myColorTheme.PrimaryAccent, myColorTheme.SecondaryAccent],
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                      ),
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: Container(
                    constraints: BoxConstraints(minHeight: 59.0),
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
      color: myColorTheme.Secondary,
    );
  }
}
