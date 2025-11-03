import 'package:flutter/material.dart';
import 'package:verzusxyz/core/utils/style.dart';
import 'package:get/get.dart';
import 'package:verzusxyz/core/utils/my_color.dart';

/// A custom rounded button widget.
class RoundedButton extends StatelessWidget {
  /// Whether to change the color of the button.
  final bool isColorChange;

  /// The text to display on the button.
  final String text;

  /// The callback function to execute when the button is pressed.
  final VoidCallback press;

  /// The color of the button.
  final Color color;

  /// The color of the text.
  final Color? textColor;

  /// The width of the button as a fraction of the screen width.
  final double width;

  /// The horizontal padding of the button.
  final double horizontalPadding;

  /// The vertical padding of the button.
  final double verticalPadding;

  /// The corner radius of the button.
  final double cornerRadius;

  /// Whether the button is outlined.
  final bool isOutlined;

  /// Whether the button has a corner radius.
  final bool hasCornerRadious;

  /// The child widget to display inside the button.
  final Widget? child;

  /// Creates a new [RoundedButton] instance.
  const RoundedButton({
    Key? key,
    this.isColorChange = false,
    this.width = 1,
    this.child,
    this.cornerRadius = 6,
    required this.text,
    required this.press,
    this.isOutlined = false,
    this.hasCornerRadious = false,
    this.horizontalPadding = 35,
    this.verticalPadding = 18,
    this.color = MyColor.primaryColor,
    this.textColor = MyColor.colorWhite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return hasCornerRadious
        ? InkWell(
            onTap: press,
            splashColor: MyColor.getScreenBgColor(),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: verticalPadding,
              ),
              width: size.width * width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(cornerRadius),
                color: isColorChange ? color : MyColor.getPrimaryButtonColor(),
              ),
              child: Center(
                child: Text(
                  text.tr,
                  style: regularDefault.copyWith(
                    color: isColorChange
                        ? textColor
                        : MyColor.getPrimaryButtonTextColor(),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          )
        : isOutlined
            ? Material(
                child: InkWell(
                  onTap: press,
                  splashColor: MyColor.getScreenBgColor(),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                      vertical: verticalPadding,
                    ),
                    width: size.width * width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(cornerRadius),
                      color: isColorChange
                          ? color
                          : MyColor.getPrimaryButtonColor(),
                    ),
                    child: Center(
                      child: Text(
                        text.tr,
                        style: TextStyle(
                          color: isColorChange
                              ? textColor
                              : MyColor.getPrimaryButtonTextColor(),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : SizedBox(
                width: size.width * width,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(cornerRadius),
                  child: ElevatedButton(
                    onPressed: press,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: color,
                      shadowColor: MyColor.transparentColor,
                      padding: EdgeInsets.symmetric(
                        horizontal: horizontalPadding,
                        vertical: verticalPadding,
                      ),
                      textStyle: TextStyle(
                        color: textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    child: Text(text.tr, style: TextStyle(color: textColor)),
                  ),
                ),
              );
  }
}
