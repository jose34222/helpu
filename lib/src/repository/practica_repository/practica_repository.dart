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

  Future<PracticaModel> getPracticaDetailsByEmail(String email) async {
    final snapshot = await _db
        .collection('Practicas')
        .where('empresa_email', isEqualTo: email)
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

  Future<PracticaModel> getPracticaDetailById(String id) async {
    try {
      final snapshot = await _db.collection('Practicas').doc(id).get();

      if (!snapshot.exists) {
        throw Exception("Document not found");
      }

      final practicaData = PracticaModel.fromSnapShot(snapshot);
      return practicaData;
    } catch (error, stackTrace) {
      Get.snackbar(
        'Error',
        error.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent.withOpacity(0.1),
        colorText: Colors.red,
      );
      rethrow; // rethrowing the error after displaying the snackbar
    }
  }

  Future<List<PracticaModel>> getPracticas() async {
    final snapshot = await _db.collection('Practicas')
        .where('estado', isEqualTo: true)
        .get();
    final practicas = snapshot.docs.map((e) => PracticaModel.fromSnapShot(e)).toList();
    return practicas;
  }

  Future<List<PracticaModel>> getPracticasByEmail(String? email) async {
    final snapshot = await _db.collection('Practicas')
        .where('empresa_email', isEqualTo: email)
        .get();

    final practicas = snapshot.docs.map((e) => PracticaModel.fromSnapShot(e)).toList();
    print(email);
    print(practicas.length);
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

  Future<void> togglePracticaEstado(String? practicaId) async {
    try {
      // Obtén el documento actual
      DocumentSnapshot<Map<String, dynamic>> snapshot = await _db.collection('Practicas').doc(practicaId).get();

      // Verifica si el documento existe
      if (snapshot.exists) {
        // Obtén el estado actual
        bool currentEstado = snapshot.data()?['estado'] ?? false;

        // Alterna el estado
        bool newEstado = !currentEstado;

        // Actualiza el estado en el documento
        await _db.collection('Practicas').doc(practicaId).update({'estado': newEstado});

        // Mostrar snackbar de éxito
        Get.snackbar(
          'Success',
          'El estado de la práctica se ha cambiado satisfactoriamente',
          backgroundColor: Colors.green.withOpacity(0.2),
          colorText: Colors.green,
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        // Mostrar snackbar de error si el documento no existe
        Get.snackbar(
          'Error',
          'El documento no existe',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red,
        );
      }
    } catch (error, stackTrace) {
      // Mostrar snackbar de error
      Get.snackbar(
        'Error',
        error.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent.withOpacity(0.1),
        colorText: Colors.red,
      );
    }
  }

}