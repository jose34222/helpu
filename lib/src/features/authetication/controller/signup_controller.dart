
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:helpu/src/features/authetication/model/student_model.dart';
import 'package:helpu/src/repository/authentication_repository/authentication_repository.dart';
import 'package:helpu/src/repository/empresa_repository/empresa_repository.dart';
import 'package:helpu/src/repository/student_repository/student_repository.dart';
import 'package:helpu/src/features/authetication/model/empresa_model.dart';

class SignUpController extends GetxController {

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final companyNameController = TextEditingController();
  final rucController = TextEditingController();
  final direccionController = TextEditingController();
  final carreraController = TextEditingController();
  final provinciaController = TextEditingController();
  final generoController = TextEditingController();
  final ciudadController = TextEditingController();

  void registerStudent() {

    StudentModel studentModel = StudentModel(
        fullName: nameController.text,
        email: emailController.text,
        phoneNo: phoneController.text,
        password: passwordController.text,
        carrera: carreraController.text,
        provincia: provinciaController.text,
        genero: generoController.text,
        ciudad: ciudadController.text,
        created_at: Timestamp.now()
    );

    StudentRepository.instance.createStudents(studentModel).then((_){

      AuthenticationRepository.instance.createUserWithEmailAndPassword(studentModel.email, studentModel.password);
      Get.back();
    }).catchError((error) {
      Get.showSnackbar(GetSnackBar(
        message: error.toString(),
      ));
    });
  }

  void registerEmpresa() {

    EmpresaModel empresaModel = EmpresaModel(
        companyName: companyNameController.text,
        email: emailController.text,
        password: passwordController.text,
        phoneNo: phoneController.text,
        ruc: rucController.text,
        direccion: direccionController.text,
        createdAt: Timestamp.now()
    );

    EmpresaRepository.instance.createEmpresa(empresaModel).then((_){
      AuthenticationRepository.instance.createUserWithEmailAndPassword(empresaModel.email, empresaModel.password);

      Get.back();
    }).catchError((error) {
      Get.showSnackbar(GetSnackBar(
        message: error.toString(),
      ));
    });
  }
}