import 'package:flutter/material.dart';
import 'calculator/input.dart';
import 'calculator/calculator.dart';

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

  int bottomSelectedIndex = 0;
  final PageController mainPageController = PageController(initialPage: 0, keepPage: true,);

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
    return Scaffold(
      backgroundColor: Color(0xFF100B1F),

      body: PageView(
        controller: mainPageController,
        onPageChanged: (index) {
          pageChanged(index);
        },
        children: [
          Center(
            child: Text('SETTINGS'),
          ),
          Center(
            child: Text('PROFILE'),
          ),
          Center(
            child: Text('TUTORIALS'),
          ),
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
            backgroundColor: Color(0xFF1C1926),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            backgroundColor: Color(0xFF1C1926),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            backgroundColor: Color(0xFF1C1926),
            label: 'School',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.exposure),
            backgroundColor: Color(0xFF1C1926),
            label: 'Calculator',
          ),
        ],
      ),
    );
  }
}