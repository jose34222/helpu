
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helpu/src/constants/sizes.dart';
import 'package:helpu/src/features/authetication/controller/signup_controller.dart';
import 'package:helpu/src/features/authetication/screens/signup/widgets/company_form.dart';
import 'package:helpu/src/features/authetication/screens/signup/widgets/user_form.dart';

import '../../model/empresa_model.dart';
import '../../model/user_model.dart';

class SignUpScreen extends StatefulWidget {
  final bool isCompany;
  const SignUpScreen({super.key, required this.isCompany});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {


  @override
  Widget build(BuildContext context) {
    Get.lazyPut(()=>SignUpController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(tDefaultSize),
        child: Column(
          children: [
            if (widget.isCompany)
              CompanyRegistrationForm()
            else
              UserRegistrationForm(),
          ],
        ),
      ),
    );
  }
}