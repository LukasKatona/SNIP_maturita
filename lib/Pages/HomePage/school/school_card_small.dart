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

class SchoolCardSmall extends StatefulWidget {

  final String name;
  final String desc;
  final int questionID;
  SchoolCardSmall({ this.name, this.desc, this.questionID});

  @override
  _SchoolCardSmallState createState() => _SchoolCardSmallState();
}

class _SchoolCardSmallState extends State<SchoolCardSmall> {

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<MyUser>(context);
    final userData = Provider.of<UserData>(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(widget.name, style: TextStyle(color: myColorTheme.PrimaryAccent, fontSize: 24, fontWeight: FontWeight.bold),),
            Text(widget.desc, style: TextStyle(color: myColorTheme.Text), textAlign: TextAlign.center),
            SizedBox(height: 20,),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ButtonTheme(
                    padding: EdgeInsets.zero,
                    child: FlatButton(
                      onPressed: () async {
                        setState(() {
                          otherQuestions = widget.questionID;
                        });
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
