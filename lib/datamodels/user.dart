import 'package:firebase_database/firebase_database.dart';

class UserData {
  late String? firstName;
  late String? lastName;
  late String? email;
  late String? phone;
  late String? id;

  UserData({
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.id,
  });

  UserData.fromSnapshot(DataSnapshot? snapshot) {
    id = snapshot!.key;
    email = snapshot.child('email').value.toString();
    firstName = snapshot.child('firstName').value.toString();
    lastName = snapshot.child('lastName').value.toString();
    phone = snapshot.child('phone').value.toString();
  }
}
