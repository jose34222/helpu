
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helpu/src/features/core/screens/dashboard/dashboard_student.dart';
import 'package:helpu/src/repository/authentication_repository/authentication_repository.dart';

class OTPController extends GetxController {
  static OTPController get instance => Get.find();

  final otp = TextEditingController();

  void verifyOtp(String otp) async {
    bool isVerified = await AuthenticationRepository.instance.verifyOtp(otp);

    isVerified ? Get.offAll(() => const DashboardStudent()) : Get.back();
  }
}