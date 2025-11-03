import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:verzusxyz/core/utils/dimensions.dart';
import 'package:verzusxyz/core/utils/my_color.dart';
import 'package:verzusxyz/core/utils/style.dart';

import '../../../../components/image/custom_svg_picture.dart';

class MenuItems extends StatelessWidget {
  final String imageSrc;
  final String label;
  final VoidCallback onPressed;
  final bool isSvgImage;

  const MenuItems({
    Key? key,
    required this.imageSrc,
    required this.label,
    required this.onPressed,
    this.isSvgImage = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.space5),
        color: MyColor.transparentColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  height: Dimensions.space35,
                  width: Dimensions.space35,
                  alignment: Alignment.center,

                  child: isSvgImage
                      ? CustomSvgPicture(
                          image: imageSrc,
                          color: MyColor.navBarActiveButtonColor,
                          height: Dimensions.space20,
                          width: Dimensions.space17,
                        )
                      : Image.asset(
                          imageSrc,
                          color: MyColor.colorWhite,
                          height: Dimensions.space17,
                          width: Dimensions.space17,
                        ),
                ),
                const SizedBox(width: Dimensions.space15),
                Text(
                  label.tr,
                  style: regularDefault.copyWith(color: MyColor.colorWhite),
                ),
              ],
            ),
            Container(
              height: Dimensions.space30,
              width: Dimensions.space30,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: MyColor.transparentColor,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_forward_ios_rounded,
                color: MyColor.colorWhite,
                size: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
