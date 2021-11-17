import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:maturita/Pages/HomePage/school/classless/resultsPageLess.dart';
import 'package:maturita/Pages/HomePage/school/decToBin/questionBinToDec.dart';
import 'package:maturita/Pages/HomePage/school/decToBin/questionDecToBin.dart';
import 'package:maturita/Pages/HomePage/school/dividingIntoBytes/questionOneBytes.dart';
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
int otherQuestions = 0;

class _QuestionsPageState extends State<QuestionsPage> {

  int questionPageIndex = 1;

  @override
  Widget build(BuildContext context) {

    final userData = Provider.of<UserData>(context);
    final user = Provider.of<MyUser>(context);

    String pageNumber = '';

    List<Widget> _pages = [];

    if (otherQuestions == 0){
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

      setState(() {
        pageNumber = questionPageIndex == 5 ? "4 / 4" : questionPageIndex.toString() + " / " + (_pages.length-1).toString();
      });

    }else if (otherQuestions == 1){
      pageNumber = questionPageIndex.toString() + ".";

          _pages = [
        QuestionOneBytes(),
      ];
    }else if (otherQuestions == 2){
      pageNumber = questionPageIndex.toString() + ".";

      _pages = [
        QuestionDecToBin(),
        QuestionBinToDec(),
      ];
    }

    return KeyboardVisibilityBuilder(
        builder: (context, isKeyboardVisible){
          return Column(
            children: [
              SizedBox(height: 75,),
              Text(pageNumber, style: TextStyle(color: MyColorTheme.PrimaryAccent, fontSize: 24, fontWeight: FontWeight.bold),),
              Expanded(
                child: PageView.builder(
                  itemBuilder: (context, index) {
                    return _pages[index % _pages.length];
                  },
                  physics: new NeverScrollableScrollPhysics(),
                  scrollBehavior: null,
                  controller: questionController,
                  onPageChanged: (index){
                    setState(() {
                      questionPageIndex = index+1;
                    });
                  },
                ),
              ),
            ],
          );
        }
    );
  }
}
