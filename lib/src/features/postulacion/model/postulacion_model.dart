import 'package:cloud_firestore/cloud_firestore.dart';

class PostulacionModel {
  final String? id;
  final String idPractica;
  final String emailStudent;
  final String emailEmpresa;
  final bool isRevisado;
  final bool aceptado;
  final Timestamp createdAt;

  const PostulacionModel({
    this.id,
    required this.idPractica,
    required this.emailStudent,
    required this.emailEmpresa,
    required this.isRevisado,
    required this.aceptado,
    required this.createdAt
  });

  Map<String, dynamic> toJson() {
    return {
      'id_practica': idPractica,
      'email_student': emailStudent,
      'email_empresa': emailEmpresa,
      'is_revisado': isRevisado,
      'aceptado': aceptado,
      'created_at': createdAt
    };
  }

  factory PostulacionModel.fromSnapShot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return PostulacionModel(
        id: document.id,
        idPractica: data['id_practica'],
        emailStudent: data['email_student'],
        emailEmpresa: data['email_empresa'],
        isRevisado: data['is_revisado'],
        aceptado: data['aceptado'],
        createdAt: data['created_at']
    );
  }
}
