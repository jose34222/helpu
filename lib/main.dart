import 'package:get_storage/get_storage.dart';
import 'package:helpu/firebase_options.dart';
import 'package:helpu/src/constants/colors.dart';
import 'package:helpu/src/repository/authentication_repository/authentication_repository.dart';
import 'package:helpu/src/repository/empresa_repository/empresa_repository.dart';
import 'package:helpu/src/repository/postulacion_repository/postulacion_repository.dart';
import 'package:helpu/src/repository/practica_repository/practica_repository.dart';
import 'package:helpu/src/repository/student_repository/student_repository.dart';
import 'package:helpu/src/repository/user_repository/user_repository.dart';
import 'package:helpu/src/utils/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) => Get.put(AuthenticationRepository()))
      .then((value) => Get.put(UserRepository()))
      .then((value) => Get.put(StudentRepository()))
      .then((value) => Get.put(EmpresaRepository()))
      .then((value) => Get.put(PostulacionRepository()))
      .then((value) => Get.put(PracticaRepository()));

  await GetStorage.init();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 1000),
      home: const Center(
        child: CircularProgressIndicator(
          color: tPrimaryColor,
        ),
      ),
    );
  }
}