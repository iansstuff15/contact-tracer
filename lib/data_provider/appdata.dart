import 'package:contact_tracer/datamodels/address.dart';
import 'package:flutter/material.dart';

class AppData extends ChangeNotifier {
  Address pickUpAddress = Address();
  Address destinationAddress = Address();
  void updatePickUpAddress(Address pickUp) {
    pickUpAddress = pickUp;

    notifyListeners();
  }

  void updateDestinationAddress(Address destination) {
    destinationAddress = destination;
    notifyListeners();
  }
}
