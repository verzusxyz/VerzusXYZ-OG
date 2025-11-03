import 'package:flutter/material.dart';
import 'package:verzusxyz/core/utils/dimensions.dart';
import 'package:verzusxyz/core/utils/my_color.dart';
import 'package:verzusxyz/core/utils/my_images.dart';
import 'package:verzusxyz/view/components/image/custom_network_image.dart';

class TrendingGamesCard extends StatelessWidget {
  final String myImage;
  const TrendingGamesCard({super.key, required this.myImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: Dimensions.space5),
      height: Dimensions.space80,
      width: Dimensions.space80,
      decoration: BoxDecoration(
        border: Border.all(color: MyColor.navBarActiveButtonColor, width: .3),
        borderRadius: BorderRadius.circular(Dimensions.space8),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Dimensions.space8),
        child: CustomNetworkImage(
          key: ValueKey(myImage),
          imageUrl: myImage,
          width: 200,
          height: 200,
          loaderColor: MyColor.activeIndicatorColor,
          placeholder: Image.asset(MyImages.placeHolderImage),
        ),
      ),
    );
  }
}
