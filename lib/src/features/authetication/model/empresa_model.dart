import 'package:cloud_firestore/cloud_firestore.dart';

class EmpresaModel {
  final String? id;
  final String fullName;
  final String phoneNo;
  final String ruc;
  final String direccion;
  final String userId;

  const EmpresaModel({
    this.id,
    required this.fullName,
    required this.phoneNo,
    required this.ruc,
    required this.direccion,
    required this.userId, // Agregar este campo en el constructor
  });

  toJson() {
    return {
      'FullName': fullName,
      'PhoneNo': phoneNo,
      'Ruc': ruc,
      'Direccion': direccion,
      'UserId': userId, // Agregar este campo en el método toJson()
    };
  }

  factory EmpresaModel.fromSnapShot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return EmpresaModel(
      id: document.id,
      fullName: data['FullName'],
      phoneNo: data['PhoneNo'],
      ruc: data['Ruc'],
      direccion: data['Direccion'],
      userId: data['userId'], // Agregar este campo en el constructor
    );
  }
}