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

  var practicasList = <PracticaModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchPracticas();
  }

  Future<void> createPractica(PracticaModel practica) async {
    await practicaRepo.createPractica(practica);
    fetchPracticas(); // Actualiza la lista después de añadir una práctica
  }


  Future<void> fetchPracticas() async {
    try {
      User? user = await FirebaseAuth.instance.currentUser;
      final List<PracticaModel> practicas = await practicaRepo.getPracticasByEmail(user?.email);
      practicasList.assignAll(practicas);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<PracticaModel> getPracticaDetailByEmail(String id) async {
    PracticaModel practicaModel = await practicaRepo.getPracticaDetailsByEmail(id);
    return practicaModel;
  }

  Future<void> togglePracticaEstado(String? id) async {
    await practicaRepo.togglePracticaEstado(id);
    fetchPracticas(); // Actualiza la lista después de cambiar el estado de una práctica
  }

  Future<List<PracticaModel>> getPracticasbyEmail() async {
    final firebaseUser = await FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      final practicas = await practicaRepo.getPracticasByEmail(firebaseUser.email!);
      return practicas;
    } else {
      throw Exception('No hay ningún usuario autenticado.');
    }
  }

  Future<void> getPracticas() async {
    final List<PracticaModel> practicaModel = await practicaRepo.getPracticas();
    practicasList.assignAll(practicaModel);
  }


  List<PracticaModel> filterPracticas(String query) {
    if (query.isEmpty) {
      return practicasList;
    }
    return practicasList.where((practica) {
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
    PracticaModel practicaModel = await practicaRepo.getPracticaDetailById(idPractica);
    return practicaModel;
  }
}
