import 'package:flutter/material.dart';
import 'package:verzusxyz/core/utils/dimensions.dart';
import 'package:verzusxyz/core/utils/my_color.dart';
import 'package:verzusxyz/core/utils/my_images.dart';

class SelectBetButton extends StatelessWidget {
  final Color buttonColor;
  final bool isSelected;
  final VoidCallback onTap;

  const SelectBetButton({
    Key? key,
    required this.buttonColor,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(Dimensions.space5),
        decoration: BoxDecoration(
          color: MyColor.bottomColor,
          borderRadius: BorderRadius.circular(Dimensions.space8),
          border: Border.all(
            color: isSelected
                ? MyColor.navBarActiveButtonColor
                : MyColor.colorBorder,
          ),
        ),
        child: Container(
          margin: const EdgeInsets.all(Dimensions.space10),
          padding: const EdgeInsets.all(Dimensions.space10),
          decoration: BoxDecoration(color: buttonColor, shape: BoxShape.circle),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: MyColor.colorBgCard,
                width: Dimensions.space6,
              ),
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(Dimensions.space25),
            child: Image.asset(
              MyImages.dollar,
              height: Dimensions.space20,
              width: Dimensions.space20,
            ),
          ),
        ),
      ),
    );
  }
}
