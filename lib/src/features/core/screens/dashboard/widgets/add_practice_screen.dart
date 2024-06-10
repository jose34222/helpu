import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helpu/src/features/practica/model/practica_model.dart';
import 'package:helpu/src/features/practica/controller/practica_controller.dart';
import 'package:helpu/src/features/core/models/dashboard/latest_model.dart';
import 'package:helpu/src/features/core/models/dashboard/categories_model.dart';
class AddPracticeScreen extends StatefulWidget {
  @override
  _AddPracticeScreenState createState() => _AddPracticeScreenState();
}

class _AddPracticeScreenState extends State<AddPracticeScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController headingController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController requirementsController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();

  String selectedCategory = DashboardCategoriesModel.list[0].title;
  bool isActive = true; // Estado inicial de la práctica

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PracticaController());

    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Práctica'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: 'Categoría'),
              value: selectedCategory,
              items: DashboardCategoriesModel.list
                  .map<DropdownMenuItem<String>>(
                    (category) => DropdownMenuItem<String>(
                  value: category.title,
                  child: Text(category.title),
                ),
              ).toList(),
              onChanged: (value) {
                setState(() {
                  selectedCategory = value!;
                });
              },
            ),
            TextFormField(
              controller: controller.titulo,
              decoration: InputDecoration(labelText: 'Título'),
            ),
            TextFormField(
              controller: controller.encabezado,
              decoration: InputDecoration(labelText: 'Encabezado'),
            ),
            TextFormField(
              controller: controller.descripcion,
              decoration: InputDecoration(labelText: 'Descripción'),
            ),
            TextFormField(
              controller: controller.requisitos,
              decoration: InputDecoration(labelText: 'Requisitos'),
            ),
            TextFormField(
              controller: areaController, // Usa el controlador local
              decoration: InputDecoration(labelText: 'Área'),
            ),
            TextFormField(
              controller: startDateController, // Usa el controlador local
              decoration: InputDecoration(labelText: 'Fecha inicio'),
            ),
            TextFormField(
              controller: endDateController, // Usa el controlador local
              decoration: InputDecoration(labelText: 'Fecha fin'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Estado: ${isActive ? "Activo" : "Inactivo"}',
                  style: TextStyle(fontSize: 16.0),
                ),
                Switch(
                  value: isActive,
                  onChanged: (value) {
                    setState(() {
                      isActive = value;
                    });
                    controller.estado.value = value; // Sincronizar estado
                  },
                ),
              ],
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                final practica = PracticaModel(
                  titulo: controller.titulo.text,
                  encabezado: controller.encabezado.text,
                  descripcion: controller.descripcion.text,
                  requisitos: controller.requisitos.text,
                  area: areaController.text, // Usa el texto del controlador local
                  fechaInicio: startDateController.text,
                  fechaFin: endDateController.text,
                  estado: isActive,
                );

                controller.createPractica(practica);

                Navigator.pop(context);
              },
              child: Text('Crear Práctica'),
            ),
          ],
        ),
      ),
    );
  }
}
