import 'dart:io';

import 'package:flutter/material.dart';
import 'package:maturita/Models/user.dart';
import 'package:maturita/Pages/HomePage/school/classless/resultsPageLess.dart';
import 'questionsPage.dart';
import 'correctAnswerPage.dart';
import 'package:maturita/Pages/HomePage/school/classful/resultsPageFul.dart';
import 'package:maturita/Services/database.dart';
import 'package:maturita/shared/design.dart';
import 'package:maturita/Pages/HomePage/school/school_card.dart';
import 'package:provider/provider.dart';

class QuestionTwo extends StatefulWidget {
  @override
  _QuestionTwoState createState() => _QuestionTwoState();
}

class _QuestionTwoState extends State<QuestionTwo> {

  String _answer = "Please answer first!";
  String _correctAnswer;
  bool _wrongAnswer = false;
  bool _greenConfirm = false;
  bool _warningVisible = false;

  @override
  Widget build(BuildContext context) {

    final userData = Provider.of<UserData>(context);
    final user = Provider.of<MyUser>(context);

    if (firstByte < 128){
      _correctAnswer = "/8 - 255.0.0.0";
    } else if (firstByte > 127 && firstByte < 192){
      _correctAnswer = "/16 - 255.255.0.0";
    } else if (firstByte > 191){
      _correctAnswer = "/24 - 255.255.255.0";
    }

    void _afterConfirm() async {
      if (_answer != "Please answer first!"){
        if (_answer == _correctAnswer){
          setState(() {
            _greenConfirm = true;
            fulOrLessQuestions ? correctAnsListFul[1] = true: correctAnsListLess[1] = true;
          });
          print("correct");

          if (fulOrLessQuestions){
            await DatabaseService(uid: user.uid).updateUserData(userData.name, userData.role, userData.anon, userData.fulXp + (1*xpMultiplier), userData.lessXp);
          }else{
            await DatabaseService(uid: user.uid).updateUserData(userData.name, userData.role, userData.anon, userData.fulXp, userData.lessXp + (1*xpMultiplier));
          }

          questionController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.easeInCubic);
        }else{
          print("incorrect");
          setState(() {
            _wrongAnswer = true;
            fulOrLessQuestions ? correctAnsListFul[1] = true: correctAnsListLess[1] = true;
          });
        }
      }else{
        setState(() {
          _warningVisible = true;
        });
      }
    }

    if (!_wrongAnswer){
      return Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text(firstByte.toString() + ".0.0.0", style: TextStyle(color: MyColorTheme.PrimaryAccent, fontSize: 24),),
                    SizedBox(height: 15,),
                    Text("What is the default subnet mask for this IP address?", style: TextStyle(color: MyColorTheme.Text, fontSize: 16), textAlign: TextAlign.center,),
                  ],
                ),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
              ),
              elevation: 0,
              color: MyColorTheme.Secondary,
            ),
            SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Answers:", style: TextStyle(color: MyColorTheme.PrimaryAccent, fontSize: 16),),
            ),
            ButtonTheme(
              padding: EdgeInsets.zero,
              child: FlatButton(
                onPressed: () {
                  setState(() {
                    _answer = "/8 - 255.0.0.0";
                    _warningVisible = false;
                  });
                },
                child: Ink(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: _answer == "/8 - 255.0.0.0" ? [Color(0xFFFF6B00), Color(0xFFFF8A00)] : [MyColorTheme.Secondary, MyColorTheme.Secondary],
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                      ),
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: Container(
                    constraints: BoxConstraints(minHeight: 59.0),
                    alignment: Alignment.center,
                    child: Text(
                      "/8 - 255.0.0.0",
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
            SizedBox(height: 15,),
            ButtonTheme(
              padding: EdgeInsets.zero,
              child: FlatButton(
                onPressed: () {
                  setState(() {
                    _answer = "/16 - 255.255.0.0";
                    _warningVisible = false;
                  });
                },
                child: Ink(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: _answer == "/16 - 255.255.0.0" ? [Color(0xFFFF6B00), Color(0xFFFF8A00)] : [MyColorTheme.Secondary, MyColorTheme.Secondary],
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                      ),
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: Container(
                    constraints: BoxConstraints(minHeight: 59.0),
                    alignment: Alignment.center,
                    child: Text(
                      "/16 - 255.255.0.0",
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
            SizedBox(height: 15,),
            ButtonTheme(
              padding: EdgeInsets.zero,
              child: FlatButton(
                onPressed: () {
                  setState(() {
                    _answer = "/24 - 255.255.255.0";
                    _warningVisible = false;
                  });
                },
                child: Ink(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: _answer == "/24 - 255.255.255.0" ? [Color(0xFFFF6B00), Color(0xFFFF8A00)] : [MyColorTheme.Secondary, MyColorTheme.Secondary],
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                      ),
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: Container(
                    constraints: BoxConstraints(minHeight: 59.0),
                    alignment: Alignment.center,
                    child: Text(
                      "/24 - 255.255.255.0",
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
            SizedBox(height: 15,),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Visibility(
                    visible: _warningVisible,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(_answer, style: TextStyle(color: Colors.red),),
                    ),
                  ),
                  ButtonTheme(
                    padding: EdgeInsets.zero,
                    child: FlatButton(
                      onPressed: _afterConfirm,
                      child: ConfirmButtonDecor(greenConfirm: _greenConfirm,),
                    ),
                  ),
                  SizedBox(height: 15,),
                ],
              ),
            ),
          ],
        ),
      );
    }else{
      return CorrectAnswerPage(yourAnswer: _answer, correctAnswer: _correctAnswer,
          explanation: RichText(
            textAlign: TextAlign.justify,
            text: TextSpan(
              style: TextStyle(fontSize: 16),
              children: <TextSpan>[
                TextSpan(text: "Slash format of the subnet mask represents the number of bits used for net part of the address. Default subnet mask for "),
                TextSpan(text: "Class A", style: TextStyle(color: MyColorTheme.PrimaryAccent)),
                TextSpan(text: " is "),
                TextSpan(text: "/8", style: TextStyle(color: MyColorTheme.PrimaryAccent)),
                TextSpan(text: ", which is one byte, therefore "),
                TextSpan(text: "255.0.0.0", style: TextStyle(color: MyColorTheme.PrimaryAccent)),
                TextSpan(text: ". \n\nDefault subnet mask for "),
                TextSpan(text: "Class B", style: TextStyle(color: MyColorTheme.PrimaryAccent)),
                TextSpan(text: " is "),
                TextSpan(text: "/16", style: TextStyle(color: MyColorTheme.PrimaryAccent)),
                TextSpan(text: ", which are two bytes, therefore "),
                TextSpan(text: "255.255.0.0", style: TextStyle(color: MyColorTheme.PrimaryAccent)),
                TextSpan(text: ". You can see that the IP range is getting smaller and number of different networks is getting bigger. \n\nDefault subnet mask for "),
                TextSpan(text: "Class C", style: TextStyle(color: MyColorTheme.PrimaryAccent)),
                TextSpan(text: " is "),
                TextSpan(text: "/24", style: TextStyle(color: MyColorTheme.PrimaryAccent)),
                TextSpan(text: ", which are three bytes, therefore "),
                TextSpan(text: "255.255.255.0", style: TextStyle(color: MyColorTheme.PrimaryAccent)),
                TextSpan(text: ". This is also default subnet mask for "),
                TextSpan(text: "Class D", style: TextStyle(color: MyColorTheme.PrimaryAccent)),
                TextSpan(text: ". and the last "),
                TextSpan(text: "Class E", style: TextStyle(color: MyColorTheme.PrimaryAccent)),
                TextSpan(text: "."),

              ],
            ),
          ),);
    }
  }
}