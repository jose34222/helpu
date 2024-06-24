import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helpu/src/features/authetication/model/student_model.dart';
import 'package:helpu/src/features/core/screens/dashboard/widgets/detalle_student.dart';
import 'package:helpu/src/features/postulacion/controller/postulacion_controller.dart';
import 'package:helpu/src/features/postulacion/model/postulacion_model.dart';
import 'package:helpu/src/features/practica/controller/practica_controller.dart';
import 'package:helpu/src/features/practica/model/practica_model.dart';
import 'package:helpu/src/features/student/controller/student_controller.dart';
import 'package:string_similarity/string_similarity.dart';

class PracticeDetailScreen extends StatelessWidget {
  final PracticaModel practice;

  const PracticeDetailScreen({Key? key, required this.practice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PracticaController controller = Get.put(PracticaController());
    final PostulacionController postulacionController = Get.put(PostulacionController());
    final StudentController studentController = Get.put(StudentController());

    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
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
          icon: const Icon(Icons.arrow_back, color: Colors.white),
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
                const SizedBox(height: 120),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20.0),
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
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
                      const SizedBox(height: 20),
                      const Divider(color: Colors.grey),
                      const SizedBox(height: 20),
                      _buildInfoItem(
                        'Encabezado:',
                        practice.encabezado,
                        textTheme.bodyMedium!,
                      ),
                      const SizedBox(height: 15),
                      _buildInfoItem(
                        'Descripción:',
                        practice.descripcion,
                        textTheme.bodyMedium!,
                      ),
                      const SizedBox(height: 15),
                      _buildInfoItem(
                        'Requisitos:',
                        practice.requisitos,
                        textTheme.bodyMedium!,
                      ),
                      const SizedBox(height: 15),
                      _buildInfoItem(
                        'Área:',
                        practice.area,
                        textTheme.bodyMedium!,
                      ),
                      const SizedBox(height: 15),
                      _buildInfoItem(
                        'Fecha de inicio:',
                        practice.fechaInicio.toDate().toString(),
                        textTheme.bodyMedium!,
                      ),
                      const SizedBox(height: 15),
                      _buildInfoItem(
                        'Fecha de fin:',
                        practice.fechaFin.toDate().toString(),
                        textTheme.bodyMedium!,
                      ),
                      const SizedBox(height: 15),
                      _buildInfoItem(
                        'Estado:',
                        practice.estado ? "Activo" : "Inactivo",
                        textTheme.bodyMedium!,
                      ),
                      const SizedBox(height: 30),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            controller.togglePracticaEstado(practice.id.toString());
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
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
                              const Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                'Cambiar estado',
                                style: textTheme.bodyMedium?.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      FutureBuilder<List<PostulacionModel>>(
                        future: postulacionController.getPostulacionesByPractica(practice.id),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(child: Text('Error: ${snapshot.error}'));
                          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                            return const Center(child: Text('No hay postulantes.'));
                          }

                          final postulaciones = snapshot.data!;

                          return FutureBuilder<Map<String, StudentModel>>(
                            future: _fetchAllStudents(postulaciones, studentController),
                            builder: (context, studentSnapshot) {
                              if (studentSnapshot.connectionState == ConnectionState.waiting) {
                                return const Center(child: CircularProgressIndicator());
                              } else if (studentSnapshot.hasError) {
                                return Center(child: Text('Error: ${studentSnapshot.error}'));
                              } else if (!studentSnapshot.hasData) {
                                return const Center(child: Text('Error al cargar estudiantes.'));
                              }

                              final students = studentSnapshot.data!;

                              return DataTable(
                                columns: const [
                                  DataColumn(label: Text('Nombre')),
                                  DataColumn(label: Text('porcentaje')),
                                  DataColumn(label: Text('Revisado')),
                                  DataColumn(label: Text('Aprobado')),
                                  DataColumn(label: Text('Acciones')),
                                ],
                                rows: postulaciones.map((postulacion) {
                                  final student = students[postulacion.emailStudent];
                                  double porcentaje = calcularPorcentajeIgualdad(practice.area, student?.carrera ?? '');
                                  return DataRow(cells: [
                                    DataCell(Text(student?.fullName ?? 'No encontrado', style: const TextStyle(color: Colors.black))),
                                    DataCell(Text('${porcentaje.toStringAsFixed(2)}%', style: const TextStyle(color: Colors.black))),
                                    DataCell(Text(postulacion.isRevisado ? 'Si' : 'No', style: const TextStyle(color: Colors.black))),
                                    DataCell(Text(postulacion.aceptado ? 'Si' : 'No', style: const TextStyle(color: Colors.black))),
                                    DataCell(
                                      ElevatedButton(
                                        onPressed: () {
                                          if (student != null) {
                                            Get.to(StudentDetailScreen(student: student, practica: practice,));
                                          } else {
                                            Get.snackbar('Error', 'No se pudo encontrar los detalles del estudiante');
                                          }
                                        },
                                        child: const Text('Ver Detalle'),
                                      ),
                                    ),
                                  ]);
                                }).toList(),
                              );
                            },
                          );
                        },
                      ),
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

  Future<Map<String, StudentModel>> _fetchAllStudents(List<PostulacionModel> postulaciones, StudentController studentController) async {
    final Map<String, StudentModel> students = {};
    for (final postulacion in postulaciones) {
      final student = await studentController.getStudentDetails(postulacion.emailStudent);
      students[postulacion.emailStudent] = student;
      print("cantidad postulantes");
      print(students.length);
    }

    return students;
  }

  double calcularPorcentajeIgualdad(String str1, String str2) {
    double similarity = StringSimilarity.compareTwoStrings(str1, str2);
    return similarity * 100;
  }

  Widget _buildInfoItem(String label, String value, TextStyle style) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 5),
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