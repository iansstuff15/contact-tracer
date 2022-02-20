// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:developer';

import 'package:contact_tracer/datamodels/current_user_data.dart';
import 'package:contact_tracer/globalVariables.dart';
import 'package:contact_tracer/screens/home.dart';
import 'package:contact_tracer/screens/register.dart';
import 'package:contact_tracer/widgets/app_button.dart';
import 'package:contact_tracer/widgets/progressDialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
// import 'package:tric_app_driver/brand_colors.dart';

// import 'package:tric_app_driver/registration_page.dart';
// import 'package:tric_app_driver/screens/mainPage.dart';
// import 'package:tric_app_driver/widgets/app_button.dart';
// import 'package:tric_app_driver/widgets/progressDialog.dart';

class LoginPage extends StatelessWidget {
  static const String id = 'login';

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  void loginUser(context) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.green,
        content: Text(
          'success',
          textAlign: TextAlign.center,
        ),
      ));
      currentFirebaseUser = userCredential.user;
      Navigator.pushNamedAndRemoveUntil(context, Home.id, (route) => false);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            'No user found for that email.',
            textAlign: TextAlign.center,
          ),
        ));
        Navigator.pop(context);
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            'Wrong password provided for that user.',
            textAlign: TextAlign.center,
          ),
        ));
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 70,
              ),
              // ClipRRect(
              //   borderRadius: BorderRadius.circular(20),
              //   child: Image(
              //     alignment: Alignment.center,
              //     height: 100.0,
              //     width: 100.0,
              //     image: AssetImage('assets/images/logo.png'),
              //   ),
              // ),
              SizedBox(
                height: 40,
              ),
              Text(
                'Sign in',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25, fontFamily: 'Brand-Bold'),
              ),
              Padding(
                padding: EdgeInsets.all(40.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email Address',
                        labelStyle: TextStyle(
                          fontSize: 14.0,
                        ),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0,
                        ),
                      ),
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(
                          fontSize: 14.0,
                        ),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0,
                        ),
                      ),
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    AppButton(
                        title: 'LOGIN',
                        color: Colors.blue,
                        onPressed: () async {
                          if (!emailController.text.contains('@')) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.red,
                              content: Text('enter correct email address'),
                            ));
                          } else {
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (BuildContext context) =>
                                    ProgressDialog('Loggin you in'));
                            loginUser(context);
                          }
                        }),
                  ],
                ),
              ),
              TextButton(
                  onPressed: () => {
                        Navigator.pushNamedAndRemoveUntil(
                            context, RegistrationPage.id, (route) => false)
                      },
                  child: Text('Don\'t have an account? sign up here'))
            ],
          ),
        ),
      ),
    );
  }
}
