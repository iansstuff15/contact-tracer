import 'dart:async';

import 'package:contact_tracer/datamodels/current_user_data.dart';
import 'package:contact_tracer/datamodels/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:tric_app_driver/datamodels/current_user_data.dart';
// import 'package:tric_app_driver/datamodels/driver.dart';
// import 'package:tric_app_driver/datamodels/rider.dart';
// import 'package:tric_app_driver/datamodels/user.dart';

String apikey = 'AIzaSyDNMd6kWR0QYu-L_pp_3xJXVgGFjbS0CiU';
User? currentFirebaseUser;
UserData? userInfo;
StreamSubscription<Position>? homeTabPositionString;
StreamSubscription<Position>? ridePositionStream;
Position? currentPosition;
// DriverData? currentDriverInfo;
String? globalRideID;
CurrentUserData? account;
