import 'package:flutter/material.dart';
import 'package:maturita/Models/user.dart';
import '../questionFour.dart';
import 'package:maturita/Pages/HomePage/school/school_card.dart';
import 'package:maturita/shared/design.dart';
import 'package:provider/provider.dart';

class ResultsPageFul extends StatefulWidget {
  @override
  _ResultsPageFulState createState() => _ResultsPageFulState();
}

List<bool> correctAnsListFul = List<bool>(8);

class _ResultsPageFulState extends State<ResultsPageFul> {

  int getNumOfCorrectAns() {
    int _correct = 0;
    for(int i = 0; i < correctAnsListFul.length; i++){
      if (correctAnsListFul[i]){
        _correct++;
      }
    }
    return _correct;
  }

  int getQuestionFourXp() {
    int xp = 0;
    for (int i = 4; i < correctAnsListFul.length; i++){
      if (correctAnsListFul[i]){
        xp++;
      }
    }
    return (xp*2*xpMultiplier);
  }

  int getQuestionThreeXp() {
    int xp = 0;
    for (int i = 2; i < 4; i++){
      if (correctAnsListFul[i]){
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
                  Text("Practise Results", style: TextStyle(color: myColorTheme.Text, fontSize: 24),),
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
                            valueColor: AlwaysStoppedAnimation<Color>(myColorTheme.PrimaryAccent),
                            backgroundColor: myColorTheme.Primary,
                            strokeWidth: 15,
                          ),
                        ),
                        Center(
                          child:  RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: TextStyle(fontSize: 32),
                              children: <TextSpan>[
                                TextSpan(text: (getNumOfCorrectAns()/8*100).ceil().toString(), style: TextStyle(color: myColorTheme.PrimaryAccent)),
                                TextSpan(text: "%", style: TextStyle(color: myColorTheme.Text)),
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
            color: myColorTheme.Secondary,
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
                          Text("Class", style: TextStyle(color: correctAnsListFul[0] ? Colors.green : Colors.red, fontSize: 24),),
                          Expanded(child: Center(child: Text(correctAnsListFul[0] ? "+" + (1*xpMultiplier).toString() + " XP" : "+0 XP", style: TextStyle(color: myColorTheme.Text, fontSize: 24),))),
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
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Text("Mask", style: TextStyle(color: correctAnsListFul[1] ? Colors.green : Colors.red, fontSize: 24),),
                          Expanded(child: Center(child: Text(correctAnsListFul[1] ? "+" + (1*xpMultiplier).toString() + " XP" : "+0 XP", style: TextStyle(color: myColorTheme.Text, fontSize: 24),))),
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
                          Text("Bits", style: TextStyle(color: correctAnsListFul[2] && correctAnsListFul[3] ? Colors.green : Colors.red, fontSize: 24),),
                          Expanded(child: Center(child: Text("+" + getQuestionThreeXp().toString() + " XP", style: TextStyle(color: myColorTheme.Text, fontSize: 24),))),
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
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Text("Subnet", style: TextStyle(color: (correctAnsListFul[7] && correctAnsListFul[4] && correctAnsListFul[5] && correctAnsListFul[6]) ? Colors.green : Colors.red, fontSize: 24),),
                          Expanded(child: Center(child: Text("+" + getQuestionFourXp().toString() + " XP", style: TextStyle(color: myColorTheme.Text, fontSize: 24),))),
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
