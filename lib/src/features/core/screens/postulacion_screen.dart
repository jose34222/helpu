import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helpu/src/features/postulacion/controller/postulacion_controller.dart';
import 'package:helpu/src/features/practica/controller/practica_controller.dart';
import 'package:helpu/src/features/practica/model/practica_model.dart';

class PostulacionesScreen extends StatefulWidget {
  @override
  _PostulacionesScreenState createState() => _PostulacionesScreenState();
}

class _PostulacionesScreenState extends State<PostulacionesScreen> {
  final PostulacionController controller = Get.put(PostulacionController());
  final PracticaController practicaController = Get.put(PracticaController());

  @override
  void dispose() {
    // Eliminar el controlador cuando se salga de la pantalla
    Get.delete<PostulacionController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Postulaciones Realizadas',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
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
                      trailing: Text(
                        postulacion.aceptado ? 'Aceptado' : 'Pendiente',
                        style: TextStyle(
                          color: postulacion.aceptado ? Colors.green : Colors.yellow,
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return ListTile(
                      title: Text('Error al cargar práctica'),
                      subtitle: Text(postulacion.createdAt.toDate().toString()),
                      trailing: Text(
                        postulacion.isRevisado ? postulacion.aceptado ? 'Aceptado' : 'Rechazado' : 'Pendiente',
                        style: TextStyle(
                          color: postulacion.aceptado ? Colors.green : Colors.yellow,
                        ),
                      ),
                    );
                  } else if (!snapshot.hasData) {
                    return ListTile(
                      title: Text('Práctica no encontrada'),
                      subtitle: Text(postulacion.createdAt.toDate().toString()),
                      trailing: Text(
                        postulacion.isRevisado ? postulacion.aceptado ? 'Aceptado' : 'Rechazado' : 'Pendiente',
                        style: TextStyle(
                          color: postulacion.aceptado ? Colors.green : Colors.yellow,
                        ),
                      ),
                    );
                  } else {
                    final practica = snapshot.data!;
                    return ListTile(
                      title: Text('Práctica: ${practica.encabezado}'),
                      subtitle: Text(postulacion.createdAt.toDate().toString()),
                      trailing: Text(
                        postulacion.isRevisado ? postulacion.aceptado ? 'Aceptado' : 'Rechazado' : 'Pendiente',
                        style: TextStyle(
                          color: postulacion.aceptado ? Colors.green : Colors.yellow,
                        ),
                      ),
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
