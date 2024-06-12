import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:helpu/src/features/authetication/model/student_model.dart';
import 'package:helpu/src/features/practica/model/practica_model.dart';
import 'package:helpu/src/repository/student_repository/student_repository.dart';

class StudentController extends GetxController {
  static StudentController get instance => Get.find();

  final studentRepo = Get.put(StudentRepository());

  Future<void> createStudent(StudentModel student) async {
    await studentRepo.createStudents(student);
  }

  Future<StudentModel> getStudentDetails(String id) async {
    StudentModel  studentModel = await studentRepo.getStudentDetails(id);
    return studentModel;
  }



  Future<List<StudentModel>> getStudents() async {
    final List<StudentModel> studentsModel = await studentRepo.getStudents();
    return studentsModel;

  }

  List<PracticaModel> filterPracticas(List<PracticaModel> practicas, String query) {
    if (query.isEmpty) {
      return practicas;
    }
    return practicas.where((practica) {
      final tituloLower = practica.titulo.toLowerCase();
      final encabezadoLower = practica.encabezado.toLowerCase();
      final descripcionLower = practica.descripcion.toLowerCase();
      final searchLower = query.toLowerCase();

      return tituloLower.contains(searchLower) ||
          encabezadoLower.contains(searchLower) ||
          descripcionLower.contains(searchLower);
    }).toList();
  }


}