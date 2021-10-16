import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:maturita/Models/user.dart';
import 'package:maturita/Pages/HomePage/calculator/calculator.dart';
import 'package:maturita/Pages/HomePage/school/classful/classFulQuestionsPage.dart';
import 'package:maturita/Pages/HomePage/school/classful/correctAnswer.dart';
import 'package:maturita/Services/database.dart';
import 'package:maturita/shared/design.dart';
import 'package:maturita/Pages/HomePage/school/school_card.dart';
import 'package:provider/provider.dart';

class QuestionThree extends StatefulWidget {
  @override
  _QuestionThreeState createState() => _QuestionThreeState();
}

class _QuestionThreeState extends State<QuestionThree> {

  int _answerSN;
  int _answerHosts;
  int _correctSN = (subnets+1).bitLength;
  int _correctHosts = (hosts+1).bitLength;
  bool _wrongAnswer = false;
  bool _greenConfirm = false;
  bool _warningVisible = false;

  @override
  Widget build(BuildContext context) {

    final userData = Provider.of<UserData>(context);
    final user = Provider.of<MyUser>(context);

    void _afterConfirm() async {
      if (_answerSN != null && _answerHosts != null){
        if (_answerSN == _correctSN && _answerHosts == _correctHosts){
          setState(() {
            _greenConfirm = true;
          });
          print("correct");
          await DatabaseService(uid: user.uid).updateUserData(userData.name, userData.role, userData.anon, userData.fulXp + 2, userData.lessXp);
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
                    Text(firstByte.toString() + ".0.0.0", style: TextStyle(color: MyColorTheme.PrimaryAccent, fontSize: 24),),
                    SizedBox(height: 15,),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(fontSize: 16),
                        children: <TextSpan>[
                          TextSpan(text: "We have "),
                          TextSpan(text: subnets.toString(), style: TextStyle(color: MyColorTheme.PrimaryAccent)),
                          TextSpan(text: " subnets witch "),
                          TextSpan(text: hosts.toString(), style: TextStyle(color: MyColorTheme.PrimaryAccent)),
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
              color: MyColorTheme.Secondary,
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
                        child: Text("Subnets:", style: TextStyle(color: MyColorTheme.PrimaryAccent, fontSize: 16),),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        style: TextStyle(color: Colors.white),
                        cursorColor: Color(0xFFFF6B00),
                        decoration: snipInputDecoration.copyWith(hintText: "Bits for subnets"),
                        onChanged: (val) {
                          setState(() {
                            if (val.isNotEmpty){
                              _answerSN = int.parse(val);
                              _warningVisible = false;
                            }else{
                              _answerSN = null;
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
                        child: Text("Hosts:", style: TextStyle(color: MyColorTheme.PrimaryAccent, fontSize: 16),),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        style: TextStyle(color: Colors.white),
                        cursorColor: Color(0xFFFF6B00),
                        decoration: snipInputDecoration.copyWith(hintText: "Bits for hosts"),
                        onChanged: (val) {
                          setState(() {
                            if (val.isNotEmpty){
                              _answerHosts = int.parse(val);
                              _warningVisible = false;
                            }else{
                              _answerHosts = null;
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
        yourAnswer: "${_answerSN} bits for ${subnets} subnets and ${_answerHosts} bits for ${hosts} hosts.",
        correctAnswer: "${_correctSN} bits for  ${subnets} subnets and ${_correctHosts} bits for ${hosts} hosts.",
        explanation: RichText(
          textAlign: TextAlign.justify,
          text: TextSpan(
            style: TextStyle(fontSize: 16),
            children: <TextSpan>[
              TextSpan(text: "Solution one: add "),
              TextSpan(text: "1", style: TextStyle(color: MyColorTheme.PrimaryAccent)),
              TextSpan(text: ". This is because the first IP address of the subnet is reserved for the subnet itself and the last IP address is used for broadcast. In binary we count from 0 so we only need to add 1. \n\nNext step: convert into binary, "),
              TextSpan(text: (subnets+1).toString(), style: TextStyle(color: MyColorTheme.PrimaryAccent)),
              TextSpan(text: " in binary is "),
              TextSpan(text: DecToBin(subnets+1).toString(), style: TextStyle(color: MyColorTheme.PrimaryAccent)),
              TextSpan(text: ", which are "),
              TextSpan(text: ((subnets+1).bitLength).toString(), style: TextStyle(color: MyColorTheme.PrimaryAccent)),
              TextSpan(text: " bits.\n\nSolution two: This time add "),
              TextSpan(text: "2", style: TextStyle(color: MyColorTheme.PrimaryAccent)),
              TextSpan(text: ", because now we wont use binary numbers so we count from 1 and we must count in 2 additional addresses. \n\nNext step: find the closest power of 2, closest to "),
              TextSpan(text: (subnets+2).toString(), style: TextStyle(color: MyColorTheme.PrimaryAccent)),
              TextSpan(text: " is "),
              TextSpan(text: (pow(2, (subnets+1).bitLength)).toString(), style: TextStyle(color: MyColorTheme.PrimaryAccent)),
              TextSpan(text: ". At this point you should now that this is 2 to the power of "),
              TextSpan(text: ((subnets+1).bitLength).toString(), style: TextStyle(color: MyColorTheme.PrimaryAccent)),
              TextSpan(text: ", so you need "),
              TextSpan(text: ((subnets+1).bitLength).toString(), style: TextStyle(color: MyColorTheme.PrimaryAccent)),
              TextSpan(text: " bits."),
            ],
          ),
        ),
      );
    }
  }
}