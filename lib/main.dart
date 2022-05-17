import 'package:flutter/material.dart';
import 'package:kangrooo/activities/EmptyPage.dart';
import 'package:kangrooo/activities/Login.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Welcome to Flutter', routes: {
      '/': (context) {
        const authProvider = false;
        if (authProvider) {
          return Login();
        } else {
          return Login();
        }
      },
      '/login': (context) => Login(),
    });
  }
}
