import 'package:flutter/material.dart';
import 'package:maturita/Services/auth.dart';
import 'package:maturita/Services/database.dart';
import 'package:maturita/shared/design.dart';
import 'LoginPage.dart';
import 'package:maturita/shared/loading.dart';
import 'package:provider/provider.dart';
import 'package:maturita/Models/variables.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

bool lockedCal = false;

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  bool loading = false;

  String email = '';
  String name = '';
  String group = 'none';
  String password = '';
  String error = '';
  String teacherKey = '';
  bool teacherReg = false;
  bool obscure = true;

  Color getColor(Set<MaterialState> states) {
    return MyColorTheme.PrimaryAccent;
  }

  @override
  Widget build(BuildContext context) {

    final variables = Provider.of<Variables>(context);

    if (variables  != null){
      String groupString = variables.groups.join(',');
      List<String> groups = groupString.split(',');
      return loading ? Loading() : Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: SingleChildScrollView(
          child: Container(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("REGISTER", style: TextStyle(color: MyColorTheme.Text, fontSize: 24),),
                  SizedBox(height: 15,),
                  TextFormField(
                    validator: (val) => val.isEmpty ? "enter a valid email" : null,
                    onChanged: (val) {setState(() => email = val);},
                    style: TextStyle(color: MyColorTheme.Text),
                    cursorColor: MyColorTheme.PrimaryAccent,
                    decoration: snipInputDecoration.copyWith(hintText: "Email"),
                  ),
                  SizedBox(height: 15,),
                  TextFormField(
                    validator: (val) => val.isEmpty ? "enter your name" : null,
                    onChanged: (val) {setState(() => name = val);},
                    style: TextStyle(color: MyColorTheme.Text),
                    cursorColor: MyColorTheme.PrimaryAccent,
                    decoration: snipInputDecoration.copyWith(hintText: "Name"),
                  ),
                  SizedBox(height: 15,),
                  new Theme(
                    data: Theme.of(context).copyWith(
                      canvasColor: MyColorTheme.Secondary,
                    ),
                    child: DropdownButtonFormField(
                      decoration: snipInputDecoration.copyWith(hintText: "enter your class", hintStyle: TextStyle(color: MyColorTheme.GreyText),),
                      icon: Icon(Icons.menu_open, color: MyColorTheme.PrimaryAccent,),
                      items: groups.map((String group) {
                        return DropdownMenuItem(
                          value: group,
                          child: SizedBox(width: 100, child: Text(group, style: TextStyle(color: MyColorTheme.Text),)),
                        );
                      }).toList(),
                      onChanged: (val) {
                        setState(() => group = val);
                      },
                    value: group,
                    ),
                  ),
                  SizedBox(height: 15,),
                  TextFormField(
                    obscureText: obscure,
                    validator: (val) => val.length < 8 ? "enter a password with 8+ characters" : null,
                    onChanged: (val) {setState(() => password = val);},
                    style: TextStyle(color: MyColorTheme.Text),
                    cursorColor: MyColorTheme.PrimaryAccent,
                    decoration: snipInputDecoration.copyWith(
                      hintText: "Password",
                      suffixIcon: IconButton(
                        icon: Icon(obscure ? Icons.remove_red_eye_outlined : Icons.remove_red_eye, color: obscure ? MyColorTheme.GreyText : MyColorTheme.PrimaryAccent),
                        onPressed: () {setState(() => obscure = !obscure);},
                      ),
                    ),
                  ),
                  SizedBox(height: 15,),
                  Row(
                    children: [
                      SizedBox(
                        height: 59,
                        child: Checkbox(
                          value: teacherReg,
                          onChanged: (val) {setState(() => teacherReg = !teacherReg);},
                          activeColor: MyColorTheme.PrimaryAccent,
                          fillColor: MaterialStateProperty.resolveWith(getColor),
                        ),
                      ),
                      Visibility(
                        visible: teacherReg == true,
                        replacement: Text(
                          'Register as teacher.',
                          style: TextStyle(color: MyColorTheme.Text),
                        ),
                        child: Expanded(
                          child: TextFormField(
                            validator: (val) => val != variables.teacherKey ? "enter a valid teacher key" : null,
                            onChanged: (val) {setState(() => teacherKey = val);},
                            style: TextStyle(color: MyColorTheme.Text),
                            cursorColor: MyColorTheme.PrimaryAccent,
                            decoration: snipInputDecoration.copyWith(hintText: "Teacher Key"),
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
                        if (_formKey.currentState.validate()){
                          setState(() => loading = true);
                          dynamic result = await _auth.registerWithEmailAndPassword(email, password, teacherKey, name, variables.teacherKey, group);
                          if (teacherKey == variables.teacherKey){
                            await DatabaseService().updateAdminVars(DatabaseService().generatePassword(), groups);
                          }
                          if (result == null){
                            setState(() {
                              error = "please supply a valid email";
                              loading = false;
                            });
                          }
                        }
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
                            "REGISTER",
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
                  SizedBox(height: 5,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account? ", style: TextStyle(color: MyColorTheme.Text),),
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              logInPageController.animateToPage(0, duration: Duration(milliseconds: 500), curve: Curves.ease);
                            });
                          },
                          child: Text("Log in", style: TextStyle(color: MyColorTheme.PrimaryAccent),)),
                    ],
                  ),
                  Visibility(
                    visible: error != '',
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(error, style: TextStyle(color: Colors.red), textAlign: TextAlign.center,),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }else{
      return Loading();
    }
  }
}