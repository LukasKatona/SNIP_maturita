import 'package:flutter/material.dart';
import 'package:maturita/Services/auth.dart';
import 'package:passwordfield/passwordfield.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

bool lockedCal = false;

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();

  String email = '';
  String password = '';
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFF100B1F),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image(image: AssetImage('assets/wave-top.png'),),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Container(
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
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
                      ),
                    ),
                    SizedBox(height: 15,),
                    TextFormField(
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
                      ),
                    ),
                    SizedBox(height: 15,),
                    ButtonTheme(
                      padding: EdgeInsets.zero,
                      child: FlatButton(
                          onPressed: () async {
                            print(email + password);
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
                    SizedBox(height: 15,),
                    Row(
                        children: <Widget>[
                          Expanded(
                              child: Divider(color: Colors.white,)
                          ),
                          Text("  OR  ", style: TextStyle(color: Colors.white),),
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
          ),
          Image(image: AssetImage('assets/wave-btm.png'),)
        ],
      ),
    );
  }
}