import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:maturita/Pages/HomePage/school/classless/resultsPageLess.dart';
import 'questionFour.dart';
import 'package:maturita/Pages/HomePage/school/classless/questionThreeLess.dart';
import 'questionOne.dart';
import 'package:maturita/Pages/HomePage/school/classful/questionThreeFul.dart';
import 'questionTwo.dart';
import 'package:maturita/Pages/HomePage/school/classful/resultsPageFul.dart';
import 'package:maturita/shared/design.dart';
import 'package:provider/provider.dart';
import 'package:maturita/Models/user.dart';

class QuestionsPage extends StatefulWidget {
  @override
  _QuestionsPageState createState() => _QuestionsPageState();
}

final PageController questionController = PageController(initialPage: 0);

bool fulOrLessQuestions;

class _QuestionsPageState extends State<QuestionsPage> {

  int questionPageIndex = 1;

  @override
  Widget build(BuildContext context) {

    final userData = Provider.of<UserData>(context);
    final user = Provider.of<MyUser>(context);


    List<Widget> _pages = [];

    if (fulOrLessQuestions){
      _pages = [
        QuestionOne(),
        QuestionTwo(),
        QuestionThreeFul(),
        QuestionFour(),
        ResultsPageFul(),
      ];
    }else{
      _pages = [
        QuestionOne(),
        QuestionTwo(),
        QuestionThreeLess(),
        QuestionFour(),
        ResultsPageLess(),
      ];
    }


    return KeyboardVisibilityBuilder(
        builder: (context, isKeyboardVisible){
          return Column(
            children: [
              SizedBox(height: 75,),
              Text(questionPageIndex == 5 ? "4 / 4" : questionPageIndex.toString() + " / " + (_pages.length-1).toString(), style: TextStyle(color: MyColorTheme.PrimaryAccent, fontSize: 24, fontWeight: FontWeight.bold),),
              Expanded(
                child: PageView(
                  physics: new NeverScrollableScrollPhysics(),
                  scrollBehavior: null,
                  controller: questionController,
                  onPageChanged: (index){
                    setState(() {
                      questionPageIndex = index+1;
                    });
                  },
                  children: _pages,
                ),
              ),
            ],
          );
        }
    );
  }
}
