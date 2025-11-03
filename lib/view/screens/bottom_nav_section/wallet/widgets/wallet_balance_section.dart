import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:verzusxyz/core/helper/string_format_helper.dart';
import 'package:verzusxyz/core/utils/dimensions.dart';
import 'package:verzusxyz/core/utils/my_color.dart';
import 'package:verzusxyz/core/utils/my_images.dart';
import 'package:verzusxyz/core/utils/my_strings.dart';
import 'package:verzusxyz/core/utils/style.dart';
import 'package:verzusxyz/data/controller/wallet/wallet_screen_controller.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class WalletBalance extends StatefulWidget {
  const WalletBalance({super.key});

  @override
  State<WalletBalance> createState() => _WalletBalanceState();
}

class _WalletBalanceState extends State<WalletBalance> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<WalletScreencontroller>(
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
                Expanded(
                  child: Row(
                    children: [
                      SizedBox(
                        height: Dimensions.space50,
                        child: SvgPicture.asset(
                          MyImages.totalInvestSvg,
                          height: 35,
                        ),
                      ),
                      const SizedBox(width: Dimensions.space10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            MyStrings.totalInvest.tr,
                            style: regularLarge.copyWith(fontFamily: 'Inter'),
                          ),
                          Text(
                            controller.defaultCurrency.tr +
                                Converter.formatNumber(controller.totalInvest),
                            style: semiBoldExtraLarge.copyWith(
                              color: MyColor.primaryButtonColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: Dimensions.space10,
                    vertical: Dimensions.space5,
                  ),
                  height: Dimensions.space50,
                  width: Dimensions.space1,
                  color: MyColor.dividerColor,
                ),
                Expanded(
                  child: Row(
                    children: [
                      SizedBox(
                        height: Dimensions.space40,
                        child: Image.asset(
                          MyImages.totalWin,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: Dimensions.space10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            MyStrings.totalWin.tr,
                            style: regularLarge.copyWith(fontFamily: 'Inter'),
                          ),
                          Text(
                            controller.defaultCurrency +
                                Converter.formatNumber(
                                  controller.totalWin,
                                  precision: 2,
                                ),
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
          ),
        ],
      ),
    );
  }
}
