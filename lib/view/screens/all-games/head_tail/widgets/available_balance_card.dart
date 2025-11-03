import 'package:flutter/material.dart';
import 'package:verzusxyz/core/helper/string_format_helper.dart';
import 'package:verzusxyz/core/utils/dimensions.dart';
import 'package:verzusxyz/core/utils/my_color.dart';
import 'package:verzusxyz/core/utils/my_images.dart';
import 'package:verzusxyz/core/utils/my_strings.dart';
import 'package:verzusxyz/core/utils/style.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class AvailableBalanceCard extends StatelessWidget {
  final String balance;
  final String curSymbol;

  const AvailableBalanceCard({
    super.key,
    required this.balance,
    required this.curSymbol,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Dimensions.space8),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: SvgPicture.asset(MyImages.totalInvestSvg, height: 35),
            ),
          ),
          const SizedBox(width: 5),
          Expanded(
            flex: 8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  MyStrings.availableBalance.tr,
                  style: regularSmall.copyWith(
                    color: MyColor.colorWhite,
                    fontFamily: 'Inter',
                  ),
                ),
                Text(
                  "$curSymbol${Converter.formatNumber(balance)}",
                  style: semiBoldLarge.copyWith(
                    color: MyColor.navBarActiveButtonColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
