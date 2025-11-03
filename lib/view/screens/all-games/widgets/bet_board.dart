import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:verzusxyz/core/utils/dimensions.dart';
import 'package:verzusxyz/core/utils/my_audio.dart';
import 'package:verzusxyz/core/utils/my_color.dart';
import 'package:verzusxyz/core/utils/my_strings.dart';
import 'package:verzusxyz/core/utils/style.dart';
import 'package:verzusxyz/data/controller/all_games/roulette/roulette_controller_.dart';
import 'package:get/get.dart';

class BetBoard extends StatefulWidget {
  const BetBoard({Key? key}) : super(key: key);

  @override
  State<BetBoard> createState() => _BetBoardState();
}

class _BetBoardState extends State<BetBoard> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RouletteControllers>(
      builder: (controller) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: () {
                controller.isBetValueSelected = true;
                AudioPlayer().play(AssetSource(MyAudio.clickAudio));
                controller.selectBet(isZeroSelected: true);
                controller.countWinningAmount();
              },
              child: Container(
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * .09,
                ),
                padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * .09,
                ),
                decoration: BoxDecoration(
                  color: controller.getBgColor(isZero: true),
                  border: Border.all(color: MyColor.colorBorder, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    MyStrings.zero.tr,
                    style: semiBoldLarge.copyWith(
                      color: MyColor.colorWhite,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 11,
            child: Column(
              children: [
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 13,
                    childAspectRatio: 1.3,
                  ),
                  shrinkWrap: true,
                  itemCount: controller.rouleteNumberList.length,
                  itemBuilder: (context, index) {
                    bool isTwoRatioOne =
                        controller.rouleteNumberList[index].isTwoRationOne;
                    String number = isTwoRatioOne
                        ? "2:1"
                        : controller.rouleteNumberList[index].number.toString();

                    Color bgColor = controller.getBgColor(
                      index: index,
                      is2Ratio1: isTwoRatioOne,
                    );

                    return InkWell(
                      onTap: () {
                        controller.isBetValueSelected = true;
                        AudioPlayer().play(AssetSource(MyAudio.clickAudio));
                        controller.selectBet(
                          index: index,
                          is2RatioOne: isTwoRatioOne,
                        );
                        controller.countWinningAmount();
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: Dimensions.space2,
                          vertical: Dimensions.space2,
                        ),
                        decoration: BoxDecoration(
                          color: bgColor,
                          border: Border.all(
                            color: MyColor.colorBorder,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            number.tr,
                            style: semiBoldLarge.copyWith(
                              color: MyColor.colorWhite,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          controller.isBetValueSelected = true;
                          AudioPlayer().play(AssetSource(MyAudio.clickAudio));
                          controller.selectBet(is1To12: true);
                          controller.countWinningAmount();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: Dimensions.space5,
                          ),
                          decoration: BoxDecoration(
                            color: MyColor.colorBgCard,
                            border: Border.all(
                              color: MyColor.colorBorder,
                              width: Dimensions.space2,
                            ),
                            borderRadius: BorderRadius.circular(
                              Dimensions.space10,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              MyStrings.oneToTweleve.tr,
                              style: semiBoldLarge.copyWith(
                                color: MyColor.colorWhite,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: Dimensions.space3),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          controller.isBetValueSelected = true;
                          AudioPlayer().play(AssetSource(MyAudio.clickAudio));
                          controller.selectBet(is13To24: true);
                          controller.countWinningAmount();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: Dimensions.space5,
                          ),
                          decoration: BoxDecoration(
                            color: MyColor.colorBgCard,
                            border: Border.all(
                              color: MyColor.colorBorder,
                              width: Dimensions.space2,
                            ),
                            borderRadius: BorderRadius.circular(
                              Dimensions.space10,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              MyStrings.thirteenToTwentyFour.tr,
                              style: semiBoldLarge.copyWith(
                                color: MyColor.colorWhite,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: Dimensions.space3),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          controller.isBetValueSelected = true;
                          AudioPlayer().play(AssetSource(MyAudio.clickAudio));
                          controller.selectBet(is25To36: true);
                          controller.countWinningAmount();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: Dimensions.space5,
                          ),
                          decoration: BoxDecoration(
                            color: MyColor.colorBgCard,
                            border: Border.all(
                              color: MyColor.colorBorder,
                              width: Dimensions.space2,
                            ),
                            borderRadius: BorderRadius.circular(
                              Dimensions.space10,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              MyStrings.twentyFiveToThirtySix.tr,
                              style: semiBoldLarge.copyWith(
                                color: MyColor.colorWhite,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * .06),
                  ],
                ),
                const SizedBox(height: Dimensions.space3),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          controller.isBetValueSelected = true;
                          AudioPlayer().play(AssetSource(MyAudio.clickAudio));
                          controller.selectBet(is1To18: true);
                          controller.countWinningAmount();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: Dimensions.space5,
                          ),
                          decoration: BoxDecoration(
                            color: MyColor.colorBgCard,
                            border: Border.all(
                              color: MyColor.colorBorder,
                              width: Dimensions.space2,
                            ),
                            borderRadius: BorderRadius.circular(
                              Dimensions.space10,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              MyStrings.oneToEighteen.tr,
                              style: semiBoldLarge.copyWith(
                                color: MyColor.colorWhite,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: Dimensions.space3),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          controller.isBetValueSelected = true;
                          AudioPlayer().play(AssetSource(MyAudio.clickAudio));
                          controller.selectBet(isEven: true);
                          controller.countWinningAmount();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: Dimensions.space5,
                          ),
                          decoration: BoxDecoration(
                            color: MyColor.colorBgCard,
                            border: Border.all(
                              color: MyColor.colorBorder,
                              width: Dimensions.space2,
                            ),
                            borderRadius: BorderRadius.circular(
                              Dimensions.space10,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              MyStrings.even.tr,
                              style: semiBoldLarge.copyWith(
                                color: MyColor.colorWhite,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: Dimensions.space3),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          controller.isBetValueSelected = true;
                          AudioPlayer().play(AssetSource(MyAudio.clickAudio));
                          controller.selectBet(isRed: true);
                          controller.countWinningAmount();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: Dimensions.space5,
                          ),
                          decoration: BoxDecoration(
                            color: MyColor.colorDarkRed,
                            border: Border.all(
                              color: MyColor.colorBorder,
                              width: Dimensions.space2,
                            ),
                            borderRadius: BorderRadius.circular(
                              Dimensions.space10,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              MyStrings.red.tr,
                              style: semiBoldLarge.copyWith(
                                color: MyColor.colorWhite,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: Dimensions.space3),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          controller.isBetValueSelected = true;
                          AudioPlayer().play(AssetSource(MyAudio.clickAudio));
                          controller.selectBet(isBlack: true);
                          controller.countWinningAmount();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: Dimensions.space5,
                          ),
                          decoration: BoxDecoration(
                            color: MyColor.colorDarkBlack,
                            border: Border.all(
                              color: MyColor.colorBorder,
                              width: Dimensions.space2,
                            ),
                            borderRadius: BorderRadius.circular(
                              Dimensions.space10,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              MyStrings.black.tr,
                              style: semiBoldLarge.copyWith(
                                color: MyColor.colorWhite,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: Dimensions.space3),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          controller.isBetValueSelected = true;
                          AudioPlayer().play(AssetSource(MyAudio.clickAudio));
                          controller.selectBet(isOdd: true);
                          controller.countWinningAmount();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: Dimensions.space5,
                          ),
                          decoration: BoxDecoration(
                            color: MyColor.colorBgCard,
                            border: Border.all(
                              color: MyColor.colorBorder,
                              width: Dimensions.space2,
                            ),
                            borderRadius: BorderRadius.circular(
                              Dimensions.space10,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              MyStrings.odd.tr,
                              style: semiBoldLarge.copyWith(
                                color: MyColor.colorWhite,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: Dimensions.space3),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          controller.isBetValueSelected = true;
                          AudioPlayer().play(AssetSource(MyAudio.clickAudio));
                          controller.selectBet(is19To36: true);
                          controller.countWinningAmount();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: Dimensions.space5,
                          ),
                          decoration: BoxDecoration(
                            color: MyColor.colorBgCard,
                            border: Border.all(
                              color: MyColor.colorBorder,
                              width: Dimensions.space2,
                            ),
                            borderRadius: BorderRadius.circular(
                              Dimensions.space10,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              MyStrings.nineteenToThirtySix.tr,
                              style: semiBoldLarge.copyWith(
                                color: MyColor.colorWhite,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * .06),
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
