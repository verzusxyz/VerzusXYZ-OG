import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:verzusxyz/core/utils/dimensions.dart';
import 'package:verzusxyz/core/utils/my_color.dart';
import 'package:verzusxyz/core/utils/my_images.dart';
import 'package:verzusxyz/core/utils/my_strings.dart';
import 'package:verzusxyz/core/utils/style.dart';
import 'package:verzusxyz/view/components/alert-dialog/custom_alert_dialog.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class GameTopSection extends StatefulWidget {
  final String name;
  final String instruction;
  const GameTopSection({
    super.key,
    required this.name,
    required this.instruction,
  });

  @override
  State<GameTopSection> createState() => _GameTopSectionState();
}

class _GameTopSectionState extends State<GameTopSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Dimensions.space8),
      width: double.infinity,
      decoration: BoxDecoration(
        color: MyColor.secondaryPrimaryColor,
        border: Border.all(color: MyColor.navBarActiveButtonColor),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: InkWell(
                onTap: () {
                  Get.back();
                },
                child: SvgPicture.asset(
                  MyImages.roundedBackWardSVG,
                  height: 30,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              widget.name.tr,
              style: semiBoldLarge.copyWith(
                color: MyColor.navBarActiveButtonColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () {
                  CustomAlertDialog(
                    child: Container(
                      color: MyColor.colorBgCard,
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(Dimensions.space10),
                            color: MyColor.navBarActiveButtonColor,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  MyStrings.gameRule.tr,
                                  style: semiBoldLarge.copyWith(
                                    fontFamily: 'Inter',
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Image.asset(
                                    MyImages.cancel,
                                    height: 20,
                                    color: MyColor.colorCancel,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(Dimensions.space10),
                            child: Html(
                              data: widget.instruction,
                              style: {"body": Style(color: MyColor.colorWhite)},
                            ),
                          ),
                        ],
                      ),
                    ),
                  ).customAlertDialog(context);
                },
                child: SvgPicture.asset(MyImages.infoSVG),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
