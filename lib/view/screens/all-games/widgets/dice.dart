import 'package:flutter/material.dart';
import 'package:verzusxyz/data/controller/all_games/dice_rolling_controller.dart';
import 'package:get/get.dart';

class Dice extends StatefulWidget {
  const Dice({super.key});

  @override
  State<Dice> createState() => _DiceState();
}

class _DiceState extends State<Dice> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DiceRollingController>(
      builder: (controller) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Transform.rotate(
            angle: controller.isSubmitted
                ? controller.random.nextDouble() * 180
                : controller.rotationAngleDiceAngle,
            child: Image.asset(
              controller.myOptionsImage[controller.currentImageIndex],
              height: 100,
            ),
          ),
        ],
      ),
    );
  }
}
