import 'package:flutter/material.dart';

class DashboardLatestModel {
  final String title;
  final String heading;
  final String subHeading;
  final String category;
  final VoidCallback? onPress;

  DashboardLatestModel(
      this.title,
      this.heading,
      this.subHeading,
      this.category,
      this.onPress,
      );

  static List<DashboardLatestModel> list = [
    DashboardLatestModel('Práctica en DevOps', 'Tecnología/Informática', 'Google Ecuador', 'IT', null),
    DashboardLatestModel('Práctica en Marketing', 'Marketing', 'Facebook Ecuador', 'MK', null),
    DashboardLatestModel('Práctica en Análisis de Datos', 'Análisis de Datos', 'Amazon Ecuador', 'IT', null),
    DashboardLatestModel('Práctica en Diseño Gráfico', 'Diseño Gráfico', 'Adobe Ecuador', 'DE', null),
    DashboardLatestModel('Práctica en Posgrados', 'Diseño web', 'POSGRADOS UPEC', 'DE', null),
  ];

  static void addPractice(DashboardLatestModel practice) {
    list.add(practice);
  }
}
