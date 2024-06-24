import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helpu/src/features/postulacion/model/postulacion_model.dart';

class PostulacionRepository extends GetxController {
  static PostulacionRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<void> createPostulacion(PostulacionModel postulacion) async {
    await _db
        .collection('Postulaciones')
        .add(postulacion.toJson())
        .whenComplete(() => Get.snackbar(
      'Success',
      'Postulacion created successfully',
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

  Future<PostulacionModel> getPostulacionDetails(String postulacionId) async {
    final snapshot = await _db
        .collection('Postulaciones')
        .where('id', isEqualTo: postulacionId)
        .get()
        .catchError((error, stackTrace) {
      Get.snackbar('Error', error.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
      return error;
    });

    final postulacionData = snapshot.docs.map((e) => PostulacionModel.fromSnapShot(e)).single;
    return postulacionData;
  }

  Future<List<PostulacionModel>> getPostulaciones() async {
    final snapshot = await _db.collection('Postulaciones').get();
    final postulaciones = snapshot.docs.map((e) => PostulacionModel.fromSnapShot(e)).toList();
    return postulaciones;
  }

  Future<void> updatePostulacion(PostulacionModel postulacion) async {
    await _db
        .collection('Postulaciones')
        .doc(postulacion.id)
        .update(postulacion.toJson())
        .whenComplete(() => Get.snackbar(
      'Success',
      'Postulacion updated successfully',
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

  Future<List<PostulacionModel>> getPostulacionesByPractica(String? idPractica) async {
    final snapshot = await _db.collection('Postulaciones')
        .where('id_practica', isEqualTo: idPractica)
        .get().catchError((error, stackTrace) {
      Get.snackbar('Error', error.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
      return error;
    });
    final postulaciones = snapshot.docs.map((e) => PostulacionModel.fromSnapShot(e)).toList();
    return postulaciones;
  }

  Future<List<PostulacionModel>> getPostulacionesByEmailStudent(String? email) async {
    final snapshot = await _db.collection('Postulaciones')
        .where('email_student', isEqualTo: email)
        .get().catchError((error, stackTrace) {
      Get.snackbar('Error', error.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
      return error;
    });
    final postulaciones = snapshot.docs.map((e) => PostulacionModel.fromSnapShot(e)).toList();
    return postulaciones;

  }

  Future<void> togglePostulacionAceptado(String? email, String? idPractica, bool estado) async {
    try {
      // Consulta para obtener el documento basado en email e idPractica
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _db
          .collection('Postulaciones')
          .where('email_student', isEqualTo: email)
          .where('id_practica', isEqualTo: idPractica)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Obtén el primer documento que coincida con la consulta
        DocumentSnapshot<Map<String, dynamic>> documentSnapshot = querySnapshot.docs.first;

        // Actualiza el estado en el documento
        await _db.collection('Postulaciones').doc(documentSnapshot.id).update({
          'aceptado': estado,
          'is_revisado': true,
        });

        // Mostrar snackbar de éxito
        Get.snackbar(
          'Success',
          'El estado de la postulacion se ha cambiado satisfactoriamente',
          backgroundColor: Colors.green.withOpacity(0.2),
          colorText: Colors.green,
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        // Mostrar snackbar de error si no se encuentra ningún documento
        Get.snackbar(
          'Error',
          'No se encontró ninguna postulación para los datos proporcionados',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red,
        );
      }
    } catch (error) {
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

  Future<bool> hasStudentApplied(String email, String idPractica) async {
    try {
      final querySnapshot = await _db
          .collection('Postulaciones')
          .where('email_student', isEqualTo: email)
          .where('id_practica', isEqualTo: idPractica)
          .get();

      return querySnapshot.docs.isNotEmpty;
    } catch (error) {
      Get.snackbar('Error', error.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
      return false;
    }
  }
}