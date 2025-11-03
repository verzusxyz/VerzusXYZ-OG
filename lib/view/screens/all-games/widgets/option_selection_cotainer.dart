import 'package:flutter/material.dart';
import 'package:verzusxyz/core/utils/dimensions.dart';
import 'package:verzusxyz/core/utils/my_color.dart';

class OptionSelectionContainer extends StatelessWidget {
  final String images;
  final VoidCallback? onTap;
  final bool isSelected;

  const OptionSelectionContainer({
    Key? key,
    required this.images,
    this.onTap,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.space6,
          vertical: Dimensions.space10,
        ),
        margin: const EdgeInsets.all(Dimensions.space10),
        decoration: BoxDecoration(
          color: MyColor.bottomColor,
          borderRadius: BorderRadius.circular(Dimensions.space8),
          border: Border.all(
            width: 2,
            color: isSelected
                ? MyColor.navBarActiveButtonColor
                : MyColor.colorBorder,
          ),
        ),
        child: Image.asset(images, height: Dimensions.space70),
      ),
    );
  }
}
