import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:maturita/shared/design.dart';

class SchoolCard extends StatefulWidget {

  final String name;
  final String desc;
  final String rank;
  final int currentXp;
  SchoolCard({ this.name, this.desc, this.rank, this.currentXp});

  @override
  _SchoolCardState createState() => _SchoolCardState();
}

class _SchoolCardState extends State<SchoolCard> {

  int maxXp = 1000;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(widget.name, style: TextStyle(color: MyColorTheme.PrimaryAccent, fontSize: 24, fontWeight: FontWeight.bold),),
            Text(widget.desc, style: TextStyle(color: MyColorTheme.Text), textAlign: TextAlign.center),
            SizedBox(height: 15,),
            Text('Your Progress: ${widget.rank}', style: TextStyle(color: MyColorTheme.PrimaryAccent, fontSize: 16, fontWeight: FontWeight.bold),),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(maxXp.toString(), style: TextStyle(color: MyColorTheme.Text)),
              ],
            ),
            SizedBox(height: 5,),
            Row(
              children: [
                Expanded(flex: widget.currentXp, child: Container(height: 5, color: MyColorTheme.PrimaryAccent,)),
                Expanded(flex: maxXp-widget.currentXp, child: Container(height: 5, color: MyColorTheme.GreyText,)),
              ],
            ),
            SizedBox(height: 5,),
            Row(
              children: [
                Expanded(flex: widget.currentXp, child: Text(widget.currentXp.toString(), style: TextStyle(color: MyColorTheme.Text), textAlign: TextAlign.end)),
                Expanded(flex: maxXp-widget.currentXp, child: Container()),
              ],
            ),
            SizedBox(height: 20,),
            ButtonTheme(
              padding: EdgeInsets.zero,
              child: FlatButton(
                onPressed: () {

                },
                child: Ink(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [Color(0xFFFF6B00), Color(0xFFFF8A00)],
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                      ),
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: Container(
                    constraints: BoxConstraints(maxWidth: 350.0, minHeight: 59.0),
                    alignment: Alignment.center,
                    child: Text(
                      "Practise",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
      ),
      elevation: 0,
      color: MyColorTheme.Secondary,
    );
  }
}
