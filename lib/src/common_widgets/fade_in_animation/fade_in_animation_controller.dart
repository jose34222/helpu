import 'package:get/get.dart';
import 'package:helpu/src/features/authetication/screens/welcome/welcome.dart';

class FadeInAnimationController extends GetxController {
  static FadeInAnimationController get find => Get.find();

  RxBool animate = false.obs;

  Future startSplashAnimation() async {
    await Future.delayed(const Duration(milliseconds: 500));
    animate.value = true;
    await Future.delayed(const Duration(milliseconds: 3500));
    animate.value = false;
    await Future.delayed(const Duration(milliseconds: 2000));
    Get.off(
          () => const WelcomeScreen(),
      duration: const Duration(milliseconds: 1000), //Transition Time
      transition: Transition.fadeIn, //Screen Switch Transition
    );
  }

  Future animationIn() async {
    await Future.delayed(const Duration(milliseconds: 500));
    animate.value = true;
  }

  Future animationOut() async {
    animate.value = false;
    await Future.delayed(const Duration(milliseconds: 100));
  }
}