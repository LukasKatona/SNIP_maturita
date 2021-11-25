import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:maturita/Models/sniper.dart';
import 'package:maturita/Models/user.dart';
import 'package:maturita/Pages/HomePage/profile/profile.dart';
import 'package:maturita/Pages/HomePage/school/school.dart';
import 'package:maturita/Pages/HomePage/settings/settings.dart';
import 'package:maturita/shared/loading.dart';
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
bool isOnline = false;

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
    InternetConnectionChecker().onStatusChange.listen((event) {
      final internetStatus = event == InternetConnectionStatus.connected;
      setState(() {
        isOnline = internetStatus;
      });
    });
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

    final userData = Provider.of<UserData>(context);

    if(!isOnline){
      setState(() {
        bottomSelectedIndex = 1;
      });
    }

    if (userData != null) {
      if (userData.role != 'deleted'){
        return !isOnline ? Scaffold(
          backgroundColor: MyColorTheme.Background,
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.wifi_off_sharp,
                  color: MyColorTheme.PrimaryAccent,
                  size: 150,
                ),
                Text("You are offline, to continue, please check your internet connection.", style: TextStyle(color: MyColorTheme.Text), textAlign: TextAlign.center,),
              ],
            ),
          ),
        ) : StreamProvider<List<Sniper>>.value(
          value: DatabaseService().snipers,
          child: Scaffold(
            backgroundColor: MyColorTheme.Background,

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
              showSelectedLabels: false,
              showUnselectedLabels: false,
              selectedItemColor: MyColorTheme.PrimaryAccent,
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
      }else{
        return Scaffold(
          backgroundColor: MyColorTheme.Background,
          body: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.block,
                  color: MyColorTheme.PrimaryAccent,
                  size: 200,
                ),
                Text("Your account ${userData.name} has been deleted.\nIf you want more information or recover your account, please contact the administrator.",
                  style: TextStyle(color: Colors.white), textAlign: TextAlign.center,),
                SizedBox(height: 15,),
                SignOutButton(),
              ],
            ),
          ),
        );
      }
    }else{
      return Loading();
    }
  }
}