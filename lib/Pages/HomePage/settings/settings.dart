import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maturita/Models/sniper.dart';
import 'package:maturita/Models/variables.dart';
import 'package:maturita/Pages/HomePage/HomePage.dart';
import 'package:maturita/Pages/HomePage/profile/profile.dart';
import 'package:maturita/main.dart';
import 'package:maturita/shared/design.dart';
import 'package:provider/provider.dart';
import 'package:maturita/Models/user.dart';
import 'package:maturita/Services/database.dart';
import 'package:maturita/shared/loading.dart';
import 'package:flutter/services.dart';
import 'package:animate_icons/animate_icons.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> with TickerProviderStateMixin{

  final _formKey = GlobalKey<FormState>();
  AnimateIconController copyController = AnimateIconController();
  String _currentName;
  String _currentGroup;
  String _deleteGroup = 'none';
  String _newGroup = '';
  bool _deleteGroupLabel = true;

  bool confirmSaveSettings = false;
  bool confirmUpdateGroups = false;

  @override
  Widget build(BuildContext context) {

    final userData = Provider.of<UserData>(context);
    final user = Provider.of<MyUser>(context);
    final variables = Provider.of<Variables>(context);
    var snipers = Provider.of<List<Sniper>>(context);

    if (userData != null && variables != null){

      String groupString = variables.groups.join(',');
      List<String> groups = groupString.split(',');
      List<String> updateGroups = groups;

      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Settings',
                style: TextStyle(color: myColorTheme.PrimaryAccent, fontSize: 24),
              ),
              SizedBox(height: 15,),
              Text(
                'Name',
                style: TextStyle(color: myColorTheme.GreyText, fontSize: 16),
              ),
              SizedBox(height: 5,),
              TextFormField(
                initialValue: userData.name,
                style: TextStyle(color: myColorTheme.Text),
                cursorColor: myColorTheme.PrimaryAccent,
                decoration: InputDecoration(
                  hintText: "enter new name",
                  hintStyle: TextStyle(color: myColorTheme.GreyText),
                  fillColor: myColorTheme.Secondary,
                  filled: true,
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
                      color:myColorTheme.PrimaryAccent,
                      width: 2,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: myColorTheme.PrimaryAccent,
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
                ),
                validator: (val) => val.isEmpty ? 'Please enter a name' : null,
                onChanged: (val) {
                  setState(() {
                    _currentName = val;
                    confirmSaveSettings = false;
                  });
                },
              ),
              SizedBox(height: 15,),
              Text(
                'Group',
                style: TextStyle(color: myColorTheme.GreyText, fontSize: 16),
              ),
              SizedBox(height: 5,),
              new Theme(
                data: Theme.of(context).copyWith(
                    canvasColor: myColorTheme.Secondary,
                ),
                child: Container(
                  constraints: BoxConstraints(maxHeight: 59.0),
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                      hintText: userData.group,
                      hintStyle: TextStyle(color: myColorTheme.Text),
                      fillColor: myColorTheme.Secondary,
                      filled: true,
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
                          color:myColorTheme.PrimaryAccent,
                          width: 2,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: myColorTheme.PrimaryAccent,
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
                    ),
                    icon: Icon(Icons.menu_open, color: myColorTheme.PrimaryAccent,),
                    iconSize: 24,
                    items: groups.map((String group) {
                      return DropdownMenuItem(
                          value: group,
                          child: Text(group, style: TextStyle(color: myColorTheme.Text),),
                      );
                    }).toList(),
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    onChanged: (val) {
                      setState(() {
                        _currentGroup = val;
                        confirmSaveSettings = false;
                      });
                    },
                    value: _currentGroup,
                  ),
                ),
              ),
              SizedBox(height: 15,),
              ButtonTheme(
                padding: EdgeInsets.zero,
                child: FlatButton(
                  onPressed: () async {
                    FocusScope.of(context).requestFocus(FocusNode());
                    await DatabaseService(uid: user.uid).updateUserData(_currentName ?? userData.name, userData.role, userData.isCalLocked, userData.fulXp, userData.lessXp, _currentGroup ?? userData.group, DarkOrLight);
                    setState(() {
                      confirmSaveSettings = true;
                    });
                  },
                  child: Ink(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: !confirmSaveSettings ? [myColorTheme.PrimaryAccent, myColorTheme.SecondaryAccent] : [Colors.green, Colors.greenAccent],
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                        ),
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                    child: Container(
                      constraints: BoxConstraints(minHeight: 59.0),
                      alignment: Alignment.center,
                      child: Text(
                        "Save Settings",
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
              SizedBox(height: 15,),
              Text(
                'Theme',
                style: TextStyle(color: myColorTheme.GreyText, fontSize: 16),
              ),
              SizedBox(height: 5,),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: ButtonTheme(
                      padding: EdgeInsets.zero,
                      child: FlatButton(
                        onPressed: () async{
                          FocusScope.of(context).requestFocus(FocusNode());
                          await DatabaseService(uid: user.uid).updateUserData(userData.name, userData.role, userData.isCalLocked, userData.fulXp, userData.lessXp, userData.group, !userData.darkOrLight);
                          setState(() {
                            myColorTheme = new MyColorTheme();
                          });
                        },
                        child: Ink(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: userData.darkOrLight ? [myColorTheme.PrimaryAccent, myColorTheme.SecondaryAccent] : [myColorTheme.Primary, myColorTheme.Primary],
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
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
                                Text('Light', style: TextStyle(color: Colors.white, fontSize: 16),),
                                SizedBox(width: 15,),
                                Icon(Icons.light_mode, color: Colors.white),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: ButtonTheme(
                      padding: EdgeInsets.zero,
                      child: FlatButton(
                        onPressed: () async{
                          FocusScope.of(context).requestFocus(FocusNode());
                          await DatabaseService(uid: user.uid).updateUserData(userData.name, userData.role, userData.isCalLocked, userData.fulXp, userData.lessXp, userData.group, !userData.darkOrLight);
                          setState(() {
                            myColorTheme = new MyColorTheme();
                          });
                        },
                          child: Ink(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(colors: !userData.darkOrLight ? [myColorTheme.PrimaryAccent, myColorTheme.SecondaryAccent] : [myColorTheme.Primary, myColorTheme.Primary],
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
                                  Text('Dark', style: TextStyle(color: Colors.white, fontSize: 16),),
                                  SizedBox(width: 15,),
                                  Icon(Icons.dark_mode, color: Colors.white),
                                ],
                              ),
                            ),
                          ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15,),
              Visibility(
                visible: userData.role == 'admin',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Admin Panel',
                      style: TextStyle(color: myColorTheme.PrimaryAccent, fontSize: 24),
                    ),
                    SizedBox(height: 15,),
                    Text(
                      'Teacher Key',
                      style: TextStyle(color: myColorTheme.GreyText, fontSize: 16),
                    ),
                    SizedBox(height: 5,),
                    Container(
                      height: 59,
                      child: Card(
                        margin: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                        elevation: 0,
                        color: myColorTheme.Secondary,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Text(variables.teacherKey, style: TextStyle(color: myColorTheme.Text, fontSize: 16),),
                            ),
                            AnimateIcons(
                              startIcon: Icons.file_copy_outlined,
                              endIcon: Icons.check,
                              startIconColor: myColorTheme.PrimaryAccent,
                              endIconColor: myColorTheme.PrimaryAccent,
                              size: 24,
                              controller: copyController,
                              onStartIconPress: () {
                                Clipboard.setData(ClipboardData(text: variables.teacherKey));
                                return true;
                              },
                              duration: Duration(milliseconds: 300),
                              clockwise: false,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),
                    ButtonTheme(
                      padding: EdgeInsets.zero,
                      child: FlatButton(
                        onPressed: () async {
                          FocusScope.of(context).requestFocus(FocusNode());
                          var animateToStart = copyController.animateToStart;
                          animateToStart();
                          await DatabaseService().updateAdminVars(DatabaseService().generatePassword(), groups);
                        },
                        child: Ink(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [myColorTheme.PrimaryAccent, myColorTheme.SecondaryAccent],
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                              ),
                              borderRadius: BorderRadius.circular(10.0)
                          ),
                          child: Container(
                            constraints: BoxConstraints(minHeight: 59.0),
                            alignment: Alignment.center,
                            child: Text(
                              "Update Teacher Key",
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
                    SizedBox(height: 15,),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            _deleteGroupLabel ? 'Delete Group' : 'This group is in use',
                            style: TextStyle(color: _deleteGroupLabel ? myColorTheme.GreyText : Colors.red, fontSize: 16),
                          ),
                        ),
                        SizedBox(width: 15,),
                        Expanded(
                          child: Text(
                            'Add Group',
                            style: TextStyle(color: myColorTheme.GreyText, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5,),
                    Row(
                      children: [
                        Expanded(
                          child: new Theme(
                            data: Theme.of(context).copyWith(
                              canvasColor: myColorTheme.Secondary,
                            ),
                            child: Container(
                              constraints: BoxConstraints(maxHeight: 59.0),
                              child: DropdownButtonFormField(
                                decoration: InputDecoration(
                                  hintText: groups[0],
                                  hintStyle: TextStyle(color: myColorTheme.Text),
                                  fillColor: myColorTheme.Secondary,
                                  filled: true,
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
                                      color:myColorTheme.PrimaryAccent,
                                      width: 2,
                                    ),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: myColorTheme.PrimaryAccent,
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
                                ),
                                icon: Icon(Icons.menu_open, color: myColorTheme.PrimaryAccent,),
                                iconSize: 24,
                                items: groups.map((String group) {
                                  return DropdownMenuItem(
                                    value: group,
                                    child: Text(group, style: TextStyle(color: myColorTheme.Text),),
                                  );
                                }).toList(),
                                onTap: () {
                                  FocusScope.of(context).requestFocus(FocusNode());
                                  setState(() {
                                    _deleteGroupLabel = true;
                                  });
                                },
                                onChanged: (val) {
                                  setState(() {
                                    _deleteGroup = val;
                                    confirmUpdateGroups = false;
                                  });
                                },
                                value: _deleteGroup,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 15,),
                        Expanded(
                          child:  Container(
                            constraints: BoxConstraints(minHeight: 59.0),
                            child: TextField(
                                style: TextStyle(color: myColorTheme.Text),
                                cursorColor: myColorTheme.PrimaryAccent,
                                decoration: InputDecoration(
                                  hintText: "enter new group",
                                  hintStyle: TextStyle(color: myColorTheme.GreyText),
                                  fillColor: myColorTheme.Secondary,
                                  filled: true,
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
                                      color:myColorTheme.PrimaryAccent,
                                      width: 2,
                                    ),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: myColorTheme.PrimaryAccent,
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
                                ),
                                onChanged: (val) {
                                  setState(() {
                                    confirmUpdateGroups = false;
                                    if (val.isNotEmpty){
                                      _newGroup = val;
                                    }else{
                                      _newGroup = '';
                                    }
                                  });
                                }
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15,),
                    ButtonTheme(
                      padding: EdgeInsets.zero,
                      child: FlatButton(
                        onPressed: () async {
                          FocusScope.of(context).requestFocus(FocusNode());
                          setState(() {
                            if (_deleteGroup != 'none'){
                              bool delete = true;
                              for (int i = 0; i < snipers.length; i++){
                                if (snipers[i].group == _deleteGroup){
                                  delete = false;
                                }
                              }
                              if (delete){
                                String temp = _deleteGroup;
                                _deleteGroup = 'none';
                                groups.removeWhere((element) => element == temp);
                              }else{
                                _deleteGroupLabel = false;
                              }
                            }
                            if (_newGroup != ''){
                              groups.insert(groups.length, _newGroup);
                              _newGroup = '';
                            }
                            groups.sort();
                            confirmUpdateGroups = true;
                          });
                          await DatabaseService().updateAdminVars(variables.teacherKey, groups);
                        },
                        child: Ink(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: !confirmUpdateGroups ? [myColorTheme.PrimaryAccent, myColorTheme.SecondaryAccent] : [Colors.green, Colors.greenAccent],
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                              ),
                              borderRadius: BorderRadius.circular(10.0)
                          ),
                          child: Container(
                            constraints: BoxConstraints(minHeight: 59.0),
                            alignment: Alignment.center,
                            child: Text(
                              "Update Groups",
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
                    SizedBox(height: 15,),
                  ],
                ),
              ),
              SignOutButton(),
            ],
          ),
        ),
      );
    }else{
      return Loading();
    }
  }
}


