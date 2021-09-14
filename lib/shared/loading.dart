import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF100B1F),
      child: Center(
        child: SpinKitThreeBounce(
          size: 50,
          color: Color(0xFFFF6B00),
        ),
      ),
    );
  }
}
