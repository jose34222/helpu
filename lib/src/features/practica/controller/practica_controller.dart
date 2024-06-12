import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helpu/src/repository/practica_repository/practica_repository.dart';
import 'package:helpu/src/features/practica/model/practica_model.dart';

class PracticaController extends GetxController {
  static PracticaController get instance => Get.find();

  final titulo = TextEditingController();
  final encabezado = TextEditingController();
  final descripcion = TextEditingController();
  final requisitos = TextEditingController();
  final area = TextEditingController();
  final fechaInicio = Rxn<Timestamp>();
  final fechaFin = Rxn<Timestamp>();
  final estado = false.obs;

  final practicaRepo = Get.put(PracticaRepository());

  Future<void> createPractica(PracticaModel practica) async {
    await practicaRepo.createPractica(practica);
  }

  Future<PracticaModel> getPracticaDetailByEmail(String id) async {
    PracticaModel  practicaModel = await practicaRepo.getPracticaDetailsByEmail(id);
    return practicaModel;
  }

  Future<void> togglePracticaEstado(String? id) async {
    await practicaRepo.togglePracticaEstado(id);
  }

  Future<List<PracticaModel>> getPracticasbyEmail() async {
    final firebaseUser = await FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
        final practicas = await practicaRepo.getPracticasByEmail(firebaseUser.email);
        return practicas;
      }
    else {
      throw Exception('No hay ningún usuario autenticado.');
    }
  }

  Future<List<PracticaModel>> getPracticas() async {
    final List<PracticaModel> practicaModel = await practicaRepo.getPracticas();
    return practicaModel;

  }

  List<PracticaModel> filterPracticas(List<PracticaModel> practicas, String query) {
    if (query.isEmpty) {
      return practicas;
    }
    return practicas.where((practica) {
      final tituloLower = practica.titulo.toLowerCase();
      final encabezadoLower = practica.encabezado.toLowerCase();
      final descripcionLower = practica.descripcion.toLowerCase();
      final searchLower = query.toLowerCase();

      return tituloLower.contains(searchLower) ||
          encabezadoLower.contains(searchLower) ||
          descripcionLower.contains(searchLower);
    }).toList();
  }

  Future<PracticaModel> getPracticaDetailById(String idPractica) async {
    PracticaModel  practicaModel = await practicaRepo.getPracticaDetailById(idPractica);
    return practicaModel;
  }


}