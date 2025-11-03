import 'package:flutter/material.dart';
import 'package:verzusxyz/core/utils/dimensions.dart';
import 'package:verzusxyz/core/utils/my_color.dart';
import 'package:verzusxyz/core/utils/style.dart';
import 'package:verzusxyz/view/components/custom_loader/custom_loader.dart';
import 'package:get/get.dart';

class Buttons extends StatelessWidget {
  final String text;
  final Color color;
  final Color loaderColor;
  final bool isLoading;
  const Buttons({
    super.key,
    required this.text,
    required this.color,
    this.loaderColor = MyColor.redColor,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.space10,
        vertical: Dimensions.space10,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(Dimensions.space8),
      ),
      child: Center(
        child: isLoading
            ? CustomLoader(loaderColor: loaderColor)
            : Text(text.tr, style: regularLarge.copyWith(color: color)),
      ),
    );
  }
}
