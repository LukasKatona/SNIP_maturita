import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:maturita/shared/design.dart';
import '../../../Services/height_meter.dart';
import '../../HomePage/HomePage.dart';


class MyInput extends StatefulWidget {
  @override
  _MyInputState createState() => _MyInputState();
}

List<String> snList = [null];
List<String> multiList = [null];
bool submitBool = false;
bool fullOrLess = true;
bool spareSwitch = true;
String byte = '';

class _MyInputState extends State<MyInput> {

  // výšky jednotlivých widgetov
  var inputContainerSize = Size.zero;

  TextEditingController _IPcontroller = new TextEditingController();

  FocusNode myFocusNode = new FocusNode();

  final _formKey = GlobalKey<FormState>();
  TextEditingController _SNcountController;
  TextEditingController _multicountController;
  @override
  void initState() {
    super.initState();
    _SNcountController = TextEditingController();
    _multicountController = TextEditingController();
    myFocusNode = FocusNode();
  }
  @override
  void dispose() {
    _SNcountController.dispose();
    _multicountController.dispose();
    myFocusNode.dispose();
    super.dispose();
  }

  List<Widget> _getSN(){
    List<Widget> subnetTextFieldList = [];
    for(int i=0; i<snList.length; i++){
      subnetTextFieldList.add(
          Column(
            children: [
              Row(
                children: [
                  Expanded(flex: 1, child: SubnetTextfield(i)),
                  Expanded(
                    flex: 1,
                    child: Row(
                      children: [
                        SizedBox(width: 30, child: Icon(Icons.clear, color: myColorTheme.Text,)),
                        Expanded(flex: 1, child: MultiTextField(i)),
                        SizedBox(width: 15,),
                        _addRemoveButton(i == snList.length-1, i),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15,)
            ],
          )
      );
    }
    return subnetTextFieldList;
  }

  Widget _addRemoveButton(bool add, int index){
    return InkWell(
      onTap: (){
        if(add){
          snList.insert(snList.length, null);
          multiList.insert(multiList.length, null);
        }
        else{
          snList.removeAt(index);
          multiList.removeAt(index);
        }
        setState((){});
      },
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: (add) ? [Colors.green, Colors.greenAccent] : [Colors.red, Colors.red[400]],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          (add) ? Icons.add : Icons.remove, color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildSNList( BuildContext context, int index ){
    if (index == 0){
      return Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: TextField(
                onChanged: (value){
                  setState(() {
                    byte = value;
                  });
                },
                controller: _IPcontroller,
                keyboardType: TextInputType.number,
                style: TextStyle(color: myColorTheme.Text),
                cursorColor: myColorTheme.PrimaryAccent,
                decoration: InputDecoration(
                  hintText: "First Byte of IP Address",
                  hintStyle: TextStyle(color: myColorTheme.GreyText),
                  fillColor: myColorTheme.Secondary, filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: myColorTheme.Secondary,
                      width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: myColorTheme.PrimaryAccent,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),
            Visibility( visible: fullOrLess, child: Expanded(
              flex: 1,
              child: Row(
                children: [
                  SizedBox(width: 30, child: Icon(Icons.add, color: myColorTheme.Text,)),
                  Expanded(
                    child: FlatButton(onPressed: (){myKey.currentState.changeSpare();},
                      height: 59,
                      color: spareSwitch ? myColorTheme.SecondaryAccent : myColorTheme.Primary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(10),
                            right: Radius.circular(0),
                          )),
                      child: Text('Host', style: TextStyle(color: Colors.white, fontSize: 16),),
                    ),
                  ),
                  // ignore: deprecated_member_use
                  Expanded(
                    child: FlatButton(onPressed: (){myKey.currentState.changeSpare();},
                      height: 59,
                      color: !spareSwitch ? myColorTheme.SecondaryAccent : myColorTheme.Primary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(0),
                            right: Radius.circular(10),
                          )),
                      child: Text('SN', style: TextStyle(color: Colors.white, fontSize: 16),),
                    ),
                  ),
                ],
              ),
            ))
          ],
        ),
      );
    }else{
      return _getSN()[index-1];
    }
  }

  @override
  Widget build(BuildContext context) {

    double inputHeight;
    if (_getSN().length+1 == 2){
      inputHeight = 148;
    }
    if (_getSN().length+1 == 3){
      inputHeight = 222;
    }
    if (_getSN().length+1 >= 4){
      inputHeight = 296;
    }

    return Container(
      child: Stack(
        clipBehavior: Clip.none,
        children: [

          // INPUT fields
          Padding(
            padding: const EdgeInsets.only(top: 29),
            child: Container(
                decoration: BoxDecoration(
                  color: myColorTheme.InputBG,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(0),
                    top: Radius.circular(10),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      height: 45,
                    ),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      height: hideInputBool ? 0 : inputHeight,
                      child: Form(
                        key: _formKey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15.0),
                          child: Container(
                            constraints: BoxConstraints(minHeight: 10, maxHeight: 296),
                            child: ListView.builder(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              shrinkWrap: true,
                              itemBuilder: _buildSNList,
                              itemCount: _getSN().length+1,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
            ),
          ),

          // row of buttons CLASSFULL INPUT CPASSLESS
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: ButtonTheme(
                    padding: EdgeInsets.zero,
                    child: FlatButton(onPressed: (){myKey.currentState.changeClass();},
                      child: Ink(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: fullOrLess ? [myColorTheme.PrimaryAccent, myColorTheme.SecondaryAccent] : [myColorTheme.Primary, myColorTheme.Primary],
                              end: Alignment.bottomLeft,
                              begin: Alignment.topRight,
                            ),
                            borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(10),
                              right: Radius.circular(0),
                            )
                        ),
                        child: Container(
                          constraints: BoxConstraints(minHeight: 59.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('CLASSFUL', style: TextStyle(color: Colors.white, fontSize: 16),),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                ButtonTheme(
                  padding: EdgeInsets.zero,
                  child: FlatButton(onPressed: (){myKey.currentState.onSubmited();},
                      color: myColorTheme.PrimaryAccent,
                      height: 59,
                      minWidth: 59,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,),
                      child: Icon((!hideInputBool) ? Icons.publish_rounded : Icons.edit, color: Colors.white, size: 27.0,)),
                ),
                //color: (add) ? Colors.green : Colors.red,
                Expanded(
                  flex: 1,
                  child: ButtonTheme(
                    padding: EdgeInsets.zero,
                    child: FlatButton(onPressed: (){myKey.currentState.changeClass();},
                        color: (!fullOrLess) ? myColorTheme.SecondaryAccent : myColorTheme.Primary,
                        height: 59,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(0),
                              right: Radius.circular(10),
                            )),
                        child: Ink(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: !fullOrLess ? [myColorTheme.PrimaryAccent, myColorTheme.SecondaryAccent] : [myColorTheme.Primary, myColorTheme.Primary],
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                              ),
                              borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(0),
                                right: Radius.circular(10),
                              )
                          ),
                          child: Container(
                            constraints: BoxConstraints(minHeight: 59.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('CLASSLESS', style: TextStyle(color: Colors.white, fontSize: 16),),
                              ],
                            ),
                          ),
                        ),
                  ),
                ),
                ),
              ],
            ),
          ),

          // container over all other widgets in stack
          Positioned.fill(child: Container()),
        ],
      ),
    );
  }
}

class Subnet {
  String address;
  String firstHost;
  String lastHost;
  String broadcast;

  Subnet(this.address, this.firstHost, this.lastHost, this.broadcast);
}

List<Subnet> subnetList = [];


// SUBNET TEXT FIELD

class SubnetTextfield extends StatefulWidget {

  final int index;
  SubnetTextfield(this.index);

  @override
  _SubnetTextfieldState createState() => _SubnetTextfieldState();
}

class _SubnetTextfieldState extends State<SubnetTextfield> {

  TextEditingController _snController;
  @override
  void initState() {
    super.initState();
    _snController = TextEditingController();
  }
  @override
  void dispose() {
    _snController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _snController.text = snList[widget.index]
          ?? '';
    });

    return TextFormField(
      controller: _snController,
      onChanged: (v) => snList[widget.index] = v,
      keyboardType: TextInputType.number,
      style: TextStyle(color: myColorTheme.Text),
      cursorColor: myColorTheme.PrimaryAccent,
      decoration: InputDecoration(
        hintText: "Number of Hosts",
        hintStyle: TextStyle(color: myColorTheme.GreyText),
        fillColor: myColorTheme.Secondary, filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: myColorTheme.Secondary,
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: myColorTheme.PrimaryAccent,
            width: 2,
          ),
        ),
      ),
      validator: (v){
        if(v.trim().isEmpty) return 'Please enter something';
        return null;
      },
    );
  }
}

// Multiplier text field

class MultiTextField extends StatefulWidget {

  final int index;
  MultiTextField(this.index);

  @override
  _MultiTextFieldState createState() => _MultiTextFieldState();
}

class _MultiTextFieldState extends State<MultiTextField> {

  TextEditingController _multiController;
  @override
  void initState() {
    super.initState();
    _multiController = TextEditingController();
  }
  @override
  void dispose() {
    _multiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _multiController.text = multiList[widget.index]
          ?? '';
    });

    return TextFormField(
      controller: _multiController,
      onChanged: (v) => multiList[widget.index] = v,
      keyboardType: TextInputType.number,
      style: TextStyle(color: myColorTheme.Text),
      cursorColor: myColorTheme.PrimaryAccent,
      decoration: InputDecoration(
        hintText: "x",
        hintStyle: TextStyle(color: myColorTheme.GreyText),
        fillColor: myColorTheme.Secondary, filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: myColorTheme.Secondary,
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: myColorTheme.PrimaryAccent,
            width: 2,
          ),
        ),
      ),
      validator: (v){
        if(v.trim().isEmpty) return 'Please enter something';
        return null;
      },
    );
  }
}
