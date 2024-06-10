import 'package:cloud_firestore/cloud_firestore.dart';

class StudentModel {
  final String? id;
  final String carrera;
  final String provincia;
  final String genero;
  final String ciudad;
  final String userId;

  const StudentModel({
    this.id,
    required this.carrera,
    required this.provincia,
    required this.genero,
    required this.ciudad,
    required this.userId
  });

  toJson() {
    return {
      'Carrera': carrera,
      'Provincia': provincia,
      'Genero': genero,
      'Ciudad': ciudad,
      'UserId': userId
    };
  }

  factory StudentModel.fromSnapShot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return StudentModel(
      id: document.id,
      carrera: data['Carrera'],
      provincia: data['Provincia'],
      ciudad: data['Ciudad'],
      userId: data['UserId'], genero: '',
    );
  }
}