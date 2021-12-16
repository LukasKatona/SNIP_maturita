import 'dart:io';

import 'package:flutter/material.dart';
import 'package:maturita/Models/user.dart';
import 'package:maturita/Pages/HomePage/school/classless/resultsPageLess.dart';
import 'correctAnswerPage.dart';
import 'questionsPage.dart';
import 'package:maturita/Pages/HomePage/school/classful/resultsPageFul.dart';
import 'package:maturita/shared/design.dart';
import 'package:maturita/Pages/HomePage/school/school_card.dart';
import 'package:maturita/Services/database.dart';
import 'package:provider/provider.dart';

class QuestionOne extends StatefulWidget {
  @override
  _QuestionOneState createState() => _QuestionOneState();
}

class _QuestionOneState extends State<QuestionOne> {

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
      _correctAnswer = "Class A";
    } else if (firstByte > 127 && firstByte < 192){
      _correctAnswer = "Class B";
    } else if (firstByte > 191){
      _correctAnswer = "Class C";
    }

    void _afterConfirm() async {
      if (_answer != "Please answer first!"){
        if (_answer == _correctAnswer){
          setState(() {
            _greenConfirm = true;
            fulOrLessQuestions ? correctAnsListFul[0] = true: correctAnsListLess[0] = true;
          });
          print("correct");

          if (fulOrLessQuestions){
            await DatabaseService(uid: user.uid).updateUserData(userData.name, userData.role, userData.isCalLocked, userData.fulXp + (1*xpMultiplier), userData.lessXp, userData.group, userData.darkOrLight);
          }else{
            await DatabaseService(uid: user.uid).updateUserData(userData.name, userData.role, userData.isCalLocked, userData.fulXp, userData.lessXp + (1*xpMultiplier), userData.group, userData.darkOrLight);
          }

          questionController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.easeInCubic);
        }else{
          print("incorrect");
          setState(() {
            _wrongAnswer = true;
            fulOrLessQuestions ? correctAnsListFul[0] = false: correctAnsListLess[0] = false;
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
                    Text(firstByte.toString() + ".0.0.0", style: TextStyle(color: myColorTheme.PrimaryAccent, fontSize: 24),),
                    SizedBox(height: 15,),
                    Text("In what class does this IP address belong?", style: TextStyle(color: myColorTheme.Text, fontSize: 16), textAlign: TextAlign.center,),
                  ],
                ),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
              ),
              elevation: 0,
              color: myColorTheme.Secondary,
            ),
            SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Answers:", style: TextStyle(color: myColorTheme.PrimaryAccent, fontSize: 16),),
            ),
            ButtonTheme(
              padding: EdgeInsets.zero,
              child: FlatButton(
                onPressed: () {
                  setState(() {
                    _answer = "Class A";
                    _warningVisible = false;
                  });
                },
                child: Ink(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: _answer == "Class A" ? [myColorTheme.PrimaryAccent, myColorTheme.SecondaryAccent] : [myColorTheme.Secondary, myColorTheme.Secondary],
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                      ),
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: Container(
                    constraints: BoxConstraints(minHeight: 59.0),
                    alignment: Alignment.center,
                    child: Text(
                      "Class A",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color:  _answer == "Class A" ? Colors.white : myColorTheme.Text,
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
                    _answer = "Class B";
                    _warningVisible = false;
                  });
                },
                child: Ink(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: _answer == "Class B" ? [myColorTheme.PrimaryAccent, myColorTheme.SecondaryAccent] : [myColorTheme.Secondary, myColorTheme.Secondary],
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                      ),
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: Container(
                    constraints: BoxConstraints(minHeight: 59.0),
                    alignment: Alignment.center,
                    child: Text(
                      "Class B",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color:  _answer == "Class B" ? Colors.white : myColorTheme.Text,
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
                    _answer = "Class C";
                    _warningVisible = false;
                  });
                },
                child: Ink(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: _answer == "Class C" ? [myColorTheme.PrimaryAccent, myColorTheme.SecondaryAccent] : [myColorTheme.Secondary, myColorTheme.Secondary],
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                      ),
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: Container(
                    constraints: BoxConstraints(minHeight: 59.0),
                    alignment: Alignment.center,
                    child: Text(
                      "Class C",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: _answer == "Class C" ? Colors.white : myColorTheme.Text,
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
          style: TextStyle(fontSize: 16, color: myColorTheme.Text),
          children: <TextSpan>[
            TextSpan(text: "IPv4 addresses are devided into 5 classes based on their first byte. "),
            TextSpan(text: "Class A", style: TextStyle(color: myColorTheme.PrimaryAccent)),
            TextSpan(text: " ranges from "),
            TextSpan(text: "0", style: TextStyle(color: myColorTheme.PrimaryAccent)),
            TextSpan(text: " to "),
            TextSpan(text: "126", style: TextStyle(color: myColorTheme.PrimaryAccent)),
            TextSpan(text: ", which in binary is from "),
            TextSpan(text: "00000000", style: TextStyle(color: myColorTheme.PrimaryAccent)),
            TextSpan(text: " to "),
            TextSpan(text: "01111110", style: TextStyle(color: myColorTheme.PrimaryAccent)),
            TextSpan(text: ". IP address that starts with "),
            TextSpan(text: "127", style: TextStyle(color: myColorTheme.PrimaryAccent)),
            TextSpan(text: " is called loopback and it's not used for routing.\n\n"),

            TextSpan(text: "Class B", style: TextStyle(color: myColorTheme.PrimaryAccent)),
            TextSpan(text: " ranges from "),
            TextSpan(text: "128", style: TextStyle(color: myColorTheme.PrimaryAccent)),
            TextSpan(text: " to "),
            TextSpan(text: "191", style: TextStyle(color: myColorTheme.PrimaryAccent)),
            TextSpan(text: ", which in binary is from "),
            TextSpan(text: "10000000", style: TextStyle(color: myColorTheme.PrimaryAccent)),
            TextSpan(text: " to "),
            TextSpan(text: "10111111", style: TextStyle(color: myColorTheme.PrimaryAccent)),
            TextSpan(text: ".\n\n"),

            TextSpan(text: "Class C", style: TextStyle(color: myColorTheme.PrimaryAccent)),
            TextSpan(text: " ranges from "),
            TextSpan(text: "192", style: TextStyle(color: myColorTheme.PrimaryAccent)),
            TextSpan(text: " to "),
            TextSpan(text: "223", style: TextStyle(color: myColorTheme.PrimaryAccent)),
            TextSpan(text: ", which in binary is from "),
            TextSpan(text: "11000000", style: TextStyle(color: myColorTheme.PrimaryAccent)),
            TextSpan(text: " to "),
            TextSpan(text: "11011111", style: TextStyle(color: myColorTheme.PrimaryAccent)),
            TextSpan(text: ". You can see that there is a pattern for that. first be begin with all bits set to "),
            TextSpan(text: "0", style: TextStyle(color: myColorTheme.PrimaryAccent)),
            TextSpan(text: " and than every new class has one more "),
            TextSpan(text: "1", style: TextStyle(color: myColorTheme.PrimaryAccent)),
            TextSpan(text: " at the start of the first byte.\n\n"),

            TextSpan(text: "Following this pattern, "),
            TextSpan(text: "CLass D", style: TextStyle(color: myColorTheme.PrimaryAccent)),
            TextSpan(text: " starts with "),
            TextSpan(text: "11100000 (224)", style: TextStyle(color: myColorTheme.PrimaryAccent)),
            TextSpan(text: " and ends with "),
            TextSpan(text: "11101111 (239)", style: TextStyle(color: myColorTheme.PrimaryAccent)),
            TextSpan(text: ". The last class is "),
            TextSpan(text: "CLass E", style: TextStyle(color: myColorTheme.PrimaryAccent)),
            TextSpan(text: ", which starts with "),
            TextSpan(text: "11110000 (240)", style: TextStyle(color: myColorTheme.PrimaryAccent)),
            TextSpan(text: " and ends with "),
            TextSpan(text: "11111111 (255)", style: TextStyle(color: myColorTheme.PrimaryAccent)),
            TextSpan(text: "."),
          ],
        ),
      ),);
    }
  }
}
