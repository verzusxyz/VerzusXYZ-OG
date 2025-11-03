import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:verzusxyz/core/utils/dimensions.dart';
import 'package:verzusxyz/core/utils/my_color.dart';
import 'package:verzusxyz/core/utils/my_images.dart';
import 'package:verzusxyz/view/components/custom_loader/custom_loader.dart';

class ImageWidgetWithFallback extends StatelessWidget {
  final String imageUrl;

  ImageWidgetWithFallback({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: Dimensions.space8),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        placeholder: (context, url) =>
            const Center(child: CustomLoader(loaderColor: MyColor.colorWhite)),
        errorWidget: (context, url, error) =>
            Center(child: Image.asset(MyImages.placeHolderImage, height: 50)),
        fit: BoxFit.fitWidth,
      ),
    );
  }
}
