import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:maturita/Models/user.dart';
import 'package:maturita/Pages/HomePage/school/classless/resultsPageLess.dart';
import 'package:maturita/Pages/HomePage/school/classful/resultsPageFul.dart';
import 'package:maturita/Pages/HomePage/school/correctAnswerPage.dart';
import 'package:maturita/Pages/HomePage/school/questionsPage.dart';
import 'package:maturita/shared/design.dart';
import 'package:maturita/Pages/HomePage/school/school_card.dart';
import 'package:maturita/Services/database.dart';
import 'package:provider/provider.dart';

class QuestionOneBytes extends StatefulWidget {
  @override
  _QuestionOneBytesState createState() => _QuestionOneBytesState();
}

class _QuestionOneBytesState extends State<QuestionOneBytes> {

  bool _wrongAnswer = false;
  bool _greenConfirm = false;
  bool _warningVisible = false;

  int question = new Random().nextInt(pow(2,23)+256);
  var formatter = NumberFormat('###,###,000');

  List<int> answers = List<int>(3);
  List<int> correctAnswers = List<int>(3);


  @override
  Widget build(BuildContext context) {

    final userData = Provider.of<UserData>(context);
    final user = Provider.of<MyUser>(context);

    void _afterConfirm() async {
      if (answers[0] != null && answers[1] != null && answers[2] != null){
        int correct = 0;

        correctAnswers[0] = (question/65536).floor();
        correctAnswers[1] = (question%65536/256).floor();
        correctAnswers[2] = (question%65536%256).floor();

        for (int i = 0; i < 3; i++){
          if (answers[i] == correctAnswers[i]){
            correct++;
          }
        }

        if (correct == 3){
          print("correct");
          setState(() {
            _greenConfirm = true;
          });
          questionController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.easeInCubic);
        }else{
          print("incorrect");
          setState(() {
            _wrongAnswer = true;
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
                    Text(formatter.format(question).toString(), style: TextStyle(color: myColorTheme.PrimaryAccent, fontSize: 24),),
                    SizedBox(height: 15,),
                    Text("Divide this number into three bytes.", style: TextStyle(color: myColorTheme.Text, fontSize: 16), textAlign: TextAlign.center,),
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
              child: Text("Answer:", style: TextStyle(color: myColorTheme.PrimaryAccent, fontSize: 16),),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: myColorTheme.Text),
                    cursorColor: myColorTheme.PrimaryAccent,
                    decoration: InputDecoration(
                      hintText: "1. byte",
                      hintStyle: TextStyle(color: myColorTheme.GreyText),
                      fillColor: myColorTheme.Secondary,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: myColorTheme.Secondary,
                          width: 2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color:myColorTheme.PrimaryAccent,
                          width: 2,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: myColorTheme.PrimaryAccent,
                          width: 2,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 2,
                        ),
                      ),
                    ),
                    onChanged: (val) {
                      setState(() {
                        if (val.isNotEmpty){
                          answers[0] = int.parse(val);
                          _warningVisible = false;
                        }else{
                          answers[0] = null;
                        }
                      });
                    },
                  ),
                ),
                SizedBox(width: 15, child: Text(".", style: TextStyle(color: myColorTheme.Text, fontSize: 16), textAlign: TextAlign.center,),),
                Expanded(
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: myColorTheme.Text),
                    cursorColor: myColorTheme.PrimaryAccent,
                    decoration: InputDecoration(
                      hintText: "2. byte",
                      hintStyle: TextStyle(color: myColorTheme.GreyText),
                      fillColor: myColorTheme.Secondary,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: myColorTheme.Secondary,
                          width: 2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color:myColorTheme.PrimaryAccent,
                          width: 2,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: myColorTheme.PrimaryAccent,
                          width: 2,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 2,
                        ),
                      ),
                    ),
                    onChanged: (val) {
                      setState(() {
                        if (val.isNotEmpty){
                          answers[1] = int.parse(val);
                          _warningVisible = false;
                        }else{
                          answers[1] = null;
                        }
                      });
                    },
                  ),
                ),
                SizedBox(width: 15, child: Text(".", style: TextStyle(color: myColorTheme.Text, fontSize: 16), textAlign: TextAlign.center,),),
                Expanded(
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: myColorTheme.Text),
                    cursorColor: myColorTheme.PrimaryAccent,
                    decoration: InputDecoration(
                      hintText: "3. byte",
                      hintStyle: TextStyle(color: myColorTheme.GreyText),
                      fillColor: myColorTheme.Secondary,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: myColorTheme.Secondary,
                          width: 2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color:myColorTheme.PrimaryAccent,
                          width: 2,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: myColorTheme.PrimaryAccent,
                          width: 2,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 2,
                        ),
                      ),
                    ),
                    onChanged: (val) {
                      setState(() {
                        if (val.isNotEmpty){
                          answers[2] = int.parse(val);
                          _warningVisible = false;
                        }else{
                          answers[2] = null;
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Visibility(
                    visible: _warningVisible,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Please fill up all fields!", style: TextStyle(color: Colors.red),),
                    ),
                  ),
                  Row(
                    children: [
                      MyBackButton(),
                      SizedBox(width: 15,),
                      Expanded(
                        child: ButtonTheme(
                          padding: EdgeInsets.zero,
                          child: FlatButton(
                            onPressed: _afterConfirm,
                            child: ConfirmButtonDecor(greenConfirm: _greenConfirm,),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15,),
                ],
              ),
            ),
          ],
        ),
      );
    }else{
      return CorrectAnswerPage(yourAnswer: "${answers[0]}.${answers[1]}.${answers[2]}", correctAnswer: "${correctAnswers[0]}.${correctAnswers[1]}.${correctAnswers[2]}",
        explanation: RichText(
          textAlign: TextAlign.justify,
          text: TextSpan(
            style: TextStyle(fontSize: 16, color: myColorTheme.Text),
            children: <TextSpan>[
              TextSpan(text: "1. byte = ${question} / 2^16 rounded down: "),
              TextSpan(text: "${(question/65536).floor()}\n", style: TextStyle(color: myColorTheme.PrimaryAccent)),
              TextSpan(text: "We continue only with the reminder of the division.\n"),
              TextSpan(text: "${question} - ${(question/65536).floor()} * 2^16 = ${question%65536}\n\n", style: TextStyle(color: myColorTheme.PrimaryAccent)),
              TextSpan(text: "2. byte = ${question%65536} / 2^8 rounded down: "),
              TextSpan(text: "${(question%65536/256).floor()}\n", style: TextStyle(color: myColorTheme.PrimaryAccent)),
              TextSpan(text: "The last byte is just the reminder of the previous division.\n\n"),
              TextSpan(text: "3. byte = ${question%65536} - ${(question%65536/256).floor()} * 2^8: "),
              TextSpan(text: "${(question%65536%256).floor()}\n\n", style: TextStyle(color: myColorTheme.PrimaryAccent)),
              TextSpan(text: "Easier way to do this is using modulo ("),
              TextSpan(text: "%", style: TextStyle(color: myColorTheme.PrimaryAccent)),
              TextSpan(text: ") function:\n"),
              TextSpan(text: "1. byte = ${question} / 2^16 rounded down: "),
              TextSpan(text: "${(question/65536).floor()}\n", style: TextStyle(color: myColorTheme.PrimaryAccent)),
              TextSpan(text: "2. byte = ${question} % 2^16 / 2^8 rounded down: "),
              TextSpan(text: "${(question%65536/256).floor()}\n", style: TextStyle(color: myColorTheme.PrimaryAccent)),
              TextSpan(text: "3. byte = ${question} % 2^16 % 2^8 rounded down: "),
              TextSpan(text: "${(question%65536%256).floor()}\n", style: TextStyle(color: myColorTheme.PrimaryAccent)),

            ],
          ),
        ),);
    }
  }
}
