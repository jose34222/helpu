import 'package:cloud_firestore/cloud_firestore.dart';

class StudentModel {
  final String? id;
  final String fullName;
  final String email;
  final String phoneNo;
  final String password;
  final String carrera;
  final String provincia;
  final String genero;
  final String ciudad;
  final Timestamp created_at;

  const StudentModel({
    this.id,
    required this.fullName,
    required this.email,
    required this.phoneNo,
    required this.password,
    required this.carrera,
    required this.provincia,
    required this.genero,
    required this.ciudad,
    required this.created_at
  });

  toJson() {
    return {
      'full_name': fullName,
      'email': email,
      'phone_no': phoneNo,
      'carrera': carrera,
      'provincia': provincia,
      'genero': genero,
      'ciudad': ciudad,
      'created_at': created_at
    };
  }

  factory StudentModel.fromSnapShot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return StudentModel(
      id: document.id,
      fullName: data['full_name'],
      email: data['email'],
      phoneNo: data['phone_no'],
      password: data['password'],
      carrera: data['carrera'],
      provincia: data['provincia'],
      ciudad: data['ciudad'],
      genero: data['genero'],
      created_at: data['created_at']
    );
  }
}