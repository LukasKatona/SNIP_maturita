import 'package:flutter/material.dart';
import 'package:maturita/Services/auth.dart';
import 'package:maturita/shared/design.dart';
import 'LoginPage.dart';
import 'package:maturita/shared/loading.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  bool loading = false;

  String email = '';
  String password = '';
  String error = '';
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("LOG IN", style: TextStyle(color: MyColorTheme.Text, fontSize: 24),),
              SizedBox(height: 15,),
              TextFormField(
                validator: (val) => val.isEmpty ? "enter your email" : null,
                onChanged: (val) {setState(() => email = val);},
                style: TextStyle(color: MyColorTheme.Text),
                cursorColor: MyColorTheme.PrimaryAccent,
                decoration: snipInputDecoration.copyWith(hintText: "Email")
              ),
              SizedBox(height: 15,),
              TextFormField(
                obscureText: obscure,
                validator: (val) => val.length < 8 ? "enter your password" : null,
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
              ButtonTheme(
                padding: EdgeInsets.zero,
                child: FlatButton(
                  onPressed: () async {
                    if (_formKey.currentState.validate()){
                      setState(() => loading = true);
                      dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                      if (result == null){
                        setState(() {
                          error = "could not sign in";
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
                        "LOG IN",
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
                  Text("Don't have an account? ", style: TextStyle(color: MyColorTheme.Text),),
                  GestureDetector(
                      onTap: () {
                       setState(() {
                         logInPageController.animateToPage(1, duration: Duration(milliseconds: 500), curve: Curves.ease);
                       });
                      },
                      child: Text("Register", style: TextStyle(color: MyColorTheme.PrimaryAccent),)),
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
    );
  }
}