// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:developer';

import 'package:contact_tracer/globalVariables.dart';
import 'package:contact_tracer/screens/home.dart';
import 'package:contact_tracer/screens/login.dart';
import 'package:contact_tracer/widgets/app_button.dart';
import 'package:contact_tracer/widgets/progressDialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class RegistrationPage extends StatelessWidget {
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();

  var phoneNumberController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  void registerUser(context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.green,
        content: Text(
          "success",
          textAlign: TextAlign.center,
        ),
      ));
      log('success');
      log(userCredential.user!.uid);
      currentFirebaseUser = userCredential.user;
      DatabaseReference newUserRef = FirebaseDatabase.instance
          .ref()
          .child('users/${userCredential.user!.uid}');

      Map userMap = {
        'firstName': firstNameController.text,
        'lastName': lastNameController.text,
        'phone': phoneNumberController.text,
      };

      newUserRef.set(userMap);

      Navigator.pushNamedAndRemoveUntil(context, Home.id, (route) => false);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            'The password provided is too weak.',
            textAlign: TextAlign.center,
          ),
        ));
        print('The password provided is too weak.');
        Navigator.pop(context);
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            'The account already exists for that email.',
            textAlign: TextAlign.center,
          ),
        ));
        print(
          'The account already exists for that email.',
        );
        Navigator.pop(context);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          e.toString(),
          textAlign: TextAlign.center,
        ),
      ));
      Navigator.pop(context);
    }
  }

  static const String id = 'register';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
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
                'Create a Contact Tracer Account',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25, fontFamily: 'Brand-Bold'),
              ),
              Padding(
                padding: EdgeInsets.all(40.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: firstNameController,
                      keyboardType: TextInputType.name,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                        labelText: 'First Name',
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
                      controller: lastNameController,
                      keyboardType: TextInputType.name,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                        labelText: 'Last Name',
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
                      controller: phoneNumberController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
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
                        title: 'REGISTER',
                        color: Colors.blue,
                        onPressed: () {
                          //check network availability

                          //check if name has morethan 2 characters
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context) =>
                                  ProgressDialog('Signing you up'));
                          registerUser(context);
                        }),
                  ],
                ),
              ),
              TextButton(
                  onPressed: () => {
                        Navigator.pushNamedAndRemoveUntil(
                            context, LoginPage.id, (route) => false)
                      },
                  child: Text('Already have an account? sign in here'))
            ],
          ),
        ),
      ),
    );
  }
}
