import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:maturita/Models/user.dart';
import 'package:maturita/Models/variables.dart';
import 'package:maturita/Pages/HomePage/settings/settings.dart';
import 'package:maturita/Services/auth.dart';
import 'package:maturita/Wrapper.dart';
import 'package:maturita/shared/design.dart';
import 'package:provider/provider.dart';
import 'package:maturita/Services/database.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(RestartWidget(child: MyApp()));
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {

    myColorTheme = new MyColorTheme();

    return StreamProvider<Variables>.value(
      value: DatabaseService().variables,
      child: StreamProvider<MyUser>.value(
        value: AuthService().user,
        child: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) { currentFocus.focusedChild.unfocus(); }
          },
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: FutureBuilder(
              future: _fbApp,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  print ('You have an error! ${snapshot.error.toString()}');
                } else if (snapshot.hasData) {
                  return Wrapper();
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            )
          ),
        ),
      ),
    );
  }
}

class RestartWidget extends StatefulWidget {
  RestartWidget({this.child});

  final Widget child;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>().restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}