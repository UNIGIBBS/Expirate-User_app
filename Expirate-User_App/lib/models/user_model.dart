import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

class UserModel with ChangeNotifier {
  String? uid;
  String? email;
  String? name;
  String? address;

  UserModel({this.uid, this.email, this.name, this.address});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      name: map['name'],
      address: map['address'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'address': address,
    };
  }
}