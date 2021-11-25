import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maturita/Models/sniper.dart';
import 'package:maturita/Models/variables.dart';
import 'package:maturita/Pages/HomePage/profile/profile.dart';
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
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Settings',
                  style: TextStyle(color: MyColorTheme.PrimaryAccent, fontSize: 24),
                ),
                SizedBox(height: 15,),
                Text(
                  'Name',
                  style: TextStyle(color: MyColorTheme.GreyText, fontSize: 16),
                ),
                SizedBox(height: 5,),
                TextFormField(
                  initialValue: userData.name,
                  style: TextStyle(color: MyColorTheme.Text),
                  cursorColor: MyColorTheme.PrimaryAccent,
                  decoration: snipInputDecoration.copyWith(hintText: "enter new name"),
                  validator: (val) => val.isEmpty ? 'Please enter a name' : null,
                  onChanged: (val) => setState(() => _currentName = val),
                ),
                SizedBox(height: 15,),
                Text(
                  'Group',
                  style: TextStyle(color: MyColorTheme.GreyText, fontSize: 16),
                ),
                SizedBox(height: 5,),
                new Theme(
                  data: Theme.of(context).copyWith(
                      canvasColor: MyColorTheme.Secondary,
                  ),
                  child: DropdownButtonFormField(
                    decoration: snipInputDecoration.copyWith(hintText: userData.group, hintStyle: TextStyle(color: MyColorTheme.Text),),
                    icon: Icon(Icons.menu_open, color: MyColorTheme.PrimaryAccent,),
                    iconSize: 24,
                    items: groups.map((String group) {
                      return DropdownMenuItem(
                          value: group,
                          child: Text(group, style: TextStyle(color: MyColorTheme.Text),),
                      );
                    }).toList(),
                    onChanged: (val) {
                      setState(() => _currentGroup = val);
                    },
                    value: _currentGroup,
                  ),
                ),
                SizedBox(height: 15,),
                ButtonTheme(
                  padding: EdgeInsets.zero,
                  child: FlatButton(
                    onPressed: () async {
                      await DatabaseService(uid: user.uid).updateUserData(_currentName ?? userData.name, userData.role, userData.isCalLocked, userData.fulXp, userData.lessXp, _currentGroup ?? userData.group);
                    },
                    child: Ink(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [MyColorTheme.PrimaryAccent, MyColorTheme.SecondaryAccent],
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                          ),
                          borderRadius: BorderRadius.circular(10.0)
                      ),
                      child: Container(
                        constraints: BoxConstraints(maxWidth: 350.0, minHeight: 59.0),
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
                Visibility(
                  visible: userData.role == 'admin',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Admin Panel',
                        style: TextStyle(color: MyColorTheme.PrimaryAccent, fontSize: 24),
                      ),
                      SizedBox(height: 15,),
                      Text(
                        'Teacher Key',
                        style: TextStyle(color: MyColorTheme.GreyText, fontSize: 16),
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
                          color: MyColorTheme.Secondary,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Text(variables.teacherKey, style: TextStyle(color: MyColorTheme.Text, fontSize: 16),),
                                ),
                                AnimateIcons(
                                  startIcon: Icons.file_copy_outlined,
                                  endIcon: Icons.check,
                                  startIconColor: MyColorTheme.PrimaryAccent,
                                  endIconColor: MyColorTheme.PrimaryAccent,
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
                            var animateToStart = copyController.animateToStart;
                            animateToStart();
                            await DatabaseService().updateAdminVars(DatabaseService().generatePassword(), groups);
                          },
                          child: Ink(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [MyColorTheme.PrimaryAccent, MyColorTheme.SecondaryAccent],
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.topRight,
                                ),
                                borderRadius: BorderRadius.circular(10.0)
                            ),
                            child: Container(
                              constraints: BoxConstraints(maxWidth: 350.0, minHeight: 59.0),
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
                              'Delete Group',
                              style: TextStyle(color: MyColorTheme.GreyText, fontSize: 16),
                            ),
                          ),
                          SizedBox(width: 15,),
                          Expanded(
                            child: Text(
                              'Add Group',
                              style: TextStyle(color: MyColorTheme.GreyText, fontSize: 16),
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
                                canvasColor: MyColorTheme.Secondary,
                              ),
                              child: DropdownButtonFormField(
                                decoration: snipInputDecoration.copyWith(hintText: groups[0], hintStyle: TextStyle(color: MyColorTheme.Text),),
                                icon: Icon(Icons.menu_open, color: MyColorTheme.PrimaryAccent,),
                                iconSize: 24,
                                items: groups.map((String group) {
                                  return DropdownMenuItem(
                                    value: group,
                                    child: Text(group, style: TextStyle(color: MyColorTheme.Text),),
                                  );
                                }).toList(),
                                onChanged: (val) {
                                  setState(() => _deleteGroup = val);
                                },
                                value: _deleteGroup,
                              ),
                            ),
                          ),
                          SizedBox(width: 15,),
                          Expanded(
                            child:  TextField(
                              style: TextStyle(color: MyColorTheme.Text),
                              cursorColor: MyColorTheme.PrimaryAccent,
                              decoration: snipInputDecoration.copyWith(hintText: "enter new group"),
                              onChanged: (val) {
                                setState(() {
                                  if (val.isNotEmpty){
                                    _newGroup = val;
                                  }else{
                                    _newGroup = '';
                                  }
                                });
                              }
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15,),
                      ButtonTheme(
                        padding: EdgeInsets.zero,
                        child: FlatButton(
                          onPressed: () async {
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
                                  print("SRY ale tato skupina sa pouziva");
                                }
                              }
                              if (_newGroup != ''){
                                groups.insert(groups.length, _newGroup);
                                _newGroup = '';
                              }
                              groups.sort();
                            });
                            await DatabaseService().updateAdminVars(variables.teacherKey, groups);
                          },
                          child: Ink(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [MyColorTheme.PrimaryAccent, MyColorTheme.SecondaryAccent],
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.topRight,
                                ),
                                borderRadius: BorderRadius.circular(10.0)
                            ),
                            child: Container(
                              constraints: BoxConstraints(maxWidth: 350.0, minHeight: 59.0),
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
        ),
      );
    }else{
      return Loading();
    }
  }
}


