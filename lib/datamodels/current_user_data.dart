import 'package:firebase_database/firebase_database.dart';

class CurrentUserData {
  late String? firstName;
  late String? lastName;

  late String? phone;
  late String? id;

  late String? dateTimeOfLog;

  late Map<dynamic, dynamic>? transactions;
  CurrentUserData({
    this.firstName,
    this.lastName,
    this.phone,
    this.id,
    this.dateTimeOfLog,
  });

  CurrentUserData.fromSnapshot(DataSnapshot? snapshot) {
    id = snapshot!.key;

    firstName = snapshot.child('firstName').value.toString();
    lastName = snapshot.child('lastName').value.toString();
    phone = snapshot.child('phone').value.toString();

    dateTimeOfLog = snapshot.child('earnings').value.toString();
  }
}
