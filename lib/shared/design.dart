import 'package:flutter/material.dart';

dynamic snipInputDecoration = InputDecoration(
  hintStyle: TextStyle(color: MyColorTheme.GreyText),
  fillColor: MyColorTheme.Secondary,
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0),
    borderSide: BorderSide(
      color: MyColorTheme.Secondary,
      width: 2,
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0),
    borderSide: BorderSide(
      color:MyColorTheme.PrimaryAccent,
      width: 2,
    ),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0),
    borderSide: BorderSide(
      color: MyColorTheme.PrimaryAccent,
      width: 2,
    ),
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0),
    borderSide: BorderSide(
      color: Colors.red,
      width: 2,
    ),
  ),
);

class MyColorTheme {
  static const PrimaryAccent =  Color(0xFFFF6B00);
  static const SecondaryAccent =  Color(0xFFFF8A00);

  static const Primary =  Color(0xFF1C1926);
  static const Secondary =  Color(0xFF211D2D);
  static const Tertiary =  Color(0xFF363243);

  static const Text = Color(0xFFFFFFFF);
  static const GreyText =  Color(0xFF5B5B5B);

  static const Background =  Color(0xFF100B1F);
  static const NavBar =  Color(0xFF1C1926);
}

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
          "Confirm",
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
