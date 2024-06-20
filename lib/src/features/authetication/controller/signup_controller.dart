
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:helpu/src/features/authetication/model/student_model.dart';
import 'package:helpu/src/repository/authentication_repository/authentication_repository.dart';
import 'package:helpu/src/repository/empresa_repository/empresa_repository.dart';
import 'package:helpu/src/repository/student_repository/student_repository.dart';
import 'package:helpu/src/features/authetication/model/empresa_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

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

  var profileImage = Rx<File?>(null); // Hacer profileImage observable
  Future<void> pickProfileImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage.value = File(pickedFile.path);
    }
  }

  Future<String?> uploadProfileImage(File? image) async {
    if (image == null) return null;

    try {
      final storageRef = FirebaseStorage.instance.ref();
      final profileImagesRef = storageRef.child('profile/${DateTime.now().millisecondsSinceEpoch}.jpg');

      final uploadTask = profileImagesRef.putFile(image);
      final snapshot = await uploadTask.whenComplete(() => {});
      final downloadUrl = await snapshot.ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      print('Error uploading profile image: $e');
      return null;
    }
  }

  void registerStudent() async {
    try {
      String? profileImageUrl;
      if (profileImage.value != null) {
        profileImageUrl = await uploadProfileImage(profileImage.value!);
      }

      StudentModel studentModel = StudentModel(
        fullName: nameController.text,
        email: emailController.text,
        photoUrl: profileImageUrl,
        phoneNo: phoneController.text,
        password: passwordController.text,
        carrera: carreraController.text,
        provincia: provinciaController.text,
        genero: generoController.text,
        ciudad: ciudadController.text,
        created_at: Timestamp.now(),
      );

      await StudentRepository.instance.createStudents(studentModel);
      await AuthenticationRepository.instance.createUserWithEmailAndPassword(studentModel.email, studentModel.password);
      Get.back();
    } catch (error) {
      Get.showSnackbar(GetSnackBar(
        message: error.toString(),
      ));
    }
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