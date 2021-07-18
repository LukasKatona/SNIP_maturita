import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:maturita/Pages/HomePage/calculator/lockedOverlay.dart';
import 'package:maturita/Pages/LoginPage/sign_in.dart';
import 'output.dart';
import 'input.dart';
import 'dart:math';
import '../../HomePage/HomePage.dart';

class CalculatorPage extends StatefulWidget {
  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        children: [
          MyOutput(),
          Visibility(
            visible: hideInputBool == false,
            child: GestureDetector(
              onTap: (){myKey.currentState.hideInput();},
              child: Container(
                color: Color(0x55000000),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyInput(),
              ],
            ),
          ),
          LockedCal(),
        ],
      ),
    );
  }
}

void calculateIP(){
  subnetList.clear();
  var intByte = int.parse(byte);
  String address;
  String firstHost;
  String lastHost;
  String broadcast;
  int ipTemp = 0;
  int bcTemp = 0;

  int power2round(int num){
    int j = 0;
    int _break = 0;
    while (_break == 0) {
      if (num + 1 < pow(2, j)) {
        num = (pow(2, j));
        _break = 1;
      }
      j++;
    }
    return num;
  }

  int DecToBin(input) {
    int bin = 0, i = 1;
    while (input > 0) {
      bin = bin + (input % 2)*i;
      input = (input/2).floor();
      i = i * 10;
    }
    return bin;
  }

  if (fullOrLess){

    int maxHost = 0;
    for (int i = 0; i < snList.length; i++){
      if (maxHost < int.parse(snList[i])){
        maxHost =  int.parse(snList[i]);
      }
    }

    int maxSN = 0;
    for (int i = 0; i < multiList.length; i++){
      maxSN = maxSN + int.parse(multiList[i]);
    }

    int binRooms = DecToBin(maxSN+1);
    int binHost = DecToBin(maxHost+1);

    int bitSN = 0;
    int bitHost = 0;

    int usableSN = 0;
    int usableHost = 0;
    int slashFormat = 0;

    if (intByte < 224 && intByte > 191){

      if (spareSwitch){
        bitSN = binRooms.toString().length;
        bitHost = 8 - bitSN;
      }else {
        bitHost = binHost.toString().length;
        bitSN = 8 - bitHost;
      }
      slashFormat = 24 + bitSN;

    }

    if (intByte < 192 && intByte > 127){

      if (spareSwitch){
        bitSN = binRooms.toString().length;
        bitHost = 16 - bitSN;
      }else {
        bitHost = binHost.toString().length;
        bitSN = 16 - bitHost;
      }
      slashFormat = 16 + bitSN;

    }

    if (intByte < 127 && intByte > 0){

      if (spareSwitch){
        bitSN = binRooms.toString().length;
        bitHost = 24 - bitSN;
      }else {
        bitHost = binHost.toString().length;
        bitSN = 24 - bitHost;
      }
      slashFormat = 8 + bitSN;

    }

    maxSN = pow(2, bitSN);
    usableSN = maxSN - 2;
    maxHost = pow(2, bitHost);
    usableHost = maxHost - 2;

    for (int i = 0; i < maxSN; i++){
      String address = intByte.toString() + "." + ((i*maxHost)/65536).floor().toString() + "." + ((i*maxHost)%65536/256).floor().toString() + "." + ((i*maxHost)%65536%256).toString();
      String firstHost = intByte.toString() + "." + (((i*maxHost)+1)/65536).floor().toString() + "." + (((i*maxHost)+1)%65536/256).floor().toString() + "." + (((i*maxHost)+1)%65536%256).toString();
      String lastHost = intByte.toString() + "." + ((((i+1)*maxHost)-2)/65536).floor().toString() + "." + ((((i+1)*maxHost)-2)%65536/256).floor().toString() + "." + ((((i+1)*maxHost)-2)%65536%256).toString();
      String broadcast = intByte.toString() + "." + ((((i+1)*maxHost)-1)/65536).floor().toString() + "." + ((((i+1)*maxHost)-1)%65536/256).floor().toString() + "." + ((((i+1)*maxHost)-1)%65536%256).toString();

      subnetList.add(Subnet(address, firstHost, lastHost, broadcast));
    }

  }

  if (fullOrLess == false){

    // BubbleSort
    for (int i = 0; i < snList.length; i++){
      for (int j = 0; j < snList.length-i-1; j++){
        if (int.parse(snList[j]) < int.parse(snList[j+1])){
          String temp = snList[j];
          snList[j] = snList[j+1];
          snList[j+1] = temp;

          String temp2 = multiList[j];
          multiList[j] = multiList[j+1];
          multiList[j+1] = temp2;
        }
      }
    }

    for (int i = 0; i < snList.length; i++){

      for (int j = 0; j < int.parse(multiList[i]); j++){

        bcTemp=bcTemp+power2round(int.parse(snList[i]));

        address = intByte.toString() + "." + ((bcTemp-power2round(int.parse(snList[i])))/65536).floor().toString() + "." + ((bcTemp-power2round(int.parse(snList[i])))%65536/256).floor().toString() + "." + ((bcTemp-power2round(int.parse(snList[i])))%65536%256).toString();
        firstHost = intByte.toString() + "." + ((bcTemp-power2round(int.parse(snList[i]))+1)/65536).floor().toString() + "." + ((bcTemp-power2round(int.parse(snList[i]))+1)%65536/256).floor().toString() + "." + ((bcTemp-power2round(int.parse(snList[i]))+1)%65536%256).toString();
        lastHost = intByte.toString() + "." + ((bcTemp-2)/65536).floor().toString() + "." + ((bcTemp-2)%65536/256).floor().toString() + "." + ((bcTemp-2)%65536%256).toString();
        broadcast = intByte.toString() + "." + ((bcTemp-1)/65536).floor().toString() + "." + ((bcTemp-1)%65536/256).floor().toString() + "." + ((bcTemp-1)%65536%256).toString();

        subnetList.add(Subnet(address, firstHost, lastHost, broadcast));
      }

    }

  }
}
