import 'package:flutter/material.dart';

dynamic snipInputDecoration = InputDecoration(
  hintStyle: TextStyle(color: Color(0xFF5B5B5B)),
  fillColor: Color(0xFF211D2D),
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0),
    borderSide: BorderSide(
      color: Color(0xFF211D2D),
      width: 2,
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0),
    borderSide: BorderSide(
      color: Color(0xFFFF6B00),
      width: 2,
    ),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0),
    borderSide: BorderSide(
      color: Color(0xFFFF6B00),
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