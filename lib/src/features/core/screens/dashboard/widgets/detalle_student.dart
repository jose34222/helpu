import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helpu/src/features/authetication/model/student_model.dart';
import 'package:helpu/src/features/postulacion/controller/postulacion_controller.dart';
import 'package:helpu/src/features/practica/controller/practica_controller.dart';
import 'package:helpu/src/features/practica/model/practica_model.dart';


class StudentDetailScreen extends StatelessWidget {
  final StudentModel student;
  final PracticaModel practica;

  const StudentDetailScreen({Key? key, required this.student, required this.practica})
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
                        "Datos de postulante",
                        style: textTheme.headlineSmall?.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      Divider(color: Colors.grey),
                      SizedBox(height: 20),
                      _buildInfoItem(
                        'Nombres:',
                        student.fullName,
                        textTheme.bodyMedium!,
                      ),
                      SizedBox(height: 15),
                      _buildInfoItem(
                        'Email:',
                        student.email,
                        textTheme.bodyMedium!,
                      ),
                      SizedBox(height: 15),
                      _buildInfoItem(
                        'Número de teléfono:',
                        student.phoneNo,
                        textTheme.bodyMedium!,
                      ),
                      SizedBox(height: 15),
                      _buildInfoItem(
                        'Carrera:',
                        student.carrera,
                        textTheme.bodyMedium!,
                      ),
                      SizedBox(height: 15),
                      _buildInfoItem(
                        'Provincia:',
                        student.provincia,
                        textTheme.bodyMedium!,
                      ),
                      SizedBox(height: 15),
                      _buildInfoItem(
                        'Género:',
                        student.genero,
                        textTheme.bodyMedium!,
                      ),
                      SizedBox(height: 15),
                      _buildInfoItem(
                        'Ciudad:',
                        student.ciudad,
                        textTheme.bodyMedium!,
                      ),
                      SizedBox(height: 30),
                      Center(
                        child: Column(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                // Lógica para aceptar al estudiante
                                controller.togglePostulacionAceptado(student.email, practica.id, true);
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
                                shadowColor: Colors.greenAccent.shade200,
                                backgroundColor: Colors.greenAccent.shade400,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.check,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    'Aceptado',
                                    style: textTheme.bodyMedium?.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                //logica para rechazar al estudainte
                                controller.togglePostulacionAceptado(student.email, practica.id, false);
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
                                shadowColor: Colors.redAccent.shade200,
                                backgroundColor: Colors.redAccent.shade400,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.close,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    'Rechazado',
                                    style: textTheme.bodyMedium?.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
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