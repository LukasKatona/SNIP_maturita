import 'dart:math';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter/material.dart';
import 'package:maturita/Models/user.dart';
import 'package:maturita/Pages/HomePage/calculator/calculator.dart';
import 'package:maturita/Pages/HomePage/school/classless/questionThreeLess.dart';
import 'package:maturita/Pages/HomePage/school/classless/resultsPageLess.dart';
import 'questionsPage.dart';
import 'correctAnswerPage.dart';
import 'package:maturita/Pages/HomePage/school/classful/resultsPageFul.dart';
import 'package:maturita/Services/database.dart';
import 'package:maturita/shared/design.dart';
import 'package:maturita/Pages/HomePage/school/school_card.dart';
import 'package:provider/provider.dart';

class QuestionFour extends StatefulWidget {
  @override
  _QuestionFourState createState() => _QuestionFourState();
}

class _QuestionFourState extends State<QuestionFour> {

  int _SNindex = fulOrLessQuestions ? new Random().nextInt(subnets) : new Random().nextInt(4) + 1;

  int _correctSN = 0;
  int _correctBC = 0;
  int _correctFH = 0;
  int _correctLH = 0;
  bool _wrongAnswer = false;
  bool _greenConfirm = false;
  bool _warningVisible = false;

  List<String> answers = List<String>(4);
  List<String> correctAnswers = List<String>(4);

  void calAnswerFul(){
    _correctSN = ((pow(2, ((hosts+1).bitLength)))*_SNindex);
    _correctFH = _correctSN+1;

    _correctBC = ((pow(2, ((hosts+1).bitLength)))*(_SNindex+1)-1);
    _correctLH = _correctBC-1;
  }

  void calAnswerLess(){

    for (int i = 1; i < _SNindex; i++){
      _correctSN = _correctSN + correctHostsOrderAndValues[4-i];
    }
    _correctFH = _correctSN+1;
    _correctBC = _correctSN + correctHostsOrderAndValues[4-_SNindex] - 1;
    _correctLH = _correctBC-1;
  }

  @override
  Widget build(BuildContext context) {

    final userData = Provider.of<UserData>(context);
    final user = Provider.of<MyUser>(context);

    void _afterConfirm() async {
      if (answers[0] != null && answers[1] != null && answers[2] != null && answers[3] != null){

        if (fulOrLessQuestions){
          calAnswerFul();
        }else{
          calAnswerLess();
        }

        correctAnswers[0] = firstByte.toString() + "." + (_correctSN/65536).floor().toString() + "." + (_correctSN%65536/256).floor().toString() + "." + (_correctSN%65536%256).toString();
        correctAnswers[1] = firstByte.toString() + "." + (_correctFH/65536).floor().toString() + "." + (_correctFH%65536/256).floor().toString() + "." + (_correctFH%65536%256).toString();
        correctAnswers[2] = firstByte.toString() + "." + (_correctLH/65536).floor().toString() + "." + (_correctLH%65536/256).floor().toString() + "." + (_correctLH%65536%256).toString();
        correctAnswers[3] = firstByte.toString() + "." + (_correctBC/65536).floor().toString() + "." + (_correctBC%65536/256).floor().toString() + "." + (_correctBC%65536%256).toString();

        bool wrong = false;
        int correct = 0;

        for (int i = 0; i < 4; i++){
          if (answers[i] == correctAnswers[i]){
            print('${i} is correct');
            correct++;
            fulOrLessQuestions ? correctAnsListFul[4+i] = true : correctAnsListLess[7+i] = true;
          }else{
            print('${i} is not correct');
            fulOrLessQuestions ? correctAnsListFul[4+i] = false : correctAnsListLess[7+i] = false;
            wrong = true;
          }
        }

        for(int i = 0; i < correctAnsListLess.length; i++){
          print(correctAnsListLess[i]);
        }

        if (fulOrLessQuestions){
          await DatabaseService(uid: user.uid).updateUserData(userData.name, userData.role, userData.isCalLocked, userData.fulXp + (2*xpMultiplier*correct), userData.lessXp, userData.group, userData.darkOrLight);
        }else{
          await DatabaseService(uid: user.uid).updateUserData(userData.name, userData.role, userData.isCalLocked, userData.fulXp, userData.lessXp + (2*xpMultiplier*correct), userData.group, userData.darkOrLight);
        }

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
                            Text(firstByte.toString() + ".0.0.0", style: TextStyle(color: myColorTheme.PrimaryAccent, fontSize: 24),),
                            SizedBox(height: 15,),
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                style: TextStyle(fontSize: 16, color: myColorTheme.Text),
                                children: fulOrLessQuestions ? <TextSpan>[
                                  TextSpan(text: "We have "),
                                  TextSpan(text: subnets.toString(), style: TextStyle(color: myColorTheme.PrimaryAccent)),
                                  TextSpan(text: " subnets witch "),
                                  TextSpan(text: hosts.toString(), style: TextStyle(color: myColorTheme.PrimaryAccent)),
                                  TextSpan(text: " hosts in each. Describe subnet number "),
                                  TextSpan(text: _SNindex.toString(), style: TextStyle(color: myColorTheme.PrimaryAccent)),
                                  TextSpan(text: "."),
                                ] : <TextSpan>[
                                  TextSpan(text: "We have "),
                                  TextSpan(text: "4", style: TextStyle(color: myColorTheme.PrimaryAccent)),
                                  TextSpan(text: " subnets witch these ranges: "),
                                  TextSpan(text: "${correctHostsOrderAndValues[3]}, ${correctHostsOrderAndValues[2]}, ${correctHostsOrderAndValues[1]}, ${correctHostsOrderAndValues[0]}", style: TextStyle(color: myColorTheme.PrimaryAccent)),
                                  TextSpan(text: ". Describe subnet number "),
                                  TextSpan(text: _SNindex.toString(), style: TextStyle(color: myColorTheme.PrimaryAccent)),
                                  TextSpan(text: "."),
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
                      hintText: "Subnet IP address",
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
                          answers[0] = val;
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
                    style: TextStyle(color: myColorTheme.Text),
                    cursorColor: myColorTheme.PrimaryAccent,
                    decoration: InputDecoration(
                      hintText: "IP address of the first host",
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
                          answers[1] = val;
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
                    style: TextStyle(color: myColorTheme.Text),
                    cursorColor: myColorTheme.PrimaryAccent,
                    decoration: InputDecoration(
                      hintText: "IP address of the last host",
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
                          answers[2] = val;
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
                    style: TextStyle(color: myColorTheme.Text),
                    cursorColor: myColorTheme.PrimaryAccent,
                    decoration: InputDecoration(
                      hintText: "Broadcast IP address",
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
                          answers[3] = val;
                          _warningVisible = false;
                        }else{
                          answers[3] = null;
                        }
                      });
                    },
                  ),
                  SizedBox(height: 15,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Note: if there are any spare bits, they are added to the subnet bits.", style: TextStyle(color: myColorTheme.Text),),
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
          }
      );
    }else{
      return CorrectAnswerPage(
        yourAnswer: "SN: ${answers[0]}    FH: ${answers[1]}\nLH: ${answers[2]}    BC: ${answers[3]}",
        correctAnswer: "SN: ${correctAnswers[0]}    FH: ${correctAnswers[1]}\nLH: ${correctAnswers[2]}    BC: ${correctAnswers[3]}",
        explanation: RichText(
          textAlign: TextAlign.justify,
          text: TextSpan(
            style: TextStyle(fontSize: 16, color: myColorTheme.Text),
            children: fulOrLessQuestions ? <TextSpan>[
              TextSpan(text: "Solution to this question is easy but it takes time. First multiply the number of the subnet with magic number, which is the host range of one subnet. This will give you the "),
              TextSpan(text: "IP", style: TextStyle(color: myColorTheme.PrimaryAccent)),
              TextSpan(text: " of the subnet.\n\nTo get the "),
              TextSpan(text: "first host", style: TextStyle(color: myColorTheme.PrimaryAccent)),
              TextSpan(text: ", add 1. "),
              TextSpan(text: "Broadcast", style: TextStyle(color: myColorTheme.PrimaryAccent)),
              TextSpan(text: " is just IP of the next subnet minus 1 and the "),
              TextSpan(text: "last host", style: TextStyle(color: myColorTheme.PrimaryAccent)),
              TextSpan(text: " is just the broadcast minus 1.\n\nThe tricky part of this is that in "),
              TextSpan(text: "Class A", style: TextStyle(color: myColorTheme.PrimaryAccent)),
              TextSpan(text: " and "),
              TextSpan(text: "Class B", style: TextStyle(color: myColorTheme.PrimaryAccent)),
              TextSpan(text: " we are working with more that one byte. To learn how to divide big numbers into two and more bytes, please do the "),
              TextSpan(text: "Dividing Numbers into Bytes", style: TextStyle(color: myColorTheme.PrimaryAccent)),
              TextSpan(text: " exercise."),
            ] : <TextSpan>[
              TextSpan(text: "In Classless IP addressing, subnets take from the network IP range only that amount of IP addresses they need. To calculate the IP address of a subnet, simply "),
              TextSpan(text: "add up the ranges", style: TextStyle(color: myColorTheme.PrimaryAccent)),
              TextSpan(text: " of previous subnets.\n\nTo calculate the "),
              TextSpan(text: "first host", style: TextStyle(color: myColorTheme.PrimaryAccent)),
              TextSpan(text: ", add 1. "),
              TextSpan(text: "Broadcast", style: TextStyle(color: myColorTheme.PrimaryAccent)),
              TextSpan(text: " is just IP address of the subnet plus subnet range  minus 1 and the "),
              TextSpan(text: "last host", style: TextStyle(color: myColorTheme.PrimaryAccent)),
              TextSpan(text: " is just the broadcast minus 1.\n\nThe tricky part of this is that in "),
              TextSpan(text: "Class A", style: TextStyle(color: myColorTheme.PrimaryAccent)),
              TextSpan(text: " and "),
              TextSpan(text: "Class B", style: TextStyle(color: myColorTheme.PrimaryAccent)),
              TextSpan(text: " we are working with more that one byte. To learn how to divide big numbers into two and more bytes, please do the "),
              TextSpan(text: "Dividing Numbers into Bytes", style: TextStyle(color: myColorTheme.PrimaryAccent)),
              TextSpan(text: " exercise."),
            ],
          ),
        ),
      );
    }
  }
}