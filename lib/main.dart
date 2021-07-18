import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:maturita/Wrapper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
    );
  }
}