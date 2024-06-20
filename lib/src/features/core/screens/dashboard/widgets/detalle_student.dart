import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helpu/src/features/authetication/model/student_model.dart';
import 'package:helpu/src/features/postulacion/controller/postulacion_controller.dart';
import 'package:helpu/src/features/practica/model/practica_model.dart';

class StudentDetailScreen extends StatelessWidget {
  final StudentModel student;
  final PracticaModel practica;

  const StudentDetailScreen({Key? key, required this.student, required this.practica})
      : super(key: key);

  Future<String?> getImageUrl(String path) async {
    try {
      final storageRef = FirebaseStorage.instance.ref().child(path);
      return await storageRef.getDownloadURL();
    } catch (e) {
      print('Error getting download URL: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PostulacionController());
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
                        "Datos de postulante",
                        style: textTheme.headlineSmall?.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      FutureBuilder<String?>(
                        future: getImageUrl(student.photoUrl ?? 'assets/images/default_profile.png'),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError || !snapshot.hasData) {
                            return const CircleAvatar(
                              radius: 70,
                              backgroundImage: AssetImage('assets/images/default_profile.png'),
                            );
                          } else {
                            return CircleAvatar(
                              radius: 70,
                              backgroundImage: NetworkImage(snapshot.data!),
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      const Divider(color: Colors.grey),
                      const SizedBox(height: 20),
                      _buildInfoItem(
                        'Nombres:',
                        student.fullName,
                        textTheme.bodyMedium!,
                      ),
                      const SizedBox(height: 15),
                      _buildInfoItem(
                        'Email:',
                        student.email,
                        textTheme.bodyMedium!,
                      ),
                      const SizedBox(height: 15),
                      _buildInfoItem(
                        'Número de teléfono:',
                        student.phoneNo,
                        textTheme.bodyMedium!,
                      ),
                      const SizedBox(height: 15),
                      _buildInfoItem(
                        'Carrera:',
                        student.carrera,
                        textTheme.bodyMedium!,
                      ),
                      const SizedBox(height: 15),
                      _buildInfoItem(
                        'Provincia:',
                        student.provincia,
                        textTheme.bodyMedium!,
                      ),
                      const SizedBox(height: 15),
                      _buildInfoItem(
                        'Género:',
                        student.genero,
                        textTheme.bodyMedium!,
                      ),
                      const SizedBox(height: 15),
                      _buildInfoItem(
                        'Ciudad:',
                        student.ciudad,
                        textTheme.bodyMedium!,
                      ),
                      const SizedBox(height: 30),
                      Center(
                        child: Column(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                // Lógica para aceptar al estudiante
                                controller.togglePostulacionAceptado(student.email, practica.id, true);
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
                                shadowColor: Colors.greenAccent.shade200,
                                backgroundColor: Colors.greenAccent.shade400,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.check,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(width: 10),
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
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                // Lógica para rechazar al estudiante
                                controller.togglePostulacionAceptado(student.email, practica.id, false);
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
                                shadowColor: Colors.redAccent.shade200,
                                backgroundColor: Colors.redAccent.shade400,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.close,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(width: 10),
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
                      const SizedBox(height: 20),
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
