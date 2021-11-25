import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:maturita/Models/user.dart';
import 'package:maturita/Pages/HomePage/school/classless/resultsPageLess.dart';
import '../questionsPage.dart';
import '../correctAnswerPage.dart';
import 'package:maturita/Pages/HomePage/school/classful/resultsPageFul.dart';
import 'package:maturita/shared/design.dart';
import 'package:maturita/Pages/HomePage/school/school_card.dart';
import 'package:maturita/Services/database.dart';
import 'package:provider/provider.dart';

class QuestionThreeLess extends StatefulWidget {
  @override
  _QuestionThreeLessState createState() => _QuestionThreeLessState();
}

List<int> hostListForQuestionThree = List<int>(4);
List<int> correctOrderList = List<int>(4);
List<int> correctHostsOrderAndValues = List<int>(4);

class _QuestionThreeLessState extends State<QuestionThreeLess> {

  bool _wrongAnswer = false;
  bool _greenConfirm = false;
  bool _warningVisible = false;

  List<int> answers = List<int>(4);

  void _createCorrectHostsOrderAndValues() {
    for (int i = 0; i < 4; i++){
      setState(() {
        correctHostsOrderAndValues[i] = pow(2, ((correctOrderList[i]+1).bitLength));
      });
    }
  }



  @override
  Widget build(BuildContext context) {

    final userData = Provider.of<UserData>(context);
    final user = Provider.of<MyUser>(context);

    bool _checkDescendingOrder(){
      bool check = true;
      for (int i = 0; i < hostListForQuestionThree.length-1; i++) {
        if (hostListForQuestionThree[i] < hostListForQuestionThree[i+1]) {
          setState(() {
            check = false;
          });
        }
      }
      return check;
    }


    void _afterConfirm() async {

      correctOrderList = List.from(hostListForQuestionThree);
      correctOrderList.sort();
      _createCorrectHostsOrderAndValues();

      if (answers[0] != null && answers[1] != null && answers[2] != null && answers[3] != null){

        int correct = 0;

        if(_checkDescendingOrder()){
          correct++;
          setState(() {
            correctAnsListLess[2] = true;
          });
        }else{
          setState(() {
            correctAnsListLess[2] = false;
          });
        }

        for (int i = 0; i < 4; i++){
          if (pow(2, ((hostListForQuestionThree[i]+1).bitLength)) == answers[i]){
            correct++;
            setState(() {
              correctAnsListLess[3+i] = true;
            });
          }else{
            setState(() {
              correctAnsListLess[3+i] = false;
            });
          }
        }

        await DatabaseService(uid: user.uid).updateUserData(userData.name, userData.role, userData.isCalLocked, userData.fulXp, userData.lessXp + (1*xpMultiplier*correct), userData.group);

        if (correct == 5){
          setState(() {
            _greenConfirm = true;
          });
          print("correct");
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
      return KeyboardVisibilityBuilder(
          builder: (context, isKeyboardVisible) {
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Visibility(
                    visible: isKeyboardVisible == false,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Text(firstByte.toString() + ".0.0.0", style: TextStyle(color: MyColorTheme.PrimaryAccent, fontSize: 24),),
                            SizedBox(height: 15,),
                            Text("Arrange these host numbers in descending order.\nWhat address range do we need for each of these subnets?", style: TextStyle(color: MyColorTheme.Text, fontSize: 16), textAlign: TextAlign.center,),
                          ],
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      elevation: 0,
                      color: MyColorTheme.Secondary,
                    ),
                  ),
                  SizedBox(height: 15,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Hosts", style: TextStyle(color: MyColorTheme.PrimaryAccent, fontSize: 16),),
                        Text("Rounded", style: TextStyle(color: MyColorTheme.PrimaryAccent, fontSize: 16),),

                      ],
                    ),
                  ),

                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Theme(
                            data: ThemeData(
                              canvasColor: Colors.transparent,
                            ),
                            child: ReorderableListView(
                              children: hostListForQuestionThree.map((hostNum) => Padding(
                                key: Key("${hostNum}"),
                                padding: const EdgeInsets.only(bottom: 15),
                                child: Card(
                                  margin: EdgeInsets.zero,
                                  color: MyColorTheme.Secondary,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  elevation: 0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(21.5),
                                    child: Center(child: Text("${hostNum}", style: TextStyle(color: MyColorTheme.Text),)),
                                  ),
                                ),
                              )).toList(),
                              onReorder: (int start, int current) {
                                setState(() {
                                  // dragging from top to bottom
                                  if (start < current) {
                                    int end = current - 1;
                                    int startItem = hostListForQuestionThree[start];
                                    int i = 0;
                                    int local = start;
                                    do {
                                      hostListForQuestionThree[local] = hostListForQuestionThree[++local];
                                      i++;
                                    } while (i < end - start);
                                    hostListForQuestionThree[end] = startItem;
                                  }
                                  // dragging from bottom to top
                                  else if (start > current) {
                                    int startItem = hostListForQuestionThree[start];
                                    for (int i = start; i > current; i--) {
                                      hostListForQuestionThree[i] = hostListForQuestionThree[i - 1];
                                    }
                                    hostListForQuestionThree[current] = startItem;
                                  }
                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox(width: 15,),
                        Expanded(
                          child: Column(
                            children: [
                              TextFormField(
                                keyboardType: TextInputType.number,
                                style: TextStyle(color: MyColorTheme.Text),
                                cursorColor: MyColorTheme.PrimaryAccent,
                                decoration: snipInputDecoration.copyWith(hintText: "power of 2"),
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
                              SizedBox(height: 15,),
                              TextFormField(
                                keyboardType: TextInputType.number,
                                style: TextStyle(color: MyColorTheme.Text),
                                cursorColor: MyColorTheme.PrimaryAccent,
                                decoration: snipInputDecoration.copyWith(hintText: "power of 2"),
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
                              SizedBox(height: 15,),
                              TextFormField(
                                keyboardType: TextInputType.number,
                                style: TextStyle(color: MyColorTheme.Text),
                                cursorColor: MyColorTheme.PrimaryAccent,
                                decoration: snipInputDecoration.copyWith(hintText: "power of 2"),
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
                              SizedBox(height: 15,),
                              TextFormField(
                                keyboardType: TextInputType.number,
                                style: TextStyle(color: MyColorTheme.Text),
                                cursorColor: MyColorTheme.PrimaryAccent,
                                decoration: snipInputDecoration.copyWith(hintText: "power of 2"),
                                onChanged: (val) {
                                  setState(() {
                                    if (val.isNotEmpty){
                                      answers[3] = int.parse(val);
                                      _warningVisible = false;
                                    }else{
                                      answers[3] = null;
                                    }
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),


                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 30,
                        child: Visibility(
                          visible: _warningVisible,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Please fill up all fields!", style: TextStyle(color: Colors.red),),
                          ),
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
                ],
              ),
            );
          }
      );

    }else{
      return CorrectAnswerPage(
        yourAnswer: "${hostListForQuestionThree[0]}, ${hostListForQuestionThree[1]}, ${hostListForQuestionThree[2]}, ${hostListForQuestionThree[3]} rounded to ${answers[0]}, ${answers[1]}, ${answers[2]}, ${answers[3]}",
        correctAnswer: "${correctOrderList[3]}, ${correctOrderList[2]}, ${correctOrderList[1]}, ${correctOrderList[0]}, rounded to ${correctHostsOrderAndValues[3]}, ${correctHostsOrderAndValues[2]}, ${correctHostsOrderAndValues[1]}, ${correctHostsOrderAndValues[0]}",
        explanation: RichText(
          textAlign: TextAlign.justify,
          text: TextSpan(
            style: TextStyle(fontSize: 16, color: MyColorTheme.Text),
            children: <TextSpan>[
              TextSpan(text: "It is important to arrange your subnets in "),
              TextSpan(text: "descending", style: TextStyle(color: MyColorTheme.PrimaryAccent)),
              TextSpan(text: " order based on the number of hosts, otherwise their ranges could overlap.\n\n"),

              TextSpan(text: "You also need to "),
              TextSpan(text: "round up", style: TextStyle(color: MyColorTheme.PrimaryAccent)),
              TextSpan(text: " the number of hosts in each subnet to the closest "),
              TextSpan(text: "power of 2", style: TextStyle(color: MyColorTheme.PrimaryAccent)),
              TextSpan(text: ", because the address range cannot be anything else."),

            ],
          ),
        ),);
    }
  }
}