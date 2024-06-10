import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helpu/src/features/authetication/model/student_model.dart';
import 'package:helpu/src/features/authetication/model/user_model.dart';

class StudentRepository extends GetxController {
  static StudentRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<void> createStudents(StudentModel student) async {
    await _db
        .collection('Students')
        .add(student.toJson())
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

  Future<StudentModel> getStudentDetails(String userId) async {
    final snapshot = await _db
        .collection('Students')
        .where('UserId', isEqualTo: userId)
        .get()
        .catchError((error, stackTrace) {
      Get.snackbar('Error', error.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
      return error;
    });

    final studentData = snapshot.docs.map((e) => StudentModel.fromSnapShot(e)).single;
    return studentData;
  }

  Future<List<StudentModel>> getStudents() async {
    final snapshot = await _db.collection('Students').get();
    final students = snapshot.docs.map((e) => StudentModel.fromSnapShot(e)).toList();
    return students;
  }

  Future<void> updateStudent(StudentModel student) async {
    await _db
        .collection('Students')
        .doc(student.id)
        .update(student.toJson())
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