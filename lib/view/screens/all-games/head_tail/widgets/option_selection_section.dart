import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:verzusxyz/core/utils/dimensions.dart';
import 'package:verzusxyz/core/utils/my_audio.dart';
import 'package:verzusxyz/core/utils/my_color.dart';
import 'package:verzusxyz/data/controller/all_games/head-tail/head_tail_controller.dart';
import 'package:verzusxyz/view/screens/all-games/widgets/option_selection_cotainer.dart';
import 'package:get/get.dart';

import '../../../../../core/utils/my_images.dart';

class OptionSelectionSection extends StatelessWidget {
  const OptionSelectionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HeadTailController>(
      builder: (controller) => Container(
        margin: const EdgeInsets.symmetric(vertical: Dimensions.space10),
        width: double.infinity,
        decoration: BoxDecoration(
          color: MyColor.secondaryPrimaryColor,
          borderRadius: BorderRadius.circular(Dimensions.space8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: OptionSelectionContainer(
                isSelected: controller.isUserChoiseIsHead != null
                    ? controller.isUserChoiseIsHead!
                    : false,
                images: MyImages.head,
                onTap: () {
                  AudioPlayer().play(AssetSource(MyAudio.clickAudio));
                  controller.amountFocusNode.unfocus();
                  controller.isUserChoiseIsHead = true;
                  controller.isUserChoiseIsTail = false;
                  controller.update();
                },
              ),
            ),
            Expanded(
              child: OptionSelectionContainer(
                isSelected: controller.isUserChoiseIsTail != null
                    ? controller.isUserChoiseIsTail!
                    : false,
                images: MyImages.tails,
                onTap: () {
                  AudioPlayer().play(AssetSource(MyAudio.clickAudio));
                  controller.amountFocusNode.unfocus();
                  controller.isUserChoiseIsHead = false;
                  controller.isUserChoiseIsTail = true;
                  controller.update();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
