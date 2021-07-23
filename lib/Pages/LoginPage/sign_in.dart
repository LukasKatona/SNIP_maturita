import 'package:flutter/material.dart';
import 'package:maturita/Services/auth.dart';
import 'package:passwordfield/passwordfield.dart';
import 'LoginPage.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

bool lockedCal = false;

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                onChanged: (val) {
                  setState(() {
                    email = val;
                  });
                },
                style: TextStyle(color: Colors.white),
                cursorColor: Color(0xFFFF6B00),
                decoration: InputDecoration(
                  hintText: "Email",
                  hintStyle: TextStyle(color: Color(0xFF5B5B5B)),
                  fillColor: Color(0xFF211D2D), filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Color(0xFF211D2D),
                      width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Color(0xFFFF6B00),
                      width: 2,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Color(0xFFFF6B00),
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
              ),
              SizedBox(height: 15,),
              TextFormField(
                validator: (val) => val.length < 8 ? "enter your password" : null,
                obscureText: obscure,
                onChanged: (val) {
                  setState(() {
                    password = val;
                  });
                },
                style: TextStyle(color: Colors.white),
                cursorColor: Color(0xFFFF6B00),
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(obscure ? Icons.remove_red_eye_outlined : Icons.remove_red_eye, color: obscure ? Color(0xFF5B5B5B) : Color(0xFFFF6B00)),
                    onPressed: () {
                      setState(() {
                        obscure = !obscure;
                      });
                    },
                  ),
                  hintText: "Password",
                  hintStyle: TextStyle(color: Color(0xFF5B5B5B)),
                  fillColor: Color(0xFF211D2D), filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Color(0xFF211D2D),
                      width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Color(0xFFFF6B00),
                      width: 2,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Color(0xFFFF6B00),
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
              ),
              SizedBox(height: 15,),
              ButtonTheme(
                padding: EdgeInsets.zero,
                child: FlatButton(
                  onPressed: () async {
                    if (_formKey.currentState.validate()){
                      dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                      if (result == null){
                        setState(() => error = "could not sign in");
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
                    dynamic result = await _auth.signInAnon();
                    if (result == null){
                      print("error signing IN");
                    }else{
                      print("signed in");
                      print(result.uid);
                      print("is anon: " + result.anon.toString());
                      setState(() {
                        lockedCal = true;
                      });
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