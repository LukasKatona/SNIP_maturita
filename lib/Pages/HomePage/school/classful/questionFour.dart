import 'dart:math';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter/material.dart';
import 'package:maturita/Models/user.dart';
import 'package:maturita/Pages/HomePage/calculator/calculator.dart';
import 'package:maturita/Pages/HomePage/school/classful/classFulQuestionsPage.dart';
import 'package:maturita/Pages/HomePage/school/classful/correctAnswer.dart';
import 'package:maturita/Pages/HomePage/school/classful/results.dart';
import 'package:maturita/Services/database.dart';
import 'package:maturita/shared/design.dart';
import 'package:maturita/Pages/HomePage/school/school_card.dart';
import 'package:provider/provider.dart';

class QuestionFour extends StatefulWidget {
  @override
  _QuestionFourState createState() => _QuestionFourState();
}

class _QuestionFourState extends State<QuestionFour> {

  int _SNindex = new Random().nextInt(subnets);

  int _correctSN;
  int _correctBC;
  int _correctFH;
  int _correctLH;
  bool _wrongAnswer = false;
  bool _greenConfirm = false;
  bool _warningVisible = false;

  List<String> answers = List<String>(4);
  List<String> correctAnswers = List<String>(4);

  void calAnswer(){
    _correctSN = ((pow(2, ((hosts+1).bitLength)))*_SNindex);
    _correctFH = _correctSN+1;

    _correctBC = ((pow(2, ((hosts+1).bitLength)))*(_SNindex+1)-1);
    _correctLH = _correctBC-1;

    correctAnswers[0] = firstByte.toString() + "." + (_correctSN/65536).floor().toString() + "." + (_correctSN%65536/256).floor().toString() + "." + (_correctSN%65536%256).toString();
    correctAnswers[1] = firstByte.toString() + "." + (_correctFH/65536).floor().toString() + "." + (_correctFH%65536/256).floor().toString() + "." + (_correctFH%65536%256).toString();
    correctAnswers[2] = firstByte.toString() + "." + (_correctLH/65536).floor().toString() + "." + (_correctLH%65536/256).floor().toString() + "." + (_correctLH%65536%256).toString();
    correctAnswers[3] = firstByte.toString() + "." + (_correctBC/65536).floor().toString() + "." + (_correctBC%65536/256).floor().toString() + "." + (_correctBC%65536%256).toString();
  }

  @override
  Widget build(BuildContext context) {

    final userData = Provider.of<UserData>(context);
    final user = Provider.of<MyUser>(context);

    void _afterConfirm() async {
      if (answers[0] != null && answers[1] != null && answers[2] != null && answers[3] != null){
        calAnswer();
        int wrongs = 0;

        for (int i = 0; i < 4; i++){
          if (answers[i] == correctAnswers[i]){
            print('${i} is correct');
            correctAnsList[3+i] = true;
            await DatabaseService(uid: user.uid).updateUserData(userData.name, userData.role, userData.anon, userData.fulXp + 2, userData.lessXp);
          }else{
            print('${i} is not correct');
            correctAnsList[3+i] = false;
            wrongs++;
          }
        }

        if (wrongs == 0){
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
                                  TextSpan(text: " hosts in each. Describe subnet number "),
                                  TextSpan(text: _SNindex.toString(), style: TextStyle(color: MyColorTheme.PrimaryAccent)),
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
                      color: MyColorTheme.Secondary,
                    ),
                  ),
                  SizedBox(height: 15,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Answer:", style: TextStyle(color: MyColorTheme.PrimaryAccent, fontSize: 16),),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: Colors.white),
                    cursorColor: Color(0xFFFF6B00),
                    decoration: snipInputDecoration.copyWith(hintText: "Subnet IP address"),
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
                    style: TextStyle(color: Colors.white),
                    cursorColor: Color(0xFFFF6B00),
                    decoration: snipInputDecoration.copyWith(hintText: "IP address of the first host"),
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
                    style: TextStyle(color: Colors.white),
                    cursorColor: Color(0xFFFF6B00),
                    decoration: snipInputDecoration.copyWith(hintText: "IP address of the last host"),
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
                    style: TextStyle(color: Colors.white),
                    cursorColor: Color(0xFFFF6B00),
                    decoration: snipInputDecoration.copyWith(hintText: "Broadcast IP address"),
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
            style: TextStyle(fontSize: 16),
            children: <TextSpan>[
              TextSpan(text: "Solution to this question is easy but it takes time. First multiply the number of the subnet with magic number, which is the host range of one subnet. This will give you the "),
              TextSpan(text: "IP", style: TextStyle(color: MyColorTheme.PrimaryAccent)),
              TextSpan(text: " of the subnet.\n\nTo get the "),
              TextSpan(text: "first host", style: TextStyle(color: MyColorTheme.PrimaryAccent)),
              TextSpan(text: ", add 1. "),
              TextSpan(text: "Broadcast", style: TextStyle(color: MyColorTheme.PrimaryAccent)),
              TextSpan(text: " is just IP of the next subnet minus 1 and the "),
              TextSpan(text: "last host", style: TextStyle(color: MyColorTheme.PrimaryAccent)),
              TextSpan(text: " is just the broadcast minus 1.\n\nThe tricky part of this is that in "),
              TextSpan(text: "Class A", style: TextStyle(color: MyColorTheme.PrimaryAccent)),
              TextSpan(text: " and "),
              TextSpan(text: "Class B", style: TextStyle(color: MyColorTheme.PrimaryAccent)),
              TextSpan(text: " we are working with more that one byte. To learn how to divide big numbers into two and more bytes, please do the "),
              TextSpan(text: "Dividing Numbers into Bytes", style: TextStyle(color: MyColorTheme.PrimaryAccent)),
              TextSpan(text: " exercise."),
            ],
          ),
        ),
      );
    }
  }
}