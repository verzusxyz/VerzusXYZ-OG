import 'package:flutter/material.dart';
import 'package:verzusxyz/core/helper/string_format_helper.dart';
import 'package:verzusxyz/core/utils/dimensions.dart';
import 'package:verzusxyz/core/utils/my_color.dart';
import 'package:verzusxyz/core/utils/my_images.dart';
import 'package:verzusxyz/core/utils/my_strings.dart';
import 'package:verzusxyz/core/utils/style.dart';
import 'package:verzusxyz/core/utils/util.dart';
import 'package:get/get.dart';

class MinimumMaximumBonusSection extends StatelessWidget {
  final String minimum;
  final String maximum;
  final String winAmount;
  final String bonusAmount;
  final String currencySym;
  final bool haswinAmount;
  final bool hasBonusAmount;
  final bool showMinimumAndMaximum;
  const MinimumMaximumBonusSection({
    super.key,
    required this.minimum,
    required this.maximum,
    required this.winAmount,
    required this.haswinAmount,
    this.bonusAmount = "",
    this.currencySym = "",
    this.showMinimumAndMaximum = true,
    this.hasBonusAmount = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            showMinimumAndMaximum
                ? Padding(
                    padding: const EdgeInsets.only(bottom: Dimensions.space18),
                    child: Image.asset(
                      MyImages.info,
                      color: MyColor.colorWhite,
                      height: Dimensions.space18,
                    ),
                  )
                : const SizedBox(),
            const SizedBox(width: Dimensions.space5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                showMinimumAndMaximum
                    ? Text(
                        "${MyStrings.minimum.tr}: ${Converter.formatNumber(minimum)} $currencySym | ${MyStrings.maximum.tr}: ${Converter.formatNumber(maximum)} $currencySym",
                        style: regularDefault.copyWith(
                          color: MyColor.colorWhite,
                          fontFamily: "Inter",
                        ),
                      )
                    : const SizedBox(),
                haswinAmount
                    ? Text(
                        "${MyStrings.winPerce.tr} ${Converter.formatNumber(winAmount)}${MyUtils.getPercentSign()}",
                        style: regularDefault.copyWith(
                          color: MyColor.inActiveIndicatorColor,
                          fontFamily: "Inter",
                        ),
                      )
                    : bonusAmount != "" && hasBonusAmount
                    ? Text(
                        "${MyStrings.getBonus.tr}$bonusAmount $currencySym",
                        style: regularDefault.copyWith(
                          color: MyColor.inActiveIndicatorColor,
                          fontFamily: "Inter",
                        ),
                      )
                    : const SizedBox(height: Dimensions.space15),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
