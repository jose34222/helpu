import 'package:cloud_firestore/cloud_firestore.dart';

class PracticaModel {
  final String? id;
  final String titulo;
  final String encabezado;
  final String descripcion;
  final String requisitos;
  final String area;
  final String fechaInicio;
  final String fechaFin;
  final bool estado;

  const PracticaModel({
    this.id,
    required this.titulo,
    required this.encabezado,
    required this.descripcion,
    required this.requisitos,
    required this.area,
    required this.fechaInicio,
    required this.fechaFin,
    required this.estado,
  });

  Map<String, dynamic> toJson() {
    return {
      'titulo': titulo,
      'encabezado': encabezado,
      'descripcion': descripcion,
      'requisitos': requisitos,
      'area': area,
      'fecha_inicio': fechaInicio,
      'fecha_fin': fechaFin,
      'estado': estado,
    };
  }

  factory PracticaModel.fromSnapShot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return PracticaModel(
      id: document.id,
      titulo: data['titulo'],
      encabezado: data['encabezado'],
      descripcion: data['descripcion'],
      requisitos: data['requisitos'],
      area: data['area'],
      fechaInicio: data['fecha_inicio'],
      fechaFin: data['fecha_fin'],
      estado: data['estado'],
    );
  }
}
