import 'package:flutter/material.dart';
import 'package:verzusxyz/core/utils/my_images.dart';
import 'package:verzusxyz/core/utils/url_container.dart';
import 'package:verzusxyz/data/controller/all_games/card_finding/card_finding_controller.dart';
import 'package:get/get.dart';
import 'package:show_up_animation/show_up_animation.dart';

class CardSection extends StatefulWidget {
  const CardSection({super.key});

  @override
  State<CardSection> createState() => _CardSectionState();
}

class _CardSectionState extends State<CardSection> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CardFindingController>(
      builder: (controller) => Column(
        children: [
          controller.showDesiredColor
              ? controller.buildCardImage(controller.desiredColor)
              : const SizedBox(),
          controller.isShuffleIngCards
              ? const SizedBox()
              : controller.showDesiredColor
              ? const SizedBox()
              : ShowUpAnimation(
                  delayStart: const Duration(seconds: 1),
                  animationDuration: const Duration(seconds: 1),
                  curve: Curves.easeInCubic,
                  direction: Direction.vertical,
                  offset: 0.5,
                  child: GridView.builder(
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.displayCards.length,
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5,
                        ),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Image.network(
                          "${UrlContainer.displayCardImage}${controller.displayCards[index]}.png",
                        ),
                      );
                    },
                  ),
                ),
          controller.isShuffleIngCards
              ? Image.asset(MyImages.cardShuffle)
              : const SizedBox(),
        ],
      ),
    );
  }
}
