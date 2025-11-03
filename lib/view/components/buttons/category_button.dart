import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:verzusxyz/core/utils/dimensions.dart';
import 'package:verzusxyz/core/utils/my_color.dart';
import 'package:verzusxyz/core/utils/style.dart';

/// A custom button widget for categories.
class CategoryButton extends StatelessWidget {
  /// The text to display on the button.
  final String text;

  /// The callback function to execute when the button is pressed.
  final VoidCallback press;

  /// The color of the button.
  final Color color;

  /// The color of the text.
  final Color textColor;

  /// The horizontal padding of the button.
  final double horizontalPadding;

  /// The vertical padding of the button.
  final double verticalPadding;

  /// The font size of the text.
  final double textSize;

  /// Creates a new [CategoryButton] instance.
  const CategoryButton({
    Key? key,
    required this.text,
    this.horizontalPadding = 3,
    this.verticalPadding = 3,
    this.textSize = Dimensions.fontSmall,
    required this.press,
    this.color = MyColor.primaryColor,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(4),
      child: InkWell(
        onTap: press,
        borderRadius: BorderRadius.circular(4),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: verticalPadding,
          ),
          decoration: BoxDecoration(
            color: MyColor.transparentColor,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            text.tr,
            style: regularDefault.copyWith(
              color: textColor,
              fontSize: textSize,
            ),
          ),
        ),
      ),
    );
  }
}
