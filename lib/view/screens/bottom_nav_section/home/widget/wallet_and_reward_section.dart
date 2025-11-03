import 'package:flutter/material.dart';
import 'package:verzusxyz/core/helper/string_format_helper.dart';
import 'package:verzusxyz/core/utils/dimensions.dart';
import 'package:verzusxyz/core/utils/my_color.dart';
import 'package:verzusxyz/core/utils/my_images.dart';
import 'package:verzusxyz/core/utils/my_strings.dart';
import 'package:verzusxyz/core/utils/style.dart';
import 'package:verzusxyz/data/controller/home/home_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class WalletAndRewardSection extends StatefulWidget {
  const WalletAndRewardSection({super.key});

  @override
  State<WalletAndRewardSection> createState() => _WalletAndRewardSectionState();
}

class _WalletAndRewardSectionState extends State<WalletAndRewardSection> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) => Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: MyColor.primaryButtonColor),
              color: MyColor.colorWhite,
              borderRadius: BorderRadius.circular(Dimensions.space12),
            ),
            padding: const EdgeInsets.all(Dimensions.space10),
            width: double.infinity,
            child: Row(
              children: [
                SizedBox(
                  height: Dimensions.space50,
                  child: SvgPicture.asset(MyImages.walletSvg),
                ),
                const SizedBox(width: Dimensions.space10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(MyStrings.walletBalances.tr, style: regularDefault),
                    Text(
                      controller.defaultCurrencySymbol +
                          Converter.formatNumber(controller.totalBalance),
                      style: semiBoldExtraLarge.copyWith(
                        color: MyColor.primaryButtonColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
