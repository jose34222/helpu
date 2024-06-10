
import 'package:get/get.dart';
import 'package:helpu/src/constants/colors.dart';
import 'package:helpu/src/constants/text_strings.dart';
import 'package:helpu/src/features/authetication/model/model_on_board.dart';
import 'package:helpu/src/features/authetication/screens/on_boarding/on_boarding_screen.dart';
import 'package:helpu/src/features/authetication/screens/welcome/welcome.dart';
import 'package:liquid_swipe/PageHelpers/LiquidController.dart';

class OnBoardingController extends GetxController {
  final controller = LiquidController();

  RxInt current = 0.obs;

  RxInt nextPage = 0.obs;

  final pages = [
    OnBoardPageWidget(
      model: OnBoardModel(
        title: tOnBoardingTitle1,
        subtitle: tOnBoardingSubTitle1,
        counterText: tOnBoardingCounter1,
        bgColor: tOnBoardingPage1Color,
      ),
    ),
    OnBoardPageWidget(
      model: OnBoardModel(
        title: tOnBoardingTitle2,
        subtitle: tOnBoardingSubTitle2,
        counterText: tOnBoardingCounter2,
        bgColor: tOnBoardingPage2Color,
      ),
    ),
    OnBoardPageWidget(
      model: OnBoardModel(
        title: tOnBoardingTitle3,
        subtitle: tOnBoardingSubTitle3,
        counterText: tOnBoardingCounter3,
        bgColor: tOnBoardingPage3Color,
      ),
    ),
  ];

  void onPageChangeCallback(int activePageIndex) {
    current.value = activePageIndex;
  }
  skip () => controller.jumpToPage(page: 2);
  animateToNextPage () {
    nextPage.value = controller.currentPage + 1;
    controller.animateToPage(page: nextPage.value, duration: 500);
  }
  Future startAnimation() async {
    while(current.value < pages.length){
      await Future.delayed(const Duration(milliseconds: 5000));
      if(controller.currentPage == pages.length-1){
        Get.to(()=> const WelcomeScreen());
      }
      animateToNextPage();
    }
  }
}