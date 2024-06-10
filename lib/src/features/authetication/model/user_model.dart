import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String email;
  final String fullName;
  final String phoneNo;
  final String password;

  const UserModel({
    this.id,
    required this.email,
    required this.fullName,
    required this.phoneNo,
    required this.password,
  });

  toJson() {
    return {
      'Email': email,
      'FullName': fullName,
      'PhoneNo': phoneNo,
      'Password': password,
    };
  }

  factory UserModel.fromSnapShot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel(
      id: document.id,
      email: data['Email'],
      fullName: data['FullName'],
      phoneNo: data['PhoneNo'],
      password: data['Password'],
    );
  }
}