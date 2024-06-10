
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helpu/src/constants/colors.dart';
import 'package:helpu/src/constants/sizes.dart';
import 'package:helpu/src/features/authetication/controller/on_board_controller.dart';
import 'package:helpu/src/features/authetication/model/model_on_board.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardScreen extends StatelessWidget {
  const OnBoardScreen({super.key});


  @override
  Widget build(BuildContext context) {
    final obController = OnBoardingController();

    obController.startAnimation();

    return Stack(
      alignment: Alignment.center,
      children: [
        LiquidSwipe(
          pages: obController.pages,
          onPageChangeCallback: obController.onPageChangeCallback,
          liquidController: obController.controller,
          slideIconWidget: const Icon(Icons.arrow_back_ios),
          enableSideReveal: true,
        ),
        Positioned(
          bottom: 150.0,
          child: OutlinedButton(
            onPressed: () => obController.animateToNextPage(),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              side: const BorderSide(color: Colors.black26),
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(20),
            ),
            child: Container(
              padding: const EdgeInsets.all(20.0),
              decoration: const BoxDecoration(
                  color: tDarkColor, shape: BoxShape.circle),
              child: const Icon(Icons.arrow_forward_ios),
            ),
          ),
        ),
        Positioned(
          top: 50.0,
          right: 20.0,
          child: TextButton(
            onPressed: () => obController.skip(),
            child: const Text(
              'Skip',
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ),
        Obx(
              () => Positioned(
            bottom: 10,
            child: AnimatedSmoothIndicator(
              activeIndex: obController.current.value,
              count: 3,
              effect: const ExpandingDotsEffect(
                activeDotColor: tDarkColor,
                dotColor: Colors.grey,
                dotHeight: 8,
                dotWidth: 8,
                spacing: 5,
              ),
            ),
          ),
        )
      ],
    );
  }


}

class OnBoardPageWidget extends StatelessWidget {
  const OnBoardPageWidget({super.key, required this.model});

  final OnBoardModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(tDefaultSize),
      color: model.bgColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(model.title, style: Theme.of(context).textTheme.titleLarge),
              Text(model.subtitle,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge),
              Text(model.counterText,
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: tDefaultSize * 2),
            ],
          )
        ],
      ),
    );
  }
}