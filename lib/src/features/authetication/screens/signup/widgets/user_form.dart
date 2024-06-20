import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helpu/src/features/authetication/controller/signup_controller.dart';

class UserRegistrationForm extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final signUpController = Get.find<SignUpController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                signUpController.pickProfileImage();
              },
              child: Obx(() {
                return CircleAvatar(
                  radius: 50,
                  backgroundImage: signUpController.profileImage.value != null
                      ? FileImage(signUpController.profileImage.value!)
                      : AssetImage('assets/images/default_profile.png') as ImageProvider,
                );
              }),
            ),
            SizedBox(height: 16),
            TextField(
              controller: signUpController.nameController,
              decoration: InputDecoration(labelText: 'Full Name'),
            ),
            TextField(
              controller: signUpController.emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: signUpController.phoneController,
              decoration: InputDecoration(labelText: 'Phone'),
            ),
            TextField(
              controller: signUpController.passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            TextField(
              controller: signUpController.carreraController,
              decoration: InputDecoration(labelText: 'Carrera'),
            ),
            TextField(
              controller: signUpController.provinciaController,
              decoration: InputDecoration(labelText: 'Provincia'),
            ),
            TextField(
              controller: signUpController.generoController,
              decoration: InputDecoration(labelText: 'Género'),
            ),
            TextField(
              controller: signUpController.ciudadController,
              decoration: InputDecoration(labelText: 'Ciudad'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                signUpController.registerStudent();
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}