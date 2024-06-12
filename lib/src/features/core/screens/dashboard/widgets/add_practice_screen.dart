import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helpu/src/features/practica/model/practica_model.dart';
import 'package:helpu/src/features/practica/controller/practica_controller.dart';
import 'package:helpu/src/features/core/models/dashboard/categories_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddPracticeScreen extends StatefulWidget {
  @override
  _AddPracticeScreenState createState() => _AddPracticeScreenState();
}

class _AddPracticeScreenState extends State<AddPracticeScreen> {
  final TextEditingController areaController = TextEditingController();
  String selectedCategory = DashboardCategoriesModel.list[0].title;
  bool isActive = true; // Estado inicial de la práctica
  final _auth = FirebaseAuth.instance;



  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PracticaController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Práctica'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Categoría'),
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
              decoration: const InputDecoration(labelText: 'Título'),
            ),
            TextFormField(
              controller: controller.encabezado,
              decoration: const InputDecoration(labelText: 'Encabezado'),
            ),
            TextFormField(
              controller: controller.descripcion,
              decoration: const InputDecoration(labelText: 'Descripción'),
            ),
            TextFormField(
              controller: controller.requisitos,
              decoration: const InputDecoration(labelText: 'Requisitos'),
            ),
            TextFormField(
              controller: areaController,
              decoration: const InputDecoration(labelText: 'Área'),
            ),
            Obx(() => ListTile(
              title: Text('Fecha de Inicio: ${controller.fechaInicio.value != null ? controller.fechaInicio.value!.toDate().toLocal().toString().split(' ')[0] : 'Selecciona una fecha'}'),
              trailing: const Icon(Icons.calendar_today),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: controller.fechaInicio.value != null ? controller.fechaInicio.value!.toDate() : DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (pickedDate != null) {
                  controller.fechaInicio.value = Timestamp.fromDate(pickedDate);
                }
              },
            )),
            Obx(() => ListTile(
              title: Text('Fecha de Fin: ${controller.fechaFin.value != null ? controller.fechaFin.value!.toDate().toLocal().toString().split(' ')[0] : 'Selecciona una fecha'}'),
              trailing: const Icon(Icons.calendar_today),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: controller.fechaFin.value != null ? controller.fechaFin.value!.toDate() : DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (pickedDate != null) {
                  controller.fechaFin.value = Timestamp.fromDate(pickedDate);
                }
              },
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Estado: ${isActive ? "Activo" : "Inactivo"}',
                  style: const TextStyle(fontSize: 16.0),
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
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                final firebaseUser = _auth.currentUser;
                final practica = PracticaModel(
                  titulo: controller.titulo.text,
                  encabezado: controller.encabezado.text,
                  descripcion: controller.descripcion.text,
                  requisitos: controller.requisitos.text,
                  area: areaController.text,
                  fechaInicio: controller.fechaInicio.value!,
                  fechaFin: controller.fechaFin.value!,
                  estado: isActive,
                  createdAt: Timestamp.now(),
                  empresaEmail: firebaseUser!.email!
                );

                controller.createPractica(practica);

                Navigator.pop(context);
              },
              child: const Text('Crear Práctica'),
            ),
          ],
        ),
      ),
    );
  }
}
