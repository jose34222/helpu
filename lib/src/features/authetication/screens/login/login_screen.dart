
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helpu/src/common_widgets/form/form_footer.dart';
import 'package:helpu/src/common_widgets/form/form_header.dart';
import 'package:helpu/src/constants/image_strings.dart';
import 'package:helpu/src/constants/sizes.dart';
import 'package:helpu/src/constants/text_strings.dart';
import 'package:helpu/src/features/authetication/controller/login_controller.dart';
import 'package:helpu/src/features/authetication/screens/signup/signup_screen.dart';
import 'package:helpu/src/repository/authentication_repository/authentication_repository.dart';

import 'widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(tDefaultSize),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const FormHeader(
                  image: tWelcomeImage,
                  title: tLoginTitle,
                  subTitle: tLoginSubTitle,
                ),
                const LoginForm(),
                FormFooter(
                actionStudent: 'Crear Nuevo estudiante',
                onTapStudent: () {
                  // Navegación a la pantalla de registro
                  Get.to(() => const SignUpScreen(isCompany: false,));
                },
                  actionCompany: 'Crear nueva empresa',
                  onTapCompany: (){
                    Get.to(() => const SignUpScreen(isCompany: true));
                  },
              )

              ],
            ),
          ),
        ),
      ),
    );
  }
}