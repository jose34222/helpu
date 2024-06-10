import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helpu/src/features/authetication/model/role_model.dart';

import '../../features/authetication/model/empresa_model.dart';

class EmpresaRepository extends GetxController {
  static EmpresaRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<void> createEmpresa(EmpresaModel empresa) async {
    await _db
        .collection('Empresas')
        .add(empresa.toJson())
        .whenComplete(() => Get.snackbar(
      'Success',
      'Empresa created successfully',
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

  Future<EmpresaModel> getUserDetails(String email) async {
    final snapshot = await _db
        .collection('Empresa')
        .where('Email', isEqualTo: email)
        .get()
        .catchError((error, stackTrace) {
      Get.snackbar('Error', error.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
      return error;
    });

    final empresaData = snapshot.docs.map((e) => EmpresaModel.fromSnapShot(e)).single;
    return empresaData;
  }

  Future<List<EmpresaModel>> getEmpresa() async {
    final snapshot = await _db.collection('Empresas').get();
    final empresas = snapshot.docs.map((e) => EmpresaModel.fromSnapShot(e)).toList();
    return empresas;
  }

  Future<void> updateEmpresa(EmpresaModel empresa) async {
    await _db
        .collection('Empresas')
        .doc(empresa.id)
        .update(empresa.toJson())
        .whenComplete(() => Get.snackbar(
      'Success',
      'Empresa updated successfully',
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