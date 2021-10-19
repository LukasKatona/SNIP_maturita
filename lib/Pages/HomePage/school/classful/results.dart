import 'package:flutter/material.dart';
import 'package:maturita/Models/user.dart';
import 'package:maturita/Pages/HomePage/school/classful/questionFour.dart';
import 'package:maturita/Pages/HomePage/school/school_card.dart';
import 'package:maturita/shared/design.dart';
import 'package:provider/provider.dart';

class ResultsPage extends StatefulWidget {
  @override
  _ResultsPageState createState() => _ResultsPageState();
}

List<bool> correctAnsList = List<bool>(8);

class _ResultsPageState extends State<ResultsPage> {

  int getNumOfCorrectAns() {
    int _correct = 0;
    for(int i = 0; i < correctAnsList.length; i++){
      if (correctAnsList[i]){
        _correct++;
      }
    }
    return _correct;
  }

  int getQuestionFourXp() {
    int xp = 0;
    for (int i = 4; i < correctAnsList.length; i++){
      if (correctAnsList[i]){
        xp++;
      }
    }
    return (xp*2*xpMultiplier);
  }

  int getQuestionThreeXp() {
    int xp = 0;
    for (int i = 2; i < 4; i++){
      if (correctAnsList[i]){
        xp++;
      }
    }
    return (xp*xpMultiplier);
  }

  @override
  Widget build(BuildContext context) {
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
                  Text("Practise Results", style: TextStyle(color: MyColorTheme.Text, fontSize: 24),),
                  SizedBox(height: 25,),
                  SizedBox(
                    height: 150,
                    width: 150,
                    child: Stack(
                      children: [
                        SizedBox(
                          height: 150,
                          width: 150,
                          child: CircularProgressIndicator(
                            value: getNumOfCorrectAns()/8,
                            valueColor: AlwaysStoppedAnimation<Color>(MyColorTheme.PrimaryAccent),
                            backgroundColor: MyColorTheme.Primary,
                            strokeWidth: 15,
                          ),
                        ),
                        Center(
                          child:  RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: TextStyle(fontSize: 32),
                              children: <TextSpan>[
                                TextSpan(text: (getNumOfCorrectAns()/8*100).ceil().toString(), style: TextStyle(color: MyColorTheme.PrimaryAccent)),
                                TextSpan(text: "%", style: TextStyle(color: MyColorTheme.Text)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15,),
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
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Text("Class", style: TextStyle(color: correctAnsList[0] ? Colors.green : Colors.red, fontSize: 24),),
                          Expanded(child: Center(child: Text(correctAnsList[0] ? "+" + (1*xpMultiplier).toString() + " XP" : "+0 XP", style: TextStyle(color: MyColorTheme.Text, fontSize: 24),))),
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
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Text("Mask", style: TextStyle(color: correctAnsList[1] ? Colors.green : Colors.red, fontSize: 24),),
                          Expanded(child: Center(child: Text(correctAnsList[1] ? "+" + (1*xpMultiplier).toString() + " XP" : "+0 XP", style: TextStyle(color: MyColorTheme.Text, fontSize: 24),))),
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
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Text("Bits", style: TextStyle(color: correctAnsList[2] && correctAnsList[3] ? Colors.green : Colors.red, fontSize: 24),),
                          Expanded(child: Center(child: Text("+" + getQuestionThreeXp().toString() + " XP", style: TextStyle(color: MyColorTheme.Text, fontSize: 24),))),
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
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Text("Subnet", style: TextStyle(color: (correctAnsList[7] && correctAnsList[4] && correctAnsList[5] && correctAnsList[6]) ? Colors.green : Colors.red, fontSize: 24),),
                          Expanded(child: Center(child: Text("+" + getQuestionFourXp().toString() + " XP", style: TextStyle(color: MyColorTheme.Text, fontSize: 24),))),
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
              ],
            ),
          ),
          SizedBox(height: 15,),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ButtonTheme(
                padding: EdgeInsets.zero,
                child: FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                    setState(() {});
                  },
                  child: ConfirmButtonDecor(greenConfirm: false,),
                ),
              ),
              SizedBox(height: 15,),
            ],
          ),
        ],
      ),
    );
  }
}
