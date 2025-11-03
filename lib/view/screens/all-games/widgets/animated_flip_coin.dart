import 'dart:math';

import 'package:flutter/material.dart';
import 'package:verzusxyz/core/utils/my_images.dart';
import 'package:verzusxyz/data/controller/all_games/head-tail/head_tail_controller.dart';
import 'package:get/get.dart';

class CoinToss extends StatefulWidget {
  const CoinToss({Key? key}) : super(key: key);

  @override
  State<CoinToss> createState() => _CoinTossState();
}

class _CoinTossState extends State<CoinToss>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    final controller = Get.put(HeadTailController(headTailRepo: Get.find()));
    controller.animationController = AnimationController(
      duration: Duration(seconds: controller.isSubmitted ? 2 : 5),
      vsync: this,
    );
    controller.animation =
        Tween(begin: 0.0, end: pi * 20).animate(controller.animationController)
          ..addListener(() {
            setState(() {});
          });

    controller.isAnimationShouldRunning = true;
    controller.animationController.repeat();
  }

  @override
  void dispose() {
    final controller = Get.put(HeadTailController(headTailRepo: Get.find()));
    controller.animationController.dispose();
    super.dispose();
  }

  Widget _buildCoin() {
    return GetBuilder<HeadTailController>(
      builder: (controller) {
        // Calculate the angle based on the current progress of the animation
        double rotationAngle = controller.animation.value % (2 * pi);

        // Determine whether to show head or tail based on the rotation angle
        bool isHeadVisible = rotationAngle < pi;

        return Stack(
          children: [
            // Display head
            if (isHeadVisible)
              Transform(
                transform: Matrix4.rotationY(rotationAngle),
                alignment: Alignment.center,
                child: Opacity(
                  opacity: 1.0,
                  child: Image.asset(MyImages.head, width: 150, height: 150),
                ),
              ),
            // Display tail
            if (!isHeadVisible)
              Transform(
                transform: Matrix4.rotationY(rotationAngle - pi),
                alignment: Alignment.center,
                child: Opacity(
                  opacity: 1.0,
                  child: Image.asset(MyImages.tails, width: 150, height: 150),
                ),
              ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HeadTailController>(
      builder: (controller) => Center(
        child: controller.isAnimationShouldRunning
            ? _buildCoin()
            : Image.asset(
                controller.isAdminSelectHead ? MyImages.head : MyImages.tails,
                width: 150,
                height: 150,
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
