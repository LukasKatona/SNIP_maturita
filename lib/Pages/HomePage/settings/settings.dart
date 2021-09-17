import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maturita/Models/variables.dart';
import 'package:maturita/Pages/HomePage/profile/profile.dart';
import 'package:maturita/shared/design.dart';
import 'package:provider/provider.dart';
import 'package:maturita/Models/user.dart';
import 'package:maturita/Services/database.dart';
import 'package:maturita/shared/loading.dart';
import 'package:flutter/services.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  final _formKey = GlobalKey<FormState>();

  String _currentName;

  @override
  Widget build(BuildContext context) {

    final userData = Provider.of<UserData>(context);
    final user = Provider.of<MyUser>(context);
    final variables = Provider.of<Variables>(context);

    if (userData != null && variables != null){
      return Center(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 100,),
              Text(
                'Change your name:',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  initialValue: userData.name,
                  style: TextStyle(color: Colors.white),
                  cursorColor: Color(0xFFFF6B00),
                  decoration: snipInputDecoration.copyWith(hintText: "enter new name"),
                  validator: (val) => val.isEmpty ? 'Please enter a name' : null,
                  onChanged: (val) => setState(() => _currentName = val),
                ),
              ),
              SizedBox(height: 20,),
              ButtonTheme(
                padding: EdgeInsets.zero,
                child: FlatButton(
                  onPressed: () async {
                    if(_formKey.currentState.validate()) {
                      await DatabaseService(uid: user.uid).updateUserData(_currentName ?? userData.name, userData.role, userData.anon);
                    }
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
                        "Update",
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
              SizedBox(height: 20,),
              Visibility(
                visible: userData.role == 'admin',
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(variables.teacherKey, style: TextStyle(color: Colors.white),),
                              FlatButton(
                                minWidth: 59,
                                height: 59,
                                onPressed: (){
                                  Clipboard.setData(ClipboardData(text: variables.teacherKey));
                                },
                                child: Icon(
                                  Icons.copy,
                                  size: 40,
                                  color: MyColorTheme.PrimaryAccent,
                                ),
                              ),
                            ],
                          ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    ButtonTheme(
                      padding: EdgeInsets.zero,
                      child: FlatButton(
                        onPressed: () async {
                          await DatabaseService().updateTeacherKey();
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
                    SizedBox(height: 20,),
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
