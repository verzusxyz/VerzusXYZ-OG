import 'package:flutter/material.dart';
import 'package:verzusxyz/core/utils/dimensions.dart';
import 'package:verzusxyz/core/utils/my_color.dart';
import 'package:verzusxyz/core/utils/my_images.dart';
import 'package:verzusxyz/core/utils/style.dart';
import 'package:verzusxyz/view/components/buttons/rounded_button.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class NoDataTile extends StatelessWidget {
  final String title;
  final String buttonText;
  final VoidCallback? onTap;
  final bool hasActionButton;
  final double height;
  const NoDataTile({
    super.key,
    required this.title,
    this.onTap,
    this.hasActionButton = false,
    this.buttonText = "",
    this.height = 200,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimensions.space8),
      child: Column(
        children: [
          Container(
            height: height,
            padding: const EdgeInsets.symmetric(vertical: Dimensions.space15),
            decoration: const BoxDecoration(
              color: MyColor.searchFieldColor,
              borderRadius: BorderRadius.all(
                Radius.circular(Dimensions.space8),
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    MyImages.noDataImage,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(height: Dimensions.space10),
                  Text(
                    title.tr ?? "",
                    style: regularDefault.copyWith(
                      color: MyColor.colorWhite,
                      fontFamily: "Inter",
                    ),
                  ),
                  const SizedBox(height: Dimensions.space24),
                  hasActionButton
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: RoundedButton(
                            hasCornerRadious: true,
                            isColorChange: true,
                            textColor: MyColor.colorBlack,
                            verticalPadding: Dimensions.space15,
                            cornerRadius: Dimensions.space8,
                            color: MyColor.primaryButtonColor,
                            text: buttonText,
                            press: onTap ?? () {},
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          ),
          const SizedBox(height: Dimensions.space30),
        ],
      ),
    );
  }
}
