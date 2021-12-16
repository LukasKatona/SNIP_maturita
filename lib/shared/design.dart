import 'package:flutter/material.dart';
import 'package:maturita/Pages/HomePage/settings/settings.dart';

bool DarkOrLight = false;

class MyColorTheme {
  //light orange
  var PrimaryAccent;
  var SecondaryAccent;
  var Primary;
  var Secondary;
  var Text;
  var GreyText;
  var Background;
  var InputBG;
  var NavBar;

  MyColorTheme() {
    if (DarkOrLight){
      PrimaryAccent = Color(0xFFFF6B00);
      SecondaryAccent = Color(0xFFFF8A00);
      Primary = Color(0xFFD2CAB9);
      Secondary = Color(0xFFF8F0DF);
      Text = Color(0xFF000000);
      GreyText = Color(0xFFBBBBBB);
      Background = Color(0xFFFEFBF3);
      InputBG = Color(0xFFE9E1D3);
      NavBar = Color(0xFFD2CAB9);
    }else if (!DarkOrLight){
      PrimaryAccent = Color(0xFFFF6B00);
      SecondaryAccent = Color(0xFFFF8A00);
      Primary = Color(0xFF1C1926);
      Secondary = Color(0xFF211D2D);
      Text = Color(0xFFFFFFFF);
      GreyText = Color(0xFF5B5B5B);
      Background = Color(0xFF100B1F);
      InputBG = Color(0xFF2B273C);
      NavBar = Color(0xFF1C1926);
    }else if (DarkOrLight == null){
      PrimaryAccent = Color(0xFFFF6B00);
      SecondaryAccent = Color(0xFFFF8A00);
      Primary = Color(0xFFD2CAB9);
      Secondary = Color(0xFFF8F0DF);
      Text = Color(0xFF000000);
      GreyText = Color(0xFFBBBBBB);
      Background = Color(0xFFFEFBF3);
      InputBG = Color(0xFFE9E1D3);
      NavBar = Color(0xFFD2CAB9);
    }
  }
}

MyColorTheme myColorTheme;

class ConfirmButtonDecor extends StatefulWidget {

  final bool greenConfirm;

  ConfirmButtonDecor({ this.greenConfirm });

  @override
  _ConfirmButtonDecorState createState() => _ConfirmButtonDecorState();
}

class _ConfirmButtonDecorState extends State<ConfirmButtonDecor> {
  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: !widget.greenConfirm ? [Color(0xFFFF6B00), Color(0xFFFF8A00)] : [Colors.green, Colors.greenAccent],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
          borderRadius: BorderRadius.circular(10.0)
      ),
      child: Container(
        constraints: BoxConstraints(minHeight: 59.0),
        alignment: Alignment.center,
        child: Text(
          widget.greenConfirm ? "Correct" : "Confirm",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white,
              fontSize: 16
          ),
        ),
      ),
    );
  }
}

class MyBackButton extends StatefulWidget {
  @override
  _MyBackButtonState createState() => _MyBackButtonState();
}

class _MyBackButtonState extends State<MyBackButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: 59.0, minWidth: 59.0, maxWidth: 59.0),
      child: ButtonTheme(
        padding: EdgeInsets.zero,
        child: FlatButton(
          onPressed: () {
            setState(() {
              Navigator.pop(context);
            });
          },
          child: Ink(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors:  [Color(0xFFFF6B00), Color(0xFFFF8A00)],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                ),
                borderRadius: BorderRadius.circular(10.0)
            ),
            child: Container(
              constraints: BoxConstraints(minHeight: 59.0, minWidth: 59.0, maxWidth: 59.0),
              alignment: Alignment.center,
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

