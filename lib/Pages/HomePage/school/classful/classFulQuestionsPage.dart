import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:maturita/Pages/HomePage/school/classful/correctAnswer.dart';
import 'package:maturita/Pages/HomePage/school/classful/questionFour.dart';
import 'package:maturita/Pages/HomePage/school/classful/questionOne.dart';
import 'package:maturita/Pages/HomePage/school/classful/questionThree.dart';
import 'package:maturita/Pages/HomePage/school/classful/questionTwo.dart';
import 'package:maturita/shared/design.dart';
import 'package:provider/provider.dart';
import 'package:maturita/Models/user.dart';

class ClassFulQuestionsPage extends StatefulWidget {
  @override
  _ClassFulQuestionsPageState createState() => _ClassFulQuestionsPageState();
}

final PageController questionController = PageController(initialPage: 0);

class _ClassFulQuestionsPageState extends State<ClassFulQuestionsPage> {

  int questionPageIndex = 1;

  @override
  Widget build(BuildContext context) {

    final userData = Provider.of<UserData>(context);
    final user = Provider.of<MyUser>(context);


    List<Widget> _pages = [
      QuestionOne(),
      QuestionTwo(),
      QuestionThree(),
      QuestionFour(),
    ];


    return KeyboardVisibilityBuilder(
        builder: (context, isKeyboardVisible){
          return Column(
            children: [
              SizedBox(height: 75,),
              Text(questionPageIndex.toString() + " / " + _pages.length.toString(), style: TextStyle(color: MyColorTheme.PrimaryAccent, fontSize: 24, fontWeight: FontWeight.bold),),
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
