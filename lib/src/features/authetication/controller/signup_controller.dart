
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:helpu/src/features/authetication/model/student_model.dart';
import 'package:helpu/src/features/authetication/model/user_model.dart';
import 'package:helpu/src/repository/authentication_repository/authentication_repository.dart';
import 'package:helpu/src/repository/empresa_repository/empresa_repository.dart';
import 'package:helpu/src/repository/student_repository/student_repository.dart';
import 'package:helpu/src/repository/user_repository/user_repository.dart';
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

  void registerUser() {
    UserModel user = UserModel(
      fullName: nameController.text,
      email: emailController.text,
      phoneNo: phoneController.text,
      password: passwordController.text,
    );
    UserRepository.instance.createUser(user).then((_) {

      StudentModel studentModel = StudentModel(
          carrera: carreraController.text,
          provincia: provinciaController.text,
          genero: generoController.text,
          ciudad: ciudadController.text,
          userId: user.email
      );
      StudentRepository.instance.createStudents(studentModel);
      AuthenticationRepository.instance.createUserWithEmailAndPassword(user.email, user.password, true);

      Get.back();
    }).catchError((error) {
      Get.showSnackbar(GetSnackBar(
        message: error.toString(),
      ));
    });
  }

  void registerEmpresa() {
    UserModel user = UserModel(
      fullName: nameController.text,
      email: emailController.text,
      phoneNo: phoneController.text,
      password: passwordController.text,
    );
    UserRepository.instance.createUser(user).then((_) {

      EmpresaModel empresaModel = EmpresaModel(
          fullName: companyNameController.text,
          phoneNo: phoneController.text,
          ruc: rucController.text,
          direccion: direccionController.text,
          userId: user.email
      );
      EmpresaRepository.instance.createEmpresa(empresaModel);
      AuthenticationRepository.instance.createUserWithEmailAndPassword(user.email, user.password, false);
      Get.back();
    }).catchError((error) {
      Get.showSnackbar(GetSnackBar(
        message: error.toString(),
      ));
    });
  }
}