
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helpu/src/features/authetication/screens/welcome/welcome.dart';
import 'package:helpu/src/features/core/screens/dashboard/dashboard.dart';
import 'package:helpu/src/features/core/screens/dashboard/dashboard1.dart';
import 'package:helpu/src/repository/authentication_repository/exceptions/signup_email_password_failure.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;

  var verificationId = ''.obs;
  bool isStudent = true;
  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    user == null
        ? Get.offAll(() => const WelcomeScreen())
        : Rol.isStudent
        ? Get.offAll(() => const Dashboard1())
        : Get.offAll(() => const Dashboard());
  }

  Future<void> phoneAuthentication(String phoneNo) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNo,
      verificationCompleted: (credential) async {
        await _auth.signInWithCredential(credential);
        firebaseUser.value != null
            ? Get.offAll(() => const Dashboard())
            : Get.offAll(() => const WelcomeScreen());
      },
      verificationFailed: (e) {
        if (e.code == 'invalid-phone-number') {
          Get.snackbar('Error', 'The provided phone number is not valid.');
        } else {
          Get.snackbar('Error', 'Error: ${e.message}');
        }
      },
      codeSent: (verificationId, resendToken) {
        this.verificationId.value = verificationId;
      },
      codeAutoRetrievalTimeout: (verificationId) {
        print('Time Out');
      },
    );
  }

  Future<bool> verifyOtp(String otp) async {
    var credentials = await _auth.signInWithCredential(
        PhoneAuthProvider.credential(
            verificationId: verificationId.value, smsCode: otp));

    return credentials.user != null;
  }

  Future<void> createUserWithEmailAndPassword(
      String email, String password, bool isStudent) async {
    Rol.setIsStudent(isStudent);
    try {

      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseException catch (e) {
      final ex = SignUpWithEmailAndPasswordFailure.code(e.code);
      print('FIREBASE EXCEPTION: ${ex.message}');
      throw ex;
    } catch (_) {
      final ex = SignUpWithEmailAndPasswordFailure();
      print('EXCEPTION: ${ex.message}');
      throw ex;
    }
  }

  Future<void> loginUserWithEmailAndPassword(
      String email, String password) async {
    try {
      checkAccountType(email);
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      firebaseUser.value == null
          ? Get.offAll(() => const WelcomeScreen())
          : Rol.isStudent
          ? Get.offAll(() => const Dashboard())
          : Get.offAll(() => const Dashboard1());
    } on FirebaseException catch (e) {
      final ex = SignUpWithEmailAndPasswordFailure.code(e.code);
      print('FIREBASE EXCEPTION: ${ex.message}');
      throw ex;
    } catch (_) {
      final ex = SignUpWithEmailAndPasswordFailure();
      print('EXCEPTION: ${ex.message}');
      throw ex;
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      // Inicializa GoogleSignIn
      final GoogleSignIn googleSignIn = GoogleSignIn();

      // Solicita al usuario que inicie sesión con Google
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      // Si el usuario cancela el inicio de sesión, googleUser será nulo
      if (googleUser != null) {
        // Obtiene la autenticación de Google
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

        // Crea las credenciales de Firebase con los tokens de Google
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        // Autentica al usuario con Firebase usando las credenciales de Google
        final userCreds = await FirebaseAuth.instance.signInWithCredential(credential);

        // Si la autenticación es exitosa, el usuario será autenticado
        if (userCreds.user != null) {
          print("Se realizó un login exitoso");
        } else {
          print("No se pudo realizar el login");
        }
      } else {
        print("El usuario canceló el inicio de sesión con Google");
      }
    } catch (error) {
      print("Error al iniciar sesión con Google: $error");
    }
  }

  void checkAccountType(String email) async {
    // Consulta en la colección de estudiantes
    final studentQuery = await FirebaseFirestore.instance
        .collection('Students')
        .where('UserId', isEqualTo: email)
        .get();

    // Consulta en la colección de empresas
    final empresaQuery = await FirebaseFirestore.instance
        .collection('Empresas')
        .where('UserId', isEqualTo: email)
        .get();

    // Verifica si se encontró el correo en alguna colección
    if (studentQuery.docs.isNotEmpty) {
      // Si se encontró el correo en la colección de estudiantes, devuelve "Estudiante"
      Rol.setIsStudent(true);
    } else if (empresaQuery.docs.isNotEmpty) {
      // Si se encontró el correo en la colección de empresas, devuelve "Empresa"
      Rol.setIsStudent(false);
    } else {
      // Si no se encontró el correo en ninguna colección, devuelve null
    }
  }

  Future<void> logOut() async => await _auth.signOut();
}

class Rol {
  static bool _isStudent = true;

  static bool get isStudent => _isStudent;

  static void setIsStudent(bool value) {
    _isStudent = value;
  }
}