import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:verzusxyz/core/utils/dimensions.dart';
import 'package:verzusxyz/core/utils/my_audio.dart';
import 'package:verzusxyz/core/utils/my_color.dart';
import 'package:verzusxyz/core/utils/my_strings.dart';
import 'package:verzusxyz/data/controller/all_games/roulette/roulette_controller_.dart';
import 'package:verzusxyz/data/repo/all-games/roulete/roulette_repo.dart';
import 'package:verzusxyz/data/services/api_service.dart';
import 'package:verzusxyz/view/components/buttons/rounded_button.dart';
import 'package:verzusxyz/view/components/buttons/rounded_loading_button.dart';
import 'package:verzusxyz/view/components/card/game_top_section.dart';
import 'package:verzusxyz/view/components/snack_bar/show_custom_snackbar.dart';
import 'package:verzusxyz/view/components/text-form-field/custom_text_field.dart';
import 'package:verzusxyz/view/screens/all-games/head_tail/widgets/available_balance_card.dart';
import 'package:verzusxyz/view/screens/all-games/roulette/widget/custom_wheel.dart';
import 'package:verzusxyz/view/screens/all-games/widgets/bet_board.dart';
import 'package:verzusxyz/view/screens/all-games/widgets/minimum_maximum_bonus_section.dart';
import 'package:get/get.dart';

class RouletteScreen extends StatefulWidget {
  const RouletteScreen({Key? key}) : super(key: key);

  @override
  State<RouletteScreen> createState() => _RouletteScreenState();
}

class _RouletteScreenState extends State<RouletteScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(RouletteRepo(apiClient: Get.find()));
    final controller = Get.put(RouletteControllers(rouletteRepo: Get.find()));
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    controller.getSpinData();
    controller.loadGameInfo();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<RouletteControllers>(
        builder: (controller) => Container(
          height: double.infinity,
          decoration: const BoxDecoration(gradient: MyColor.gradientBackground),
          child: SingleChildScrollView(
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
                    curSymbol: controller.currencySym,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: MyColor.secondaryPrimaryColor,
                      border: Border.all(
                        color: MyColor.navBarActiveButtonColor,
                      ),
                      borderRadius: BorderRadius.circular(Dimensions.space8),
                    ),
                    padding: const EdgeInsets.all(Dimensions.space20),
                    width: double.infinity,
                    child: const Stack(
                      alignment: Alignment.center,
                      children: [CustomSpinWheel()],
                    ),
                  ),
                  const SizedBox(height: Dimensions.space15),
                  CustomTextField(
                    animatedLabel: true,
                    borderColor: MyColor.textFieldBorder,
                    disableBorderColor: MyColor.textFieldBorder,
                    needOutlineBorder: true,
                    borderRadious: 8,
                    focusNode: controller.amountFocusNode,
                    controller: controller.amountController,
                    labelText: MyStrings.enterAmount.tr,
                    labelTextColor: MyColor.subTitleTextColor,
                    isSuffixContainer: true,
                    onChanged: (value) {
                      controller.countWinningAmount();
                    },
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
                    hasBonusAmount: controller.isBetValueSelected,
                    maximum: controller.maxAoumnnt,
                    minimum: controller.minimumAoumnnt,
                    winAmount: controller.winningPercentage,
                    currencySym: controller.defaultCurrency,
                    bonusAmount: controller.winningAmount.toString(),
                  ),
                  const SizedBox(height: Dimensions.space10),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: Dimensions.space10,
                      horizontal: Dimensions.space10,
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: Dimensions.space6,
                      horizontal: Dimensions.space50,
                    ),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: MyColor.secondaryPrimaryColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const BetBoard(),
                  ),
                  const SizedBox(height: Dimensions.space14),
                  controller.isSubmitted
                      ? const RoundedLoadingBtn(
                          color: MyColor.primaryButtonColor,
                        )
                      : RoundedButton(
                          hasCornerRadious: true,
                          isColorChange: true,
                          textColor: MyColor.colorBlack,
                          verticalPadding: 15,
                          cornerRadius: 8,
                          color: MyColor.primaryButtonColor,
                          text: MyStrings.playNow,
                          press: () {
                            controller.gameStatus = "ongoing";
                            if (controller.amountController.text.isNotEmpty) {
                              if (controller.selectedNumbers.isNotEmpty) {
                                AudioPlayer().play(
                                  AssetSource(MyAudio.clickAudio),
                                );
                                controller.submitInvestmentRequest();
                                controller.play();
                              } else {
                                CustomSnackBar.error(
                                  errorList: [MyStrings.chooseFieldidRequired],
                                );
                              }
                            } else {
                              CustomSnackBar.error(
                                errorList: [MyStrings.enterInvestmentAmount],
                              );
                            }
                          },
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
