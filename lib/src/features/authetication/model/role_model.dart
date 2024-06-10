import 'package:cloud_firestore/cloud_firestore.dart';
class RoleModel {
  final String? id;
  final String name;
  final String description;

  RoleModel({
    this.id,
    required this.name,
    required this.description,
  });

  toJson() {
    return {
      'Name': name,
      'Description': description,
    };
  }

  factory RoleModel.fromSnapShot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return RoleModel(
      id: document.id,
      name: data['Name'],
      description: data['Description'],
    );
  }
}