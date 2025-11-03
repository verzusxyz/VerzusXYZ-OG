import 'package:flutter/material.dart';
import 'package:verzusxyz/core/utils/style.dart';
import 'package:get/get.dart';

import '../../../core/utils/my_color.dart';
import '../../screens/withdraw/widget/status_widget.dart';
import '../divider/custom_divider.dart';

/// A custom row widget that displays two text elements.
class CustomRow extends StatelessWidget {
  /// The first text element to display.
  final String firstText;

  /// The last text element to display.
  final String lastText;

  /// Whether the row represents a status.
  final bool isStatus;

  /// Whether the row is used in an "about" section.
  final bool isAbout;

  /// Whether to show a divider below the row.
  final bool showDivider;

  /// The color of the status text.
  final Color? statusTextColor;

  /// Whether the row has a child widget.
  final bool hasChild;

  /// The child widget to display in the row.
  final Widget? child;

  /// Creates a new [CustomRow] instance.
  const CustomRow({
    Key? key,
    this.child,
    this.hasChild = false,
    this.statusTextColor,
    required this.firstText,
    required this.lastText,
    this.isStatus = false,
    this.isAbout = false,
    this.showDivider = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return hasChild
        ? Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      firstText.tr,
                      style: regularDefault.copyWith(
                        color: MyColor.getTextColor(),
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  child ?? const SizedBox(),
                ],
              ),
              const SizedBox(height: 5),
              showDivider
                  ? const Divider(color: MyColor.borderColor)
                  : const SizedBox(),
              showDivider ? const SizedBox(height: 5) : const SizedBox(),
            ],
          )
        : isAbout
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    firstText.tr,
                    style: regularDefault.copyWith(color: MyColor.colorWhite),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    lastText.tr,
                    style: regularDefault.copyWith(
                      fontFamily: "Inter",
                      color: isStatus ? statusTextColor : MyColor.colorWhite,
                    ),
                  ),
                  const SizedBox(height: 5),
                ],
              )
            : Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          firstText.tr,
                          style: regularDefault.copyWith(
                            color: MyColor.colorWhite,
                            fontFamily: 'Inter',
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      isStatus
                          ? StatusWidget(
                              status: lastText, color: MyColor.greenP)
                          : Flexible(
                              child: Text(
                                lastText.tr,
                                maxLines: 2,
                                style: regularDefault.copyWith(
                                  fontFamily: "Inter",
                                  color: isStatus
                                      ? MyColor.greenSuccessColor
                                      : MyColor.colorWhite,
                                ),
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.end,
                              ),
                            ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  showDivider ? const CustomDivider() : const SizedBox(),
                  showDivider ? const SizedBox(height: 5) : const SizedBox(),
                ],
              );
  }
}
