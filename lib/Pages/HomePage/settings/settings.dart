import 'package:flutter/material.dart';
import 'package:maturita/shared/design.dart';
import 'package:provider/provider.dart';
import 'package:maturita/Models/user.dart';
import 'package:maturita/Services/database.dart';
import 'package:maturita/shared/loading.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  final _formKey = GlobalKey<FormState>();

  String _currentName;
  String _currentRole;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<MyUser>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData){

          UserData userData = snapshot.data;

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
                  TextFormField(
                    initialValue: userData.name,
                    decoration: snipInputDecoration.copyWith(hintText: "change name"),
                    validator: (val) => val.isEmpty ? 'Please enter a name' : null,
                    onChanged: (val) => setState(() => _currentName = val),
                  ),
                  SizedBox(height: 20,),
                  ButtonTheme(
                    padding: EdgeInsets.zero,
                    child: FlatButton(
                      onPressed: () async {
                        print(_currentName);
                        print(_currentRole);
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
                ],
              ),
            ),
          );
        }else{
         return Loading();
        }
      }
    );
  }
}
