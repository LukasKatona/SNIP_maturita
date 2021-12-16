import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:maturita/Models/user.dart';
import 'package:maturita/Pages/HomePage/calculator/calculator.dart';
import '../questionsPage.dart';
import '../correctAnswerPage.dart';
import 'package:maturita/Pages/HomePage/school/classful/resultsPageFul.dart';
import 'package:maturita/Services/database.dart';
import 'package:maturita/shared/design.dart';
import 'package:maturita/Pages/HomePage/school/school_card.dart';
import 'package:provider/provider.dart';

class QuestionThreeFul extends StatefulWidget {
  @override
  _QuestionThreeFulState createState() => _QuestionThreeFulState();
}

class _QuestionThreeFulState extends State<QuestionThreeFul> {

  bool _wrongAnswer = false;
  bool _greenConfirm = false;
  bool _warningVisible = false;

  List<int> answers = List<int>(2);
  List<int> correctAnswers = List<int>(2);


  @override
  Widget build(BuildContext context) {

    correctAnswers[0] = (subnets+1).bitLength;
    correctAnswers[1] = (hosts+1).bitLength;

    final userData = Provider.of<UserData>(context);
    final user = Provider.of<MyUser>(context);

    void _afterConfirm() async {
      if (answers[0] != null && answers[1] != null){

        bool wrong = false;
        int correct = 0;

        for (int i = 0; i < 2; i++){
          if (answers[i] == correctAnswers[i]){
            print('${i} is correct');
            correct++;
            correctAnsListFul[2+i] = true;
          }else{
            print('${i} is not correct');
            correctAnsListFul[2+i] = false;
            wrong = true;
          }
        }
        await DatabaseService(uid: user.uid).updateUserData(userData.name, userData.role, userData.isCalLocked, userData.fulXp + (1*xpMultiplier*correct), userData.lessXp, userData.group, userData.darkOrLight);
        if (!wrong){
          setState(() {
            _greenConfirm = true;
          });
          questionController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.easeInCubic);
        }else{
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
                    Text(firstByte.toString() + ".0.0.0", style: TextStyle(color: myColorTheme.PrimaryAccent, fontSize: 24),),
                    SizedBox(height: 15,),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(fontSize: 16, color: myColorTheme.Text),
                        children: <TextSpan>[
                          TextSpan(text: "We have ", ),
                          TextSpan(text: subnets.toString(), style: TextStyle(color: myColorTheme.PrimaryAccent)),
                          TextSpan(text: " subnets witch "),
                          TextSpan(text: hosts.toString(), style: TextStyle(color: myColorTheme.PrimaryAccent)),
                          TextSpan(text: " hosts in each. How many bits do we need?"),
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
            ),
            SizedBox(height: 15,),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Subnets:", style: TextStyle(color: myColorTheme.PrimaryAccent, fontSize: 16),),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        style: TextStyle(color: myColorTheme.Text),
                        cursorColor: myColorTheme.PrimaryAccent,
                        decoration: InputDecoration(
    hintText: "Bits for subnets",
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
                    ],
                  ),
                ),
                SizedBox(width: 15,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Hosts:", style: TextStyle(color: myColorTheme.PrimaryAccent, fontSize: 16),),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        style: TextStyle(color: myColorTheme.Text),
                        cursorColor: myColorTheme.PrimaryAccent,
                        decoration: InputDecoration(
                          hintText: "Bits for Hosts",
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
                    ],
                  ),
                ),
              ],
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
                      child: Text("Please fill up all fields!", style: TextStyle(color: Colors.red),),
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
      return CorrectAnswerPage(
        yourAnswer: "${answers[0]} bits for ${subnets} subnets and ${answers[1]} bits for ${hosts} hosts.",
        correctAnswer: "${correctAnswers[0]} bits for  ${subnets} subnets and ${correctAnswers[1]} bits for ${hosts} hosts.",
        explanation: RichText(
          textAlign: TextAlign.justify,
          text: TextSpan(
            style: TextStyle(fontSize: 16, color: myColorTheme.Text),
            children: <TextSpan>[
              TextSpan(text: "Solution one: add "),
              TextSpan(text: "1", style: TextStyle(color: myColorTheme.PrimaryAccent)),
              TextSpan(text: ". This is because the first IP address of the subnet is reserved for the subnet itself and the last IP address is used for broadcast. In binary we count from 0 so we only need to add 1. \n\nNext step: convert into binary, "),
              TextSpan(text: (subnets+1).toString(), style: TextStyle(color: myColorTheme.PrimaryAccent)),
              TextSpan(text: " in binary is "),
              TextSpan(text: DecToBin(subnets+1).toString(), style: TextStyle(color: myColorTheme.PrimaryAccent)),
              TextSpan(text: ", which are "),
              TextSpan(text: ((subnets+1).bitLength).toString(), style: TextStyle(color: myColorTheme.PrimaryAccent)),
              TextSpan(text: " bits.\n\nSolution two: This time add "),
              TextSpan(text: "2", style: TextStyle(color: myColorTheme.PrimaryAccent)),
              TextSpan(text: ", because now we wont use binary numbers so we count from 1 and we must count in 2 additional addresses. \n\nNext step: find the closest power of 2, closest to "),
              TextSpan(text: (subnets+2).toString(), style: TextStyle(color: myColorTheme.PrimaryAccent)),
              TextSpan(text: " is "),
              TextSpan(text: (pow(2, (subnets+1).bitLength)).toString(), style: TextStyle(color: myColorTheme.PrimaryAccent)),
              TextSpan(text: ". At this point you should now that this is 2 to the power of "),
              TextSpan(text: ((subnets+1).bitLength).toString(), style: TextStyle(color: myColorTheme.PrimaryAccent)),
              TextSpan(text: ", so you need "),
              TextSpan(text: ((subnets+1).bitLength).toString(), style: TextStyle(color: myColorTheme.PrimaryAccent)),
              TextSpan(text: " bits."),
            ],
          ),
        ),
      );
    }
  }
}