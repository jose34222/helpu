import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helpu/src/features/authetication/model/role_model.dart';

class RoleRepository extends GetxController {
  static RoleRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<void> createRole(RoleModel role) async {
    await _db
        .collection('Roles')
        .add(role.toJson())
        .whenComplete(() => Get.snackbar(
      'Success',
      'Role created successfully',
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

  Future<RoleModel> getRoleDetails(String name) async {
    final snapshot = await _db
        .collection('Roles')
        .where('Name', isEqualTo: name)
        .get()
        .catchError((error, stackTrace) {
      Get.snackbar('Error', error.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
      return error;
    });

    final roleData = snapshot.docs.map((e) => RoleModel.fromSnapShot(e)).single;
    return roleData;
  }

  Future<List<RoleModel>> getRoles() async {
    final snapshot = await _db.collection('Roles').get();
    final roles = snapshot.docs.map((e) => RoleModel.fromSnapShot(e)).toList();
    return roles;
  }

  Future<void> updateRole(RoleModel role) async {
    await _db
        .collection('Roles')
        .doc(role.id)
        .update(role.toJson())
        .whenComplete(() => Get.snackbar(
      'Success',
      'Role updated successfully',
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