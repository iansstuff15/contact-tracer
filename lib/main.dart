// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:contact_tracer/globalVariables.dart';
import 'package:contact_tracer/screens/home.dart';
import 'package:contact_tracer/screens/login.dart';
import 'package:contact_tracer/screens/register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Change to false to use live database instance.
const USE_DATABASE_EMULATOR = false;
// The port we've set the Firebase Database emulator to run on via the
// `firebase.json` configuration file.
const emulatorPort = 9000;
// Android device emulators consider localhost of the host machine as 10.0.2.2
// so let's use that if running on Android.
final emulatorHost =
    (!kIsWeb && defaultTargetPlatform == TargetPlatform.android)
        ? '10.0.2.2'
        : 'localhost';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: 'AIzaSyDqKzdg3EMx3y-0c8vWZzM4APwF3vLu5sw',
      appId: "1:89856961927:android:bf3d967bec88995031f722",
      messagingSenderId: "89856961927",
      projectId: "contacttracer-4eec0.appspot.com",
      databaseURL: "https://contacttracer-4eec0-default-rtdb.firebaseio.com/",
    ),
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      initialRoute: LoginPage.id,
      routes: {
        Home.id: (context) => Home(),
        LoginPage.id: (context) => LoginPage(),
        RegistrationPage.id: (context) => RegistrationPage(),
      },
    );
  }
}
