import 'package:flutter/material.dart';
import 'package:maturita/Models/sniper.dart';
import 'package:maturita/Models/user.dart';
import 'package:maturita/Pages/HomePage/profile/profile.dart';
import 'package:maturita/Pages/HomePage/school/school.dart';
import 'package:maturita/Pages/HomePage/settings/settings.dart';
import 'calculator/input.dart';
import 'calculator/calculator.dart';
import 'package:maturita/Services/database.dart';
import 'package:provider/provider.dart';
import 'package:maturita/shared/design.dart';

class HomePage extends StatefulWidget {

  const HomePage ({Key key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

GlobalKey<HomePageState> myKey = GlobalKey();
bool hideInputBool = false;

class HomePageState extends State<HomePage> {

  void onSubmited(){
    if (hideInputBool == false){
      calculateIP();
    }
    hideInput();
  }

  void hideInput(){
    setState(() {
      submitBool = true;
      hideInputBool = !hideInputBool;
    });
  }

  void changeClass(){
    setState(() {
      fullOrLess = !fullOrLess;
    });
    if (hideInputBool == true){
      calculateIP();
    }
  }

  void changeSpare(){
    setState(() {
      spareSwitch = !spareSwitch;
    });
  }

  int bottomSelectedIndex = 1;
  final PageController mainPageController = PageController(initialPage: 1, keepPage: true,);

  @override
  void initState() {
    super.initState();
  }

  void pageChanged(int index) {
    setState(() {
      bottomSelectedIndex = index;
    });
  }

  void bottomTapped(int index) {
    setState(() {
      bottomSelectedIndex = index;
      mainPageController.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Sniper>>.value(
      value: DatabaseService().snipers,
      child: Scaffold(
        backgroundColor: Color(0xFF100B1F),

        body: PageView(
          controller: mainPageController,
          onPageChanged: (index) {
            pageChanged(index);
          },
          children: [
            SettingsPage(),
            ProfilePage(),
            SchoolPage(),
            CalculatorPage(),
          ],
        ),

        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Color(0xFFFF6B00),
          currentIndex: bottomSelectedIndex,
          onTap: (index) {
            bottomTapped(index);
          },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              backgroundColor: MyColorTheme.NavBar,
              label: 'Settings',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_box),
              backgroundColor: MyColorTheme.NavBar,
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.school),
              backgroundColor: MyColorTheme.NavBar,
              label: 'School',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calculate),
              backgroundColor: MyColorTheme.NavBar,
              label: 'Calculator',
            ),
          ],
        ),
      ),
    );
  }
}