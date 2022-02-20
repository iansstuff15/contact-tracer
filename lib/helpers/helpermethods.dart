import 'dart:developer';

import 'package:contact_tracer/data_provider/appdata.dart';
import 'package:contact_tracer/datamodels/address.dart';
import 'package:contact_tracer/datamodels/user.dart';
import 'package:contact_tracer/globalVariables.dart';
import 'package:contact_tracer/helpers/request_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:geolocator/geolocator.dart';

import 'package:connectivity/connectivity.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class HelperMethods {
  // static void getCurrentUserInfo() async {
  //   log('in get current user');
  //   currentFirebaseUser = await FirebaseAuth.instance.currentUser;
  //   String userID = currentFirebaseUser!.uid;
  //   log(currentFirebaseUser.toString());
  //   DatabaseReference userRef =
  //       FirebaseDatabase.instance.ref().child('users/$userID');
  //   log(userRef.toString());
  //   userRef.once().then((value) {
  //     userInfo = UserData.fromSnapshot(value.snapshot);
  //     log(userInfo!.firstName.toString());
  //   });
  // }

  static Future<String> findCoordinateAddress(
      Position position, context) async {
    String placeAddress = "";

    String url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=AIzaSyBIqbhv70irrWiQLldyKBE5nBqFk6olE3E';
    Uri uri = Uri.parse(url);

    var response = await RequestHelper.getRequest(uri);

    log(response.toString());
    log(position.latitude.toString() + "position log lat");
    log(position.longitude.toString() + "position log long");

    if (response != null) {
      String placeAddress = response["results"][0]['formatted_address'];
      log(response["results"][0]['formatted_address'].toString());
      log("hello");
      Address pickupAddress = Address();
      pickupAddress.placeName = placeAddress;
      pickupAddress.longitude = position.longitude;
      pickupAddress.latitude = position.latitude;
      log(pickupAddress.placeName.toString() + 'pickup');
      log(pickupAddress.latitude.toString() + 'pickup');
      log(pickupAddress.longitude.toString() + 'pickup');
      Provider.of<AppData>(context, listen: false)
          .updatePickUpAddress(pickupAddress);
    }

    log('ended');
    return placeAddress;
  }

  // static Future<DirectionDetails?> getDirectionDetails(
  //     LatLng startPosition, LatLng endPosition) async {
  //   String url =
  //       'https://maps.googleapis.com/maps/api/directions/json?origin=${startPosition.latitude},${startPosition.longitude}&destination=${endPosition.latitude},${endPosition.longitude}&key=AIzaSyBIqbhv70irrWiQLldyKBE5nBqFk6olE3E';
  //   Uri uri = Uri.parse(url);

  //   var response = await RequestHelper.getRequest(uri);
  //   log(response.toString() + 'direction response');

  //   if (response != null) {
  //     log('inside coditional');
  //     DirectionDetails directionDetails = DirectionDetails();

  //     directionDetails.durationText =
  //         response['routes'][0]['legs'][0]['duration']['text'];
  //     log(directionDetails.durationText.toString());

  //     directionDetails.durationValue =
  //         response['routes'][0]['legs'][0]['duration']['value'];
  //     log(directionDetails.durationValue.toString());

  //     directionDetails.distanceText =
  //         response['routes'][0]['legs'][0]['distance']['text'];
  //     log(directionDetails.distanceText.toString());
  //     directionDetails.distanceValue =
  //         response['routes'][0]['legs'][0]['distance']['value'];
  //     log(directionDetails.distanceValue.toString());

  //     directionDetails.encodedPoints =
  //         response['routes'][0]['overview_polyline']['points'];
  //     log(directionDetails.encodedPoints.toString());
  //     log(directionDetails.toString());
  //     return directionDetails;
  //   }
  // }

  // static void disableHomeTabLocationUpdates() {
  //   homeTabPositionString!.pause();
  //   Geofire.removeLocation(currentFirebaseUser!.uid);
  // }

  // static void enableHomeTabLocationUpdates() {
  //   homeTabPositionString!.resume();
  //   Geofire.setLocation(currentFirebaseUser!.uid, currentPosition!.latitude,
  //       currentPosition!.longitude);
  // }
}
