import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maturita/Pages/HomePage/school/classful/classFulQuestionsPage.dart';
import 'package:maturita/main.dart';
import 'package:maturita/shared/design.dart';

class CorrectAnswerPage extends StatefulWidget {

  final String yourAnswer;
  final String correctAnswer;
  final RichText explanation;
  CorrectAnswerPage({ this.yourAnswer, this.correctAnswer, this.explanation });

  @override
  _CorrectAnswerPageState createState() => _CorrectAnswerPageState();
}

class _CorrectAnswerPageState extends State<CorrectAnswerPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(width: double.infinity,child: Text("Wrong Answer", style: TextStyle(color: Colors.red, fontSize: 24, fontWeight: FontWeight.bold), textAlign: TextAlign.center,)),
          SizedBox(height: 15,),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Your answer:", style: TextStyle(color: MyColorTheme.PrimaryAccent, fontSize: 16),),
                Text(widget.yourAnswer, style: TextStyle(color: MyColorTheme.Text, fontSize: 16),),
                SizedBox(height: 15,),
                Text("Correct answer:", style: TextStyle(color: MyColorTheme.PrimaryAccent, fontSize: 16),),
                Text(widget.correctAnswer, style: TextStyle(color: MyColorTheme.Text, fontSize: 16),),
                SizedBox(height: 15,),
                Text("Explanation:", style: TextStyle(color: MyColorTheme.PrimaryAccent, fontSize: 16),),
                widget.explanation,
              ],
            ),
          ),
          SizedBox(height: 15,),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ButtonTheme(
                  padding: EdgeInsets.zero,
                  child: FlatButton(
                    onPressed: () {
                      if (questionController.page == 3){
                        Navigator.pop(context);
                        setState(() {});
                      }else{
                        questionController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.easeInCubic);
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
                          questionController.page == 3 ? "End Exercise" : "Next Question",
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
