import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helpu/src/features/authetication/controller/signup_controller.dart';
import 'package:helpu/src/features/authetication/model/user_model.dart';

class UserRegistrationForm extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final signUpController = Get.find<SignUpController>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            controller: signUpController.nameController,
            decoration: const InputDecoration(
              labelText: 'Nombre completo',
            ),
          ),
          TextFormField(
            controller: signUpController.emailController,
            decoration: const InputDecoration(
              labelText: 'Correo electrónico',
            ),
          ),
          TextFormField(
            controller: signUpController.phoneController,
            decoration: const InputDecoration(
              labelText: 'Número de teléfono',
            ),
          ),
          TextFormField(
            controller: signUpController.passwordController,
            decoration: const InputDecoration(
              labelText: 'Contraseña',
            ),
            obscureText: true,
          ),
          TextFormField(
            controller: signUpController.carreraController,
            decoration: const InputDecoration(
              labelText: 'Carrera',
            ),
          ),
          TextFormField(
            controller: signUpController.provinciaController,
            decoration: const InputDecoration(
              labelText: 'Provincia',
            ),
          ),
          TextFormField(
            controller: signUpController.generoController,
            decoration: const InputDecoration(
              labelText: 'Género',
            ),
          ),
          TextFormField(
            controller: signUpController.ciudadController,
            decoration: const InputDecoration(
              labelText: 'Ciudad',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                signUpController.registerUser();
              }
            },
            child: const Text('Registrar'),
          ),
        ],
      ),
    );
  }
}