import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helpu/src/features/postulacion/controller/postulacion_controller.dart';
import 'package:helpu/src/features/postulacion/model/postulacion_model.dart';
import 'package:helpu/src/features/practica/controller/practica_controller.dart';
import 'package:helpu/src/features/practica/model/practica_model.dart';
import 'package:helpu/src/repository/postulacion_repository/postulacion_repository.dart'; // Importa el repositorio de postulaciones

class PostulacionDetailScreen extends StatelessWidget {
  final PracticaModel practice;

  const PostulacionDetailScreen({Key? key, required this.practice})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PostulacionController());
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          "DETALLE PRACTICA",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade300, Colors.blue.shade600],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 120),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  padding: EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        practice.titulo,
                        style: textTheme.headlineSmall?.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      Divider(color: Colors.grey),
                      SizedBox(height: 20),
                      _buildInfoItem(
                        'Encabezado:',
                        practice.encabezado,
                        textTheme.bodyMedium!,
                      ),
                      SizedBox(height: 15),
                      _buildInfoItem(
                        'Descripción:',
                        practice.descripcion,
                        textTheme.bodyMedium!,
                      ),
                      SizedBox(height: 15),
                      _buildInfoItem(
                        'Requisitos:',
                        practice.requisitos,
                        textTheme.bodyMedium!,
                      ),
                      SizedBox(height: 15),
                      _buildInfoItem(
                        'Área:',
                        practice.area,
                        textTheme.bodyMedium!,
                      ),
                      SizedBox(height: 15),
                      _buildInfoItem(
                        'Fecha de inicio:',
                        practice.fechaInicio.toDate().toString(),
                        textTheme.bodyMedium!,
                      ),
                      SizedBox(height: 15),
                      _buildInfoItem(
                        'Fecha de fin:',
                        practice.fechaFin.toDate().toString(),
                        textTheme.bodyMedium!,
                      ),
                      SizedBox(height: 15),
                      _buildInfoItem(
                        'Estado:',
                        practice.estado ? "Activo" : "Inactivo",
                        textTheme.bodyMedium!,
                      ),
                      SizedBox(height: 30),
                      FutureBuilder<bool>(
                        future: PostulacionRepository.instance.hasStudentApplied(
                          FirebaseAuth.instance.currentUser!.email!,
                          practice.id.toString(),
                        ),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          }

                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          }

                          final bool hasApplied = snapshot.data ?? false;

                          if (hasApplied) {
                            return Center(
                              child: Text(
                                'Ya has realizado una postulación a esta práctica.',
                                style: TextStyle(color: Colors.red),
                              ),
                            );
                          } else {
                            return Center(
                              child: ElevatedButton(
                                onPressed: () async {
                                  User? firebaseUser = FirebaseAuth.instance.currentUser;
                                  if (firebaseUser != null) {
                                    PostulacionModel postulacionModel = PostulacionModel(
                                      idPractica: practice.id.toString(),
                                      emailStudent: firebaseUser.email.toString(),
                                      emailEmpresa: practice.empresaEmail,
                                      isRevisado: false,
                                      aceptado: false,
                                      createdAt: Timestamp.now(),
                                    );
                                    controller.createPostulacion(postulacionModel);
                                  } else {
                                    throw Exception('No hay ningún usuario autenticado.');
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 40,
                                    vertical: 15,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  elevation: 5,
                                  shadowColor: Colors.blueAccent.shade200,
                                  backgroundColor: Colors.blueAccent.shade400,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.arrow_forward,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      'Postularse',
                                      style: textTheme.bodyMedium?.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                        },
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String label, String value, TextStyle style) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 5),
        Text(
          value,
          style: style.copyWith(
            color: Colors.grey.shade700,
          ),
        ),
      ],
    );
  }
}
