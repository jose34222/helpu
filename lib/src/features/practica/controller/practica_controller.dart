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
  final fechaInicio = TextEditingController();
  final fechaFin = TextEditingController();
  final estado = false.obs;

  final practicaRepo = Get.put(PracticaRepository());

  Future<void> createPractica(PracticaModel practica) async {
    await practicaRepo.createPractica(practica);
  }

  Future<PracticaModel> getPracticaDetails(String id) async {
    PracticaModel  practicaModel = await practicaRepo.getPracticaDetails(id);
    return practicaModel;
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
}