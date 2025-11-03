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

class DealerSection extends StatefulWidget {
  const DealerSection({super.key});

  @override
  State<DealerSection> createState() => _DealerSectionState();
}

class _DealerSectionState extends State<DealerSection> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BlackJackController>(
      builder: (controller) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            MyImages.delear,
            height: Dimensions.space70,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: Dimensions.space5),
          Text(
            MyStrings.delear.tr,
            style: regularMediumLarge.copyWith(color: MyColor.colorWhite),
          ),
          controller.showResult
              ? Text(
                  "${MyStrings.score.tr}:${controller.delearSum.tr}",
                  style: regularMediumLarge.copyWith(color: MyColor.colorWhite),
                )
              : const SizedBox(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              controller.isBackShow
                  ? const SizedBox()
                  : Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * .04,
                      ),
                      child: Image.asset(
                        MyImages.back,
                        height: MediaQuery.of(context).size.height * .085,
                        fit: BoxFit.contain,
                      ),
                    ),
              Expanded(
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.dealearCards.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                  ),
                  itemBuilder: (context, index) {
                    return CustomNetworkImage(
                      key: ValueKey(controller.dealearCards[index]),
                      imageUrl:
                          "${UrlContainer.blackJackCardsImage}${controller.dealearCards[index]}.png",
                      width: 200,
                      height: 200,
                      loaderColor: MyColor.activeIndicatorColor,
                      placeholder: Image.asset(MyImages.placeHolderImage),
                      hasHeight: false,
                      coverImage: false,
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
