import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppUser extends ChangeNotifier {
  String? appUserId;
  String? userName;
  String? profileImage;
  String? userEmail;
  String? address;
  DateTime? createdAt;
  String? phoneNumber;

  AppUser({
    this.appUserId,
    this.profileImage,
    this.userEmail,
    this.userName,
    this.createdAt,
    this.address,
    this.phoneNumber,
  });

  AppUser.fromJson(json, id) {
    this.appUserId = id;
    this.profileImage = json['profileImage'];
    this.userName = json['userName'] ?? '';
    this.userEmail = json['userEmail'];
    this.phoneNumber = json['phoneNumber'];
    this.address = json['address'] ?? '';
    this.createdAt = json['createdAt'].toDate();
  }
  toJson() {
    return {
      'appUserId': this.appUserId,
      'profileImage': profileImage,
      'userName': this.userName,
      'userEmail': this.userEmail,
      'phoneNumber': this.phoneNumber,
      'address': this.address,
      'createdAt': this.createdAt,
    };
  }
}
