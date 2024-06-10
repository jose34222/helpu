import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:helpu/src/features/authetication/model/empresa_model.dart';
import 'package:helpu/src/features/authetication/model/user_model.dart';
import 'package:helpu/src/repository/authentication_repository/authentication_repository.dart';
import 'package:helpu/src/repository/empresa_repository/empresa_repository.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();

  void loginUser() {
    AuthenticationRepository.instance
        .loginUserWithEmailAndPassword(email.text, password.text);
  }
}

Future<void> signInWithGoogle() async {
  AuthenticationRepository.instance.signInWithGoogle();
}

void phoneAuthentication(String phoneNo) {
  AuthenticationRepository.instance.phoneAuthentication(phoneNo);
}




