import 'package:flutter/material.dart';
import 'package:verzusxyz/core/utils/dimensions.dart';
import 'package:verzusxyz/core/utils/style.dart';
import 'package:get/get.dart';

class KenoButtons extends StatelessWidget {
  final String text;
  final String image;
  final Color borderColor;

  const KenoButtons({
    super.key,
    required this.text,
    required this.image,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Dimensions.space10),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(Dimensions.space8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image, height: Dimensions.space15, color: borderColor),
          const SizedBox(width: Dimensions.space5),
          Text(
            text.tr,
            style: regularLarge.copyWith(
              color: borderColor,
              fontFamily: "Inter",
            ),
          ),
        ],
      ),
    );
  }
}
