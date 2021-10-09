import 'package:flutter/material.dart';
import 'package:maturita/Pages/HomePage/school/classful/questionOne.dart';
import 'package:maturita/shared/design.dart';
import 'package:provider/provider.dart';
import 'package:maturita/Models/user.dart';

class ClassFulQuestionsPage extends StatefulWidget {
  @override
  _ClassFulQuestionsPageState createState() => _ClassFulQuestionsPageState();
}

class _ClassFulQuestionsPageState extends State<ClassFulQuestionsPage> {

  final PageController questionController = PageController(initialPage: 0);
  int questionPageIndex = 1;

  @override
  Widget build(BuildContext context) {

    final userData = Provider.of<UserData>(context);
    final user = Provider.of<MyUser>(context);


      List<Widget> _pages = [
      QuestionOne(),
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text("Question 1.", style: TextStyle(color: MyColorTheme.PrimaryAccent, fontSize: 24),),
                    SizedBox(height: 15,),
                    Text("You have an IP address of 192.168.1.0, in what class does this IP address belong? What is the default mask for this class?", style: TextStyle(color: MyColorTheme.Text, fontSize: 16), textAlign: TextAlign.center,),
                  ],
                ),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
              ),
              elevation: 0,
              color: MyColorTheme.Secondary,
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text("Question 1.", style: TextStyle(color: MyColorTheme.PrimaryAccent, fontSize: 24),),
                    SizedBox(height: 15,),
                    Text("You have an IP address of 192.168.1.0, in what class does this IP address belong? What is the default mask for this class?", style: TextStyle(color: MyColorTheme.Text, fontSize: 16), textAlign: TextAlign.center,),
                  ],
                ),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
              ),
              elevation: 0,
              color: MyColorTheme.Secondary,
            ),
          ],
        ),
      ),
    ];

    return Column(
      children: [
        SizedBox(height: 75,),
        Text(questionPageIndex.toString() + " / " + _pages.length.toString(), style: TextStyle(color: MyColorTheme.PrimaryAccent, fontSize: 24, fontWeight: FontWeight.bold),),
        Expanded(
          child: PageView(
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
}
