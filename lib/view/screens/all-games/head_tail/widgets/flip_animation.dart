import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:verzusxyz/core/utils/my_images.dart';
import 'package:verzusxyz/data/controller/all_games/head-tail/head_tail_controller.dart';
import 'package:get/get.dart';

class FlipAnimation extends StatefulWidget {
  const FlipAnimation({super.key});

  @override
  State<FlipAnimation> createState() => _FlipAnimationState();
}

class _FlipAnimationState extends State<FlipAnimation> {
  final cardKey = GlobalKey<FlipCardState>();
  late Timer timer;
  int totalRotate = 0;
  int maxRotate = Random().nextInt(30) + 70;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HeadTailController>(
      builder: (controller) {
        return FlipCard(
          key: cardKey,
          controller: controller.flipController,
          fill: Fill
              .fillBack, // Fill the back side of the card to make in the same size as the front.
          direction: FlipDirection.HORIZONTAL, // default
          side: CardSide.BACK, // The side to initially display.
          flipOnTouch: false,
          speed: 70,
          front: Image.asset(
            MyImages.head,
            width: 150,
            height: 150,
            fit: BoxFit.cover,
          ),
          back: Image.asset(
            MyImages.tails,
            width: 150,
            height: 150,
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}
