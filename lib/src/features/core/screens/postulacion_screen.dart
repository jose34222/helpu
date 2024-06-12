import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helpu/src/features/postulacion/controller/postulacion_controller.dart';
import 'package:helpu/src/features/practica/controller/practica_controller.dart';
import 'package:helpu/src/features/practica/model/practica_model.dart';

class PostulacionesScreen extends StatelessWidget {
@override
Widget build(BuildContext context) {
  final PostulacionController controller = Get.put(PostulacionController());
  final PracticaController practicaController = Get.put(PracticaController());

  return Scaffold(
    appBar: AppBar(
      title: Text('Postulaciones Realizadas'),
    ),
    body: Obx(() {
      if (controller.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      } else if (controller.errorMessage.value.isNotEmpty) {
        return Center(child: Text('Error: ${controller.errorMessage.value}'));
      } else if (controller.postulaciones.isEmpty) {
        return Center(child: Text('No hay postulaciones'));
      } else {
        return ListView.builder(
          itemCount: controller.postulaciones.length,
          itemBuilder: (context, index) {
            final postulacion = controller.postulaciones[index];
            return FutureBuilder<PracticaModel>(
              future: practicaController.getPracticaDetailById(postulacion.idPractica),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return ListTile(
                    title: Text(postulacion.createdAt.toDate().toString()),
                    subtitle: Text('Cargando práctica...'),
                    trailing: Text(postulacion.aceptado ? 'Aceptado' : 'Pendiente'),
                  );
                } else if (snapshot.hasError) {
                  return ListTile(
                    title:  Text('Error al cargar práctica'),
                    subtitle: Text(postulacion.createdAt.toDate().toString()),
                    trailing: Text(postulacion.aceptado ? 'Aceptado' : 'Pendiente'),
                  );
                } else if (!snapshot.hasData) {
                  return ListTile(
                    title: Text('Práctica no encontrada'),
                    subtitle: Text(postulacion.createdAt.toDate().toString()),
                    trailing: Text(postulacion.aceptado ? 'Aceptado' : 'Pendiente'),
                  );
                } else {
                  final practica = snapshot.data!;
                  return ListTile(
                    title: Text('Práctica: ${practica.encabezado}'),
                    subtitle: Text(postulacion.createdAt.toDate().toString()),
                    trailing: Text(postulacion.aceptado ? 'Aceptado' : 'Pendiente'),
                    onTap: () {
                      // Acción al tocar un elemento de la lista
                    },
                  );
                }
              },
            );
          },
        );
      }
    }),
  );
}
}