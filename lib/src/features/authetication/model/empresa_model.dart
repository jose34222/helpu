import 'package:cloud_firestore/cloud_firestore.dart';

class EmpresaModel {
  final String? id;
  final String companyName;
  final String email;
  final String password;
  final String phoneNo;
  final String ruc;
  final String direccion;
  final Timestamp createdAt;

  const EmpresaModel({
    this.id,
    required this.companyName,
    required this.email,
    required this.password,
    required this.phoneNo,
    required this.ruc,
    required this.direccion,
    required this.createdAt
  });

  toJson() {
    return {
      'company_name': companyName,
      'email': email,
      'password': password,
      'phone_no': phoneNo,
      'ruc': ruc,
      'direccion': direccion,
      'created_at': createdAt
    };
  }

  factory EmpresaModel.fromSnapShot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return EmpresaModel(
      id: document.id,
      companyName: data['company_name'],
      email: data['email'],
      password: data['password'],
      phoneNo: data['phone_no'],
      ruc: data['ruc'],
      direccion: data['direccion'],
      createdAt: data['created_at']
    );
  }
}