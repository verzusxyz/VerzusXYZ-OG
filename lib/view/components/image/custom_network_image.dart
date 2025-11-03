import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:verzusxyz/core/utils/my_images.dart';
import 'package:verzusxyz/view/components/custom_loader/custom_loader.dart';

class CustomNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;
  final Color loaderColor;
  final Widget placeholder;
  final bool hasHeight;
  final bool coverImage;

  CustomNetworkImage({
    required this.imageUrl,
    required this.width,
    required this.height,
    required this.loaderColor,
    required this.placeholder,
    this.hasHeight = false,
    this.coverImage = true,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: hasHeight ? width : null,
      height: hasHeight ? height : null,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        placeholder: (context, url) =>
            Center(child: CustomLoader(loaderColor: loaderColor)),
        errorWidget: (context, url, error) =>
            Center(child: Image.asset(MyImages.placeHolderImage, height: 50)),
        fit: coverImage ? BoxFit.cover : null,
      ),
    );
  }
}
