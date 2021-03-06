import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'design.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Container(
      color: myColorTheme.Background,
      child: Center(
        child: SpinKitCircle(
          size: 50,
          color: myColorTheme.PrimaryAccent,
        ),
      ),
    );
  }
}
