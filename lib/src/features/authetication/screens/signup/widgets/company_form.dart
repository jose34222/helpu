

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helpu/src/features/authetication/controller/signup_controller.dart';
import 'package:helpu/src/features/authetication/model/empresa_model.dart';

class CompanyRegistrationForm extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final signUpController = Get.find<SignUpController>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            controller: signUpController.companyNameController,
            decoration: const InputDecoration(
              labelText: 'Nombre de la empresa',
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
            controller: signUpController.rucController,
            decoration: const InputDecoration(
              labelText: 'RUC',
            ),
          ),
          TextFormField(
            controller: signUpController.direccionController,
            decoration: const InputDecoration(
              labelText: 'Dirección',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                signUpController.registerEmpresa();
              }
            },
            child: const Text('Registrar'),
          ),
        ],
      ),
    );
  }
}
