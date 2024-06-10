
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helpu/src/common_widgets/fade_in_animation/animation_design.dart';
import 'package:helpu/src/common_widgets/fade_in_animation/fade_in_animation_controller.dart';
import 'package:helpu/src/common_widgets/fade_in_animation/fade_in_animation_model.dart';
import 'package:helpu/src/constants/colors.dart';
import 'package:helpu/src/constants/image_strings.dart';
import 'package:helpu/src/constants/sizes.dart';
import 'package:helpu/src/constants/text_strings.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FadeInAnimationController());
    controller.startSplashAnimation();

    return Scaffold(
      body: Stack(
        children: [
          TFadeInAnimation(
            durationInMs: 1600,
            animate: TAnimatePosition(
              topBefore: -30,
              topAfter: 0,
            ),
            child: const Image(
              image: AssetImage(tSplashTopIcon),
            ),
          ),
          TFadeInAnimation(
            durationInMs: 2000,
            animate: TAnimatePosition(
              topBefore: 80,
              topAfter: 80,
              leftBefore: -80,
              leftAfter: tDefaultSize,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(tAppName, style: Theme.of(context).textTheme.displaySmall),
                Text(tAppTagLine, style: Theme.of(context).textTheme.bodyLarge)
              ],
            ),
          ),
          TFadeInAnimation(
            durationInMs: 2400,
            animate: TAnimatePosition(bottomBefore: 0, bottomAfter: 100),
            child: Image(
              image: const AssetImage(tSplashImage),
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.7,
            ),
          ),
          TFadeInAnimation(
            durationInMs: 2400,
            animate: TAnimatePosition(
              bottomBefore: 0,
              bottomAfter: 60,
              rightBefore: tDefaultSize,
              rightAfter: tDefaultSize,
            ),
            child: Container(
              width: tSplashContainerSize,
              height: tSplashContainerSize,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: tPrimaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}