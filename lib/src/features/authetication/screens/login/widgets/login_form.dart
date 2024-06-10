
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helpu/src/constants/sizes.dart';
import 'package:helpu/src/constants/text_strings.dart';
import 'package:helpu/src/features/authetication/controller/login_controller.dart';
import 'package:helpu/src/features/authetication/screens/forget_password/forget_password_options/forget_password_model_sheet.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final loginController = Get.put(LoginController());
  final formKey = GlobalKey<FormState>();
  String _selectedUserType = 'Usuario';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: tDefaultSize - 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButton<String>(
              value: _selectedUserType,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedUserType = newValue!;
                });
              },
              items: <String>['Usuario', 'Empresa']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: tDefaultSize - 20),
            TextFormField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.mail_outline_rounded),
                labelText: tLoginEmail,
                hintText: tLoginEmail,
              ),
              controller: loginController.email,
            ),
            const SizedBox(height: tDefaultSize - 20),
            TextFormField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.lock),
                labelText: tLoginPassword,
                hintText: tLoginPassword,
                suffixIcon:
                IconButton(onPressed: null, icon: Icon(Icons.remove_red_eye_sharp)),
              ),
              controller: loginController.password,
            ),
            const SizedBox(height: tDefaultSize - 20),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  ForgetPasswordScreen.buildShowModalBottomSheet(context);
                },
                child: const Text(tLoginForgotPassword, style: TextStyle(color: Colors.blue)),
              ),
            ),
            const SizedBox(height: tDefaultSize - 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  LoginController.instance.loginUser();
                },
                style: Theme.of(context).elevatedButtonTheme.style,
                child: Text(tLoginButton.toUpperCase()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}