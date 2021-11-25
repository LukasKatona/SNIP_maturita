import 'package:flutter/material.dart';
import 'package:maturita/Pages/HomePage/calculator/calculator.dart';
import 'package:maturita/shared/design.dart';
import 'input.dart';
import 'dart:math';
import 'package:draggable_scrollbar/draggable_scrollbar.dart';

class MyOutput extends StatefulWidget {
  @override
  _MyOutputState createState() => _MyOutputState();
}

class _MyOutputState extends State<MyOutput> {

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return outOfRange ? Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
              Icons.warning_rounded,
            color: MyColorTheme.PrimaryAccent,
            size: 150,
          ),
          Text("Out of range. Consider bigger network class or less hosts or subnets.", style: TextStyle(color: MyColorTheme.Text), textAlign: TextAlign.center,),
        ],
      ),
    ) : Visibility(
      visible: submitBool == true,
      child: Container(
        child: DraggableScrollbar.rrect(
          backgroundColor: MyColorTheme.PrimaryAccent,
          labelTextBuilder: (double offset) => Text("${offset ~/ 161}", style: TextStyle(color: Colors.white),),
          controller: _scrollController,
          child: ListView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.fromLTRB(0, 15, 0, 90),
            scrollDirection: Axis.vertical,
            itemCount: subnetList.length,
            itemExtent: 161,
            itemBuilder: (context, index){
              return Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
                      child: Text(
                        "#" + index.toString() + " Subnet ",
                        style: TextStyle(
                          color: MyColorTheme.GreyText,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Card(
                      elevation: 0.0,
                      color: (index == 0 && fullOrLess || index == (subnetList.length - 1) && fullOrLess) ? Colors.red : MyColorTheme.Secondary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "IP",
                                    style: TextStyle(
                                      color: MyColorTheme.GreyText,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    subnetList[index].address,
                                    style: TextStyle(
                                      color: MyColorTheme.Text,
                                      fontSize: 20,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    "First Host",
                                    style: TextStyle(
                                      color: MyColorTheme.GreyText,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    subnetList[index].firstHost,
                                    style: TextStyle(
                                      color: MyColorTheme.Text,
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Broadcast",
                                    style: TextStyle(
                                      color: MyColorTheme.GreyText,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    subnetList[index].broadcast,
                                    style: TextStyle(
                                      color: MyColorTheme.Text,
                                      fontSize: 20,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    "Last Host",
                                    style: TextStyle(
                                      color: MyColorTheme.GreyText,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    subnetList[index].lastHost,
                                    style: TextStyle(
                                      color: MyColorTheme.Text,
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}