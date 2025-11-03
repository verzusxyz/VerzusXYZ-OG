import 'package:flutter/material.dart';
import 'package:verzusxyz/core/utils/dimensions.dart';
import 'package:verzusxyz/core/utils/util.dart';

/// A custom card widget.
class CustomCard extends StatefulWidget {
  /// The padding on the left side of the card.
  final double paddingLeft;

  /// The padding on the right side of the card.
  final double paddingRight;

  /// The padding on the top side of the card.
  final double paddingTop;

  /// The padding on the bottom side of the card.
  final double paddingBottom;

  /// The width of the card.
  final double width;

  /// The radius of the card's corners.
  final double radius;

  /// The callback function to execute when the card is pressed.
  final VoidCallback? onPressed;

  /// The child widget to display inside the card.
  final Widget child;

  /// Whether the card is pressable.
  final bool isPress;

  /// Creates a new [CustomCard] instance.
  const CustomCard({
    Key? key,
    required this.width,
    this.paddingLeft = Dimensions.space15,
    this.paddingRight = Dimensions.space15,
    this.paddingTop = Dimensions.space15,
    this.paddingBottom = Dimensions.space15,
    this.radius = Dimensions.cardRadius,
    this.onPressed,
    this.isPress = false,
    required this.child,
  }) : super(key: key);

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  @override
  Widget build(BuildContext context) {
    return widget.isPress
        ? GestureDetector(
            onTap: widget.onPressed,
            child: Container(
              width: widget.width,
              padding: EdgeInsets.only(
                left: widget.paddingLeft,
                right: widget.paddingRight,
                top: widget.paddingTop,
                bottom: widget.paddingBottom,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(widget.radius),
                boxShadow: MyUtils.getCardShadow(),
              ),
              child: widget.child,
            ),
          )
        : Container(
            width: widget.width,
            padding: EdgeInsets.only(
              left: widget.paddingLeft,
              right: widget.paddingRight,
              top: widget.paddingTop,
              bottom: widget.paddingBottom,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.radius),
              boxShadow: MyUtils.getCardShadow(),
            ),
            child: widget.child,
          );
  }
}
