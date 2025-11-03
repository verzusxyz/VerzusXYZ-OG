import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:verzusxyz/core/utils/dimensions.dart';
import 'package:verzusxyz/core/utils/my_audio.dart';
import 'package:verzusxyz/core/utils/my_color.dart';
import 'package:verzusxyz/core/utils/my_strings.dart';
import 'package:verzusxyz/core/utils/style.dart';
import 'package:verzusxyz/data/controller/all_games/casino_dice/casino_dice_controller.dart';
import 'package:verzusxyz/data/repo/all-games/casino_dice/casino_dice_repo.dart';
import 'package:verzusxyz/data/services/api_service.dart';
import 'package:verzusxyz/view/components/card/game_top_section.dart';
import 'package:verzusxyz/view/components/custom_loader/custom_loader.dart';
import 'package:verzusxyz/view/components/snack_bar/show_custom_snackbar.dart';
import 'package:verzusxyz/view/components/text-form-field/custom_text_field.dart';
import 'package:verzusxyz/view/screens/all-games/head_tail/widgets/available_balance_card.dart';
import 'package:verzusxyz/view/screens/all-games/play_casino_dice/widgets/number_card.dart';
import 'package:verzusxyz/view/screens/all-games/widgets/minimum_maximum_bonus_section.dart';
import 'package:get/get.dart';

class PlayCasinoDiceScreen extends StatefulWidget {
  const PlayCasinoDiceScreen({Key? key}) : super(key: key);

  @override
  State<PlayCasinoDiceScreen> createState() => _PlayCasinoDiceScreenState();
}

class _PlayCasinoDiceScreenState extends State<PlayCasinoDiceScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(CasinoDiceRepo(apiClient: Get.find()));
    final controller = Get.put(
      CasinoDiceController(casinoDiceRepo: Get.find()),
    );
    super.initState();
    controller.getCasinoDiceScreenData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<CasinoDiceController>(
        builder: (controller) => Container(
          height: double.infinity,
          decoration: const BoxDecoration(gradient: MyColor.gradientBackground),
          child: controller.isLoading
              ? const CustomLoader(loaderColor: MyColor.primaryColor)
              : SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.space15,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: Dimensions.space70),
                        GameTopSection(
                          name: controller.gameName,
                          instruction: controller.instruction,
                        ),
                        const SizedBox(height: Dimensions.space5),
                        AvailableBalanceCard(
                          balance: controller.availAbleBalance,
                          curSymbol: controller.defaultCurrencySymbol,
                        ),
                        Container(
                          padding: const EdgeInsets.all(Dimensions.space10),
                          width: double.infinity,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  if (controller.numbers.isNotEmpty) ...[
                                    NumberCard(
                                      number: controller.numbers[0],
                                      isShuffling: controller.isShuffling,
                                    ),
                                    NumberCard(
                                      number: controller.numbers[1],
                                      isShuffling: controller.isShuffling,
                                    ),
                                    NumberCard(
                                      number: controller.numbers[2],
                                      isShuffling: controller.isShuffling,
                                    ),
                                    NumberCard(
                                      number: controller.numbers[3],
                                      isShuffling: controller.isShuffling,
                                    ),
                                  ],
                                ],
                              ),
                              const SizedBox(height: Dimensions.space10),
                              Slider(
                                activeColor: MyColor.navBarActiveButtonColor,
                                value: controller.sliderValue.clamp(0, 98),
                                min: 0,
                                max: 98,
                                divisions: 98,
                                label: controller.sliderValue
                                    .round()
                                    .toString(),
                                onChanged: (double value) {
                                  controller.updateWinChanceFromSlider(value);
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: Dimensions.space15),
                        CustomTextField(
                          animatedLabel: true,
                          borderColor: MyColor.textFieldBorder,
                          disableBorderColor: MyColor.textFieldBorder,
                          needOutlineBorder: true,
                          borderRadious: 8,
                          controller: controller.amountController,
                          labelText: MyStrings.enterAmount.tr,
                          focusNode: controller.amountFocusNode,
                          labelTextColor: MyColor.subTitleTextColor,
                          isSuffixContainer: true,
                          onChanged: (value) {},
                          currrency: controller.defaultCurrency,
                          textInputType: TextInputType.number,
                          inputAction: TextInputAction.next,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return MyStrings.fieldErrorMsg.tr;
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: Dimensions.space10),
                        MinimumMaximumBonusSection(
                          haswinAmount: false,
                          maximum: controller.maxAmount,
                          minimum: controller.minimumAoumnnt,
                          currencySym: controller.defaultCurrency,
                          winAmount: "",
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                            vertical: Dimensions.space10,
                          ),
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(Dimensions.space8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  MyStrings.winChance.tr,
                                  style: regularDefault.copyWith(
                                    color: MyColor.colorWhite,
                                    fontFamily: "Inter",
                                  ),
                                ),
                                const SizedBox(height: Dimensions.space5),
                                CustomTextField(
                                  animatedLabel: true,
                                  focusNode: controller.winChanceFocusNode,
                                  borderColor: MyColor.textFieldBorder,
                                  disableBorderColor: MyColor.textFieldBorder,
                                  needOutlineBorder: true,
                                  borderRadious: 8,
                                  hasPercent: true,
                                  controller: controller.winChanceController,
                                  labelText: MyStrings.enterAmount.tr,
                                  labelTextColor: MyColor.subTitleTextColor,
                                  onChanged: (value) {
                                    if (controller
                                        .winChanceController
                                        .text
                                        .isNotEmpty) {
                                      controller.countBonus();
                                      controller.sliderValue =
                                          double.tryParse(value) ?? 98;
                                    }
                                  },
                                  textInputType: TextInputType.number,
                                  inputAction: TextInputAction.next,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return MyStrings.fieldErrorMsg.tr;
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                const SizedBox(height: Dimensions.space20),
                                Text(
                                  MyStrings.bonus.tr,
                                  style: regularDefault.copyWith(
                                    color: MyColor.colorWhite,
                                    fontFamily: "Inter",
                                  ),
                                ),
                                const SizedBox(height: Dimensions.space5),
                                CustomTextField(
                                  readOnly: true,
                                  animatedLabel: true,
                                  borderColor: MyColor.textFieldBorder,
                                  disableBorderColor: MyColor.textFieldBorder,
                                  needOutlineBorder: true,
                                  focusNode: controller.bonusFocusNode,
                                  borderRadious: Dimensions.space8,
                                  controller: controller.bonusController,
                                  labelText: MyStrings.enterAmount.tr,
                                  labelTextColor: MyColor.subTitleTextColor,
                                  hasPercent: true,
                                  onChanged: (value) {},
                                  textInputType: TextInputType.number,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return MyStrings.fieldErrorMsg.tr;
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                const SizedBox(height: Dimensions.space20),
                                controller.enableBet
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: InkWell(
                                              onTap: () {},
                                              child: Container(
                                                width: double.infinity,
                                                margin: const EdgeInsets.all(
                                                  Dimensions.space10,
                                                ),
                                                padding: const EdgeInsets.all(
                                                  Dimensions.space10,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: MyColor
                                                      .primaryButtonColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        Dimensions.space8,
                                                      ),
                                                ),
                                                child: controller.isSubmitted
                                                    ? const CustomLoader(
                                                        loaderColor:
                                                            MyColor.colorBlack,
                                                      )
                                                    : Center(
                                                        child: Text(
                                                          "${MyStrings.low} < ${controller.low}",
                                                          style:
                                                              semiBoldDefault,
                                                        ),
                                                      ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              width: double.infinity,
                                              margin: const EdgeInsets.all(
                                                Dimensions.space10,
                                              ),
                                              padding: const EdgeInsets.all(
                                                Dimensions.space10,
                                              ),
                                              decoration: BoxDecoration(
                                                color:
                                                    MyColor.primaryButtonColor,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                      Dimensions.space8,
                                                    ),
                                              ),
                                              child: controller.isSubmitted
                                                  ? const CustomLoader(
                                                      loaderColor:
                                                          MyColor.colorBlack,
                                                    )
                                                  : Center(
                                                      child: Text(
                                                        "${MyStrings.high.tr} > ${controller.high.toString().tr}",
                                                        style: semiBoldDefault,
                                                      ),
                                                    ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: InkWell(
                                              onTap: () {
                                                if (controller
                                                    .amountController
                                                    .text
                                                    .isNotEmpty) {
                                                  controller.isHigh = false;
                                                  controller.submitAnswer();
                                                  AudioPlayer().play(
                                                    AssetSource(
                                                      MyAudio.clickAudio,
                                                    ),
                                                  );
                                                } else {
                                                  CustomSnackBar.error(
                                                    errorList: [
                                                      MyStrings
                                                          .enterAnInvestmentAmount,
                                                    ],
                                                  );
                                                }
                                              },
                                              child: Container(
                                                width: double.infinity,
                                                margin: const EdgeInsets.all(
                                                  Dimensions.space10,
                                                ),
                                                padding: const EdgeInsets.all(
                                                  Dimensions.space10,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: MyColor
                                                      .primaryButtonColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        Dimensions.space8,
                                                      ),
                                                ),
                                                child: controller.isSubmitted
                                                    ? const CustomLoader(
                                                        loaderColor:
                                                            MyColor.colorBlack,
                                                      )
                                                    : Center(
                                                        child: Text(
                                                          "${MyStrings.low} < ${controller.low}",
                                                          style:
                                                              semiBoldDefault,
                                                        ),
                                                      ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: InkWell(
                                              onTap: () {
                                                if (controller
                                                    .amountController
                                                    .text
                                                    .isNotEmpty) {
                                                  controller.isHigh = true;
                                                  controller.submitAnswer();
                                                  AudioPlayer().play(
                                                    AssetSource(
                                                      MyAudio.clickAudio,
                                                    ),
                                                  );
                                                } else {
                                                  CustomSnackBar.error(
                                                    errorList: [
                                                      MyStrings
                                                          .enterAnInvestmentAmount,
                                                    ],
                                                  );
                                                }
                                              },
                                              child: Container(
                                                width: double.infinity,
                                                margin: const EdgeInsets.all(
                                                  Dimensions.space10,
                                                ),
                                                padding: const EdgeInsets.all(
                                                  Dimensions.space10,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: MyColor
                                                      .primaryButtonColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        Dimensions.space8,
                                                      ),
                                                ),
                                                child: controller.isSubmitted
                                                    ? const CustomLoader(
                                                        loaderColor:
                                                            MyColor.colorBlack,
                                                      )
                                                    : Center(
                                                        child: Text(
                                                          "${MyStrings.high.tr} > ${controller.high.toString().tr}",
                                                          style:
                                                              semiBoldDefault,
                                                        ),
                                                      ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
