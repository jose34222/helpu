import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helpu/src/features/practica/model/practica_model.dart';
class PracticaRepository extends GetxController {
  static PracticaRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<void> createPractica(PracticaModel practica) async {
    await _db
        .collection('Practicas')
        .add(practica.toJson())
        .whenComplete(() => Get.snackbar(
      'Success',
      'Practica created successfully',
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

  Future<PracticaModel> getPracticaDetails(String id) async {
    final snapshot = await _db
        .collection('Practicas')
        .where('id', isEqualTo: id)
        .get()
        .catchError((error, stackTrace) {
      Get.snackbar('Error', error.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
      return error;
    });

    final practicaData = snapshot.docs.map((e) => PracticaModel.fromSnapShot(e)).single;
    return practicaData;
  }

  Future<List<PracticaModel>> getPracticas() async {
    final snapshot = await _db.collection('Practicas').get();
    final practicas = snapshot.docs.map((e) => PracticaModel.fromSnapShot(e)).toList();
    return practicas;
  }

  Future<void> updatePractica(PracticaModel practica) async {
    await _db
        .collection('Practicas')
        .doc(practica.id)
        .update(practica.toJson())
        .whenComplete(() => Get.snackbar(
      'Success',
      'Practica subida satisfactoriamente',
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