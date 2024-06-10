import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helpu/src/features/authetication/model/user_model.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<void> createUser(UserModel user) async {
    await _db
        .collection('Users')
        .add(user.toJson())
        .whenComplete(() => Get.snackbar(
      'Success',
      'User created successfully',
      backgroundColor: Colors.green.withOpacity(0.2),
      colorText: Colors.green,
      snackPosition: SnackPosition.BOTTOM,
    ))
        .catchError((error, stackTrace) {
      Get.snackbar('Error', error.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
      return error;
    });
  }

  Future<UserModel> getUserDetails(String email) async {
    final snapshot = await _db
        .collection('Users')
        .where('Email', isEqualTo: email)
        .get()
        .catchError((error, stackTrace) {
      Get.snackbar('Error', error.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
      return error;
    });

    final userData = snapshot.docs.map((e) => UserModel.fromSnapShot(e)).single;
    return userData;
  }

  Future<List<UserModel>> getUsers() async {
    final snapshot = await _db.collection('Users').get();
    final users = snapshot.docs.map((e) => UserModel.fromSnapShot(e)).toList();
    return users;
  }

  Future<void> updateUser(UserModel user) async {
    await _db
        .collection('Users')
        .doc(user.id)
        .update(user.toJson())
        .whenComplete(() => Get.snackbar(
      'Success',
      'User updated successfully',
      backgroundColor: Colors.green.withOpacity(0.2),
      colorText: Colors.green,
      snackPosition: SnackPosition.BOTTOM,
    ))
        .catchError((error, stackTrace) {
      Get.snackbar('Error', error.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
      return error;
    });
  }
}