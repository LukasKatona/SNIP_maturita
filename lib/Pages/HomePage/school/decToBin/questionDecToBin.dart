import 'dart:io';
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:maturita/Models/user.dart';
import 'package:maturita/Pages/HomePage/calculator/calculator.dart';
import 'package:maturita/Pages/HomePage/school/classless/resultsPageLess.dart';
import 'package:maturita/Pages/HomePage/school/classful/resultsPageFul.dart';
import 'package:maturita/Pages/HomePage/school/correctAnswerPage.dart';
import 'package:maturita/Pages/HomePage/school/questionsPage.dart';
import 'package:maturita/shared/design.dart';
import 'package:maturita/Pages/HomePage/school/school_card.dart';
import 'package:maturita/Services/database.dart';
import 'package:provider/provider.dart';

class QuestionDecToBin extends StatefulWidget {
  @override
  _QuestionDecToBinState createState() => _QuestionDecToBinState();
}

class _QuestionDecToBinState extends State<QuestionDecToBin> {

  bool _wrongAnswer = false;
  bool _greenConfirm = false;
  bool _warningVisible = false;

  int question = new Random().nextInt(pow(2,16)+1);
  var formatter = NumberFormat('###,###,000');

  String answer = '';


  @override
  Widget build(BuildContext context) {

    final userData = Provider.of<UserData>(context);
    final user = Provider.of<MyUser>(context);

    void _afterConfirm() async {
      if (answer != ''){
        if (answer == DecToBin(question).toString()){
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
                    Text("Convert this number into binary value.", style: TextStyle(color: myColorTheme.Text, fontSize: 16), textAlign: TextAlign.center,),
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
            TextFormField(
              keyboardType: TextInputType.number,
              style: TextStyle(color: myColorTheme.Text),
              cursorColor: myColorTheme.PrimaryAccent,
              decoration: InputDecoration(
                hintText: "Binary Value",
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
                    answer = val;
                    _warningVisible = false;
                  }else{
                    answer = '';
                  }
                });
              },
            ),
            SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Tip:", style: TextStyle(color: myColorTheme.PrimaryAccent, fontSize: 16),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Subtract the highest power of 2 possible. Then continue down until you come to 2^0, which is 1. Each time you can make the subtraction, write down 1. If you can not, write down 0.\n\nA calculator might help.", style: TextStyle(color: myColorTheme.Text, fontSize: 16), textAlign: TextAlign.justify,),
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

      String powOfTwo = '= ';
      int temp = question;

      for (int i = 1; i < question.bitLength+1; i++){
        temp = temp - pow(2, question.bitLength-i);
        print(temp);
        if (temp >= 0){
          powOfTwo = powOfTwo + pow(2, question.bitLength-i).toString() + "*1";
        }else{
          powOfTwo = powOfTwo + pow(2, question.bitLength-i).toString() + "*0";
          temp = temp + pow(2, question.bitLength-i);
        }
        if (i != question.bitLength){
          powOfTwo = powOfTwo + " + ";
        }
      }

      return CorrectAnswerPage(yourAnswer: question.toString() + ' = ' + answer, correctAnswer: question.toString() + ' = ' + DecToBin(question).toString(),
        explanation: RichText(
          textAlign: TextAlign.justify,
          text: TextSpan(
            style: TextStyle(fontSize: 16, color: myColorTheme.Text),
            children: <TextSpan>[
              TextSpan(text: "Divide the number into powers of 2 and then convert these numbers into corresponding bits:\n\n"),
              TextSpan(text: "${question}", style: TextStyle(color: myColorTheme.PrimaryAccent)),
              TextSpan(text: " ${powOfTwo}\n\n"),
              TextSpan(text: "${question}", style: TextStyle(color: myColorTheme.PrimaryAccent)),
              TextSpan(text: " = ${DecToBin(question)}"),
            ],
          ),
        ),);
    }
  }
}
