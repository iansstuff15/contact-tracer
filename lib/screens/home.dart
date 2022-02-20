// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:contact_tracer/datamodels/current_user_data.dart';
import 'package:contact_tracer/globalVariables.dart';
import 'package:contact_tracer/helpers/helpermethods.dart';
import 'package:contact_tracer/widgets/app_button.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart' hide Key;

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:encrypt/encrypt.dart';

class Home extends StatefulWidget {
  static String id = 'home';

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Completer<GoogleMapController> _controller = Completer();
  double mapBottomPadding = 0;
  static final CameraPosition _kGooglePlex = const CameraPosition(
    target: const LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  late GoogleMapController mapController;
  late Position currentPosition;
  DateTime now = new DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
              child: Stack(
        children: <Widget>[
          GoogleMap(
            padding: EdgeInsets.only(bottom: mapBottomPadding, top: 30),
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            initialCameraPosition: _kGooglePlex,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
              mapController = controller;
              log('on map create');
              setState(() {});

              setupPositionLocator();
            },
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26,
                        blurRadius: 5.0,
                        spreadRadius: 0.5,
                        offset: Offset(0.7, 0.7))
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Welcome ' + currentFirebaseUser!.email.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  AppButton(
                      title: 'Contact Trace',
                      color: Colors.blue,
                      onPressed: () {
                        contactTraceLocation();

                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.green,
                          content: Text(
                            'success location contact traced',
                            textAlign: TextAlign.center,
                          ),
                        ));
                      })
                ],
              ),
            ),
          )
        ],
      ))),
    );
  }

  void setupPositionLocator() async {
    log('in setup position method');
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    log(await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.bestForNavigation)
        .toString());
    currentPosition = position;
    log(position.toString());
    log(currentPosition.toString());
    LatLng pos = LatLng(position.latitude, position.longitude);
    log(position.latitude.toString());
    log(position.longitude.toString());
    CameraPosition cp = new CameraPosition(target: pos, zoom: 14);
    mapController.animateCamera(CameraUpdate.newCameraPosition(cp));
    String address =
        await HelperMethods.findCoordinateAddress(position, context);
  }

  void contactTraceLocation() {
    DatabaseReference contactRef = FirebaseDatabase.instance.ref().child(
        'users/${currentFirebaseUser!.uid}/contact_traced_locations/${"${DateTime.now().day}" + "_" + "${DateTime.now().month}" + "_" + "${DateTime.now().year}" + "_" + "${DateTime.now().hour}" + "_" + "${DateTime.now().minute}" + "_" + "${DateTime.now().second}"}');
    log(now.toString());
    log(currentPosition.latitude.toString());
    log(currentPosition.longitude.toString());
    String latEncrypted = encrypt(currentPosition.latitude.toString());
    String longEncrypted = encrypt(currentPosition.longitude.toString());
    String whenEncrypted = encrypt(now.toString());
    log(whenEncrypted);
    log(latEncrypted);
    log(longEncrypted);
    Map<String, String> contactRefMap = {
      'latitude': latEncrypted,
      'longitude': longEncrypted,
      'when': whenEncrypted,
    };
    contactRef.set(contactRefMap);
  }

  String encrypt(String text) {
    final key = Key.fromUtf8('my32lengthsupersecretnooneknows1');

    final b64key = Key.fromBase64(base64Url.encode(key.bytes));
    // if you need to use the ttl feature, you'll need to use APIs in the algorithm itself
    final fernet = Fernet(b64key);
    final encrypter = Encrypter(fernet);

    final encrypted = encrypter.encrypt(text);
    final decrypted = encrypter.decrypt(encrypted);

    log(decrypted
        .toString()); // Lorem ipsum dolor sit amet, consectetur adipiscing elit
    log(encrypted.base64.toString()); // random cipher text
    log(fernet.extractTimestamp(encrypted.bytes).toString()); // unix timestamp

    return encrypted.base64.toString();
  }
}
