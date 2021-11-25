import 'package:flutter/material.dart';
import 'package:maturita/Pages/LoginPage/register.dart';
import 'package:maturita/Pages/LoginPage/sign_in.dart';
import 'package:maturita/shared/design.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

final PageController logInPageController = PageController(initialPage: 0, keepPage: true,);

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: MyColorTheme.Background,

      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image(image: AssetImage('assets/wave-top.png'),),
          Expanded(
            child: PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: logInPageController,
              children: [
                SignIn(),
                Register(),
              ],
            ),
          ),
          Image(image: AssetImage('assets/wave-btm.png'),)
        ],
      ),
    );
  }
}

