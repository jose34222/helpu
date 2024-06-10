import 'package:flutter/material.dart';

class DashboardCategoriesModel {
  final String title;
  final String heading;
  final String subHeading;
  final VoidCallback onPress;

  DashboardCategoriesModel(
      this.title,
      this.heading,
      this.subHeading,
      this.onPress,
      );

  static List<DashboardCategoriesModel> list = [
    DashboardCategoriesModel('IT', 'Informática', '12 Prácticas', () {}),
    DashboardCategoriesModel('EN', 'Ingeniería', '10 Prácticas', () {}),
    DashboardCategoriesModel('BU', 'Negocios', '10 Prácticas', () {}),
    DashboardCategoriesModel('DE', 'Diseño', '8 Prácticas', () {}),
    DashboardCategoriesModel('MK', 'Marketing', '7 Prácticas', () {}),
    DashboardCategoriesModel('ME', 'Medicina', '5 Prácticas', () {}),
    DashboardCategoriesModel('ED', 'Educación', '6 Prácticas', () {}),
  ];
}

