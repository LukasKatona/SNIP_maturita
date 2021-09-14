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
              Text("LOG IN", style: TextStyle(color: Colors.white, fontSize: 24),),
              SizedBox(height: 15,),
              TextFormField(
                validator: (val) => val.isEmpty ? "enter your email" : null,
                onChanged: (val) {setState(() => email = val);},
                style: TextStyle(color: Colors.white),
                cursorColor: Color(0xFFFF6B00),
                decoration: snipInputDecoration.copyWith(hintText: "Email")
              ),
              SizedBox(height: 15,),
              TextFormField(
                obscureText: obscure,
                validator: (val) => val.length < 8 ? "enter your password" : null,
                onChanged: (val) {setState(() => password = val);},
                style: TextStyle(color: Colors.white),
                cursorColor: Color(0xFFFF6B00),
                decoration: snipInputDecoration.copyWith(
                  hintText: "Paswword",
                  suffixIcon: IconButton(
                    icon: Icon(obscure ? Icons.remove_red_eye_outlined : Icons.remove_red_eye, color: obscure ? Color(0xFF5B5B5B) : Color(0xFFFF6B00)),
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
                  Text("Don't have an account? ", style: TextStyle(color: Colors.white),),
                  GestureDetector(
                      onTap: () {
                       setState(() {
                         logInPageController.animateToPage(1, duration: Duration(milliseconds: 500), curve: Curves.ease);
                       });
                      },
                      child: Text("Register", style: TextStyle(color: Color(0xFFFF6B00)),)),
                ],
              ),
              Visibility(
                visible: error != '',
                child: Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(error, style: TextStyle(color: Colors.red), textAlign: TextAlign.center,),
                ),
              ),
              SizedBox(height: 15,),
              Row(
                  children: <Widget>[
                    Expanded(
                        child: Divider(color: Colors.white,)
                    ),
                    Text("  OR  ", style: TextStyle(color: Colors.white, fontSize: 16),),
                    Expanded(
                        child: Divider(color: Colors.white,)
                    ),
                  ]
              ),
              SizedBox(height: 15,),
              ButtonTheme(
                padding: EdgeInsets.zero,
                child: FlatButton(
                  onPressed: () async{
                    setState(() => loading = true);
                    dynamic result = await _auth.signInAnon();
                    if (result == null){
                      setState(() {
                        error = "something went wrong";
                        loading = false;
                      });
                    }else setState(() => lockedCal = true);
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
                        "CONTINUE AS GUEST",
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
                "Note: By logging in as a guest, some content of this app will not be available, due to security reasons.",
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}