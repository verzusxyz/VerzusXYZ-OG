import 'package:flutter/material.dart';
import 'package:verzusxyz/core/utils/dimensions.dart';
import 'package:verzusxyz/core/utils/my_color.dart';
import 'package:verzusxyz/core/utils/my_images.dart';
import 'package:verzusxyz/core/utils/my_strings.dart';
import 'package:verzusxyz/core/utils/style.dart';
import 'package:verzusxyz/core/utils/url_container.dart';
import 'package:verzusxyz/data/controller/all_games/black_jack/black_jack_controller.dart';
import 'package:verzusxyz/view/components/image/custom_network_image.dart';
import 'package:get/get.dart';

class MySection extends StatefulWidget {
  const MySection({super.key});

  @override
  State<MySection> createState() => _MySectionState();
}

class _MySectionState extends State<MySection> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BlackJackController>(
      builder: (controller) => Column(
        children: [
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,

            itemCount: controller.myScrenCards.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              return CustomNetworkImage(
                key: ValueKey(controller.myScrenCards[index]),
                imageUrl:
                    "${UrlContainer.blackJackCardsImage}${controller.myScrenCards[index]}.png",
                width: 200,
                height: 200,
                loaderColor: MyColor.activeIndicatorColor,
                placeholder: Image.asset(MyImages.placeHolderImage),
                hasHeight: false,
                coverImage: false,
              );
            },
          ),
          const SizedBox(height: Dimensions.space30),
          Image.asset(
            MyImages.you,
            height: Dimensions.space70,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: Dimensions.space5),
          Text(
            MyStrings.you.tr,
            style: regularMediumLarge.copyWith(color: MyColor.colorWhite),
          ),
          controller.showResult
              ? Text(
                  "${MyStrings.score.tr}:${controller.userSum.tr}",
                  style: regularMediumLarge.copyWith(color: MyColor.colorWhite),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
