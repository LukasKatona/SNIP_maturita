import 'package:flutter/material.dart';
import 'package:maturita/Pages/HomePage/school/school_card.dart';
import 'package:maturita/shared/design.dart';

class ResultsPge extends StatefulWidget {
  @override
  _ResultsPgeState createState() => _ResultsPgeState();
}

List<bool> correctAnsList = List<bool>(7);

class _ResultsPgeState extends State<ResultsPge> {

  int getNumOfCorrectAns() {
    int _correct = 0;
    for(int i = 0; i < correctAnsList.length; i++){
      if (correctAnsList[i]){
        _correct++;
      }
    }
    return _correct;
  }

  int getQestionFourXp() {
    int xp = 0;
    for (int i = 3; i < correctAnsList.length; i++){
      if (correctAnsList[i]){
        xp++;
      }
    }
    return xp;
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
                            value: getNumOfCorrectAns()/7,
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
                                TextSpan(text: (getNumOfCorrectAns()/7*100).ceil().toString(), style: TextStyle(color: MyColorTheme.PrimaryAccent)),
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
                          Text("Class", style: TextStyle(color: correctAnsList[0] ? Colors.green : Colors.red, fontSize: 16),),
                          Expanded(child: Center(child: Text(correctAnsList[0] ? "+1 XP" : "+0 XP", style: TextStyle(color: MyColorTheme.Text, fontSize: 24),))),
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
                          Text("Mask", style: TextStyle(color: correctAnsList[1] ? Colors.green : Colors.red, fontSize: 16),),
                          Expanded(child: Center(child: Text(correctAnsList[1] ? "+1 XP" : "+0 XP", style: TextStyle(color: MyColorTheme.Text, fontSize: 24),))),
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
                          Text("Bits", style: TextStyle(color: correctAnsList[2] ? Colors.green : Colors.red, fontSize: 16),),
                          Expanded(child: Center(child: Text(correctAnsList[2] ? "+2 XP" : "+0 XP", style: TextStyle(color: MyColorTheme.Text, fontSize: 24),))),
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
                          Text("Subnet", style: TextStyle(color: (correctAnsList[3] && correctAnsList[4] && correctAnsList[5] && correctAnsList[6]) ? Colors.green : Colors.red, fontSize: 16),),
                          Expanded(child: Center(child: Text("+" + getQestionFourXp().toString() + " XP", style: TextStyle(color: MyColorTheme.Text, fontSize: 24),))),
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
