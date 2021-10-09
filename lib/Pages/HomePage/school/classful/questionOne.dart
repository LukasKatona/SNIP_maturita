import 'package:flutter/material.dart';
import 'package:maturita/shared/design.dart';
import 'package:maturita/Pages/HomePage/school/school_card.dart';

class QuestionOne extends StatefulWidget {
  @override
  _QuestionOneState createState() => _QuestionOneState();
}

class _QuestionOneState extends State<QuestionOne> {

  int _answer;
  int _correctAnswer;

  @override
  Widget build(BuildContext context) {

    if (firstByte < 128){
      _correctAnswer = 1;
    } else if (firstByte > 127 && firstByte < 192){
      _correctAnswer = 2;
    } else if (firstByte > 191){
      _correctAnswer = 3;
    }

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
                  Text("In what class does this IP address belong?", style: TextStyle(color: MyColorTheme.Text, fontSize: 16), textAlign: TextAlign.center,),
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
                  _answer = 1;
                });
              },
              child: Ink(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: _answer == 1 ? [Color(0xFFFF6B00), Color(0xFFFF8A00)] : [MyColorTheme.Secondary, MyColorTheme.Secondary],
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
                  _answer = 2;
                });
              },
              child: Ink(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: _answer == 2 ? [Color(0xFFFF6B00), Color(0xFFFF8A00)] : [MyColorTheme.Secondary, MyColorTheme.Secondary],
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
                  _answer = 3;
                });
              },
              child: Ink(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: _answer == 3 ? [Color(0xFFFF6B00), Color(0xFFFF8A00)] : [MyColorTheme.Secondary, MyColorTheme.Secondary],
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
                if (_answer == _correctAnswer){
                  print("correct");
                }else{
                  print("incorrect");
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
                  constraints: BoxConstraints(minHeight: 59.0),
                  alignment: Alignment.center,
                  child: Text(
                    "Confirm",
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
    );
  }
}
