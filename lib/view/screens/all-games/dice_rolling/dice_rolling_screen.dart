import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:verzusxyz/core/utils/dimensions.dart';
import 'package:verzusxyz/core/utils/my_audio.dart';
import 'package:verzusxyz/core/utils/my_color.dart';
import 'package:verzusxyz/core/utils/my_strings.dart';
import 'package:verzusxyz/data/controller/all_games/dice_rolling_controller.dart';
import 'package:verzusxyz/data/repo/all-games/dice_rolling/dice_rolling_repo.dart';
import 'package:verzusxyz/data/services/api_service.dart';
import 'package:verzusxyz/view/components/buttons/rounded_button.dart';
import 'package:verzusxyz/view/components/buttons/rounded_loading_button.dart';
import 'package:verzusxyz/view/components/card/game_top_section.dart';
import 'package:verzusxyz/view/components/custom_loader/custom_loader.dart';
import 'package:verzusxyz/view/components/snack_bar/show_custom_snackbar.dart';
import 'package:verzusxyz/view/components/text-form-field/custom_text_field.dart';
import 'package:verzusxyz/view/screens/all-games/head_tail/widgets/available_balance_card.dart';
import 'package:verzusxyz/view/screens/all-games/widgets/dice.dart';
import 'package:verzusxyz/view/screens/all-games/widgets/minimum_maximum_bonus_section.dart';
import 'package:verzusxyz/view/screens/all-games/widgets/option_selection_cotainer.dart';
import 'package:get/get.dart';

class DiceRollingScreen extends StatefulWidget {
  const DiceRollingScreen({Key? key}) : super(key: key);

  @override
  State<DiceRollingScreen> createState() => _DiceRollingScreenState();
}

class _DiceRollingScreenState extends State<DiceRollingScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(DiceRollingRepo(apiClient: Get.find()));
    final controller = Get.put(
      DiceRollingController(diceRollingRepo: Get.find()),
    );
    super.initState();
    controller.loadGameInfo();
  }

  @override
  void dispose() {
    final controller = Get.put(
      DiceRollingController(diceRollingRepo: Get.find()),
    );
    controller.dicetimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<DiceRollingController>(
        builder: (controller) => Container(
          height: double.infinity,
          decoration: const BoxDecoration(gradient: MyColor.gradientBackground),
          child: controller.isLoading
              ? const CustomLoader(loaderColor: MyColor.colorWhite)
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
                          decoration: BoxDecoration(
                            color: MyColor.secondaryPrimaryColor,
                            border: Border.all(
                              color: MyColor.navBarActiveButtonColor,
                            ),
                            borderRadius: BorderRadius.circular(
                              Dimensions.space8,
                            ),
                          ),
                          padding: const EdgeInsets.all(Dimensions.space50),
                          width: double.infinity,
                          child: const Column(
                            children: [Center(child: Dice())],
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
                          haswinAmount: controller.winningPercentage != "0"
                              ? true
                              : false,
                          maximum: controller.maxAoumnnt,
                          minimum: controller.minimumAoumnnt,
                          winAmount: controller.winningPercentage,
                          currencySym: controller.defaultCurrency,
                        ),
                        const SizedBox(height: Dimensions.space10),
                        Container(
                          margin: const EdgeInsets.symmetric(
                            vertical: Dimensions.space10,
                          ),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: MyColor.secondaryPrimaryColor,
                            borderRadius: BorderRadius.circular(
                              Dimensions.space8,
                            ),
                          ),
                          child: GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 1.5,
                                ),
                            shrinkWrap: true,
                            itemCount: controller.myOptionsImage.length,
                            itemBuilder: (context, index) {
                              return OptionSelectionContainer(
                                isSelected:
                                    controller.selectedDiceIndex == index,
                                images: controller.myOptionsImage[index],
                                onTap: () {
                                  AudioPlayer().play(
                                    AssetSource(MyAudio.clickAudio),
                                  );
                                  controller.amountFocusNode.unfocus();
                                  controller.updateIndex(index);
                                },
                              );
                            },
                          ),
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
                                verticalPadding: Dimensions.space15,
                                cornerRadius: Dimensions.space8,
                                color: MyColor.primaryButtonColor,
                                text: MyStrings.playNow,
                                press: () {
                                  if (controller
                                      .amountController
                                      .text
                                      .isNotEmpty) {
                                    if (controller.selectedDiceIndex != -1) {
                                      controller.submitInvestmentRequest();
                                    } else {
                                      CustomSnackBar.error(
                                        errorList: [MyStrings.selecABet],
                                      );
                                    }
                                  } else {
                                    CustomSnackBar.error(
                                      errorList: [
                                        MyStrings.enterAnInvestmentAmount,
                                      ],
                                    );
                                  }
                                },
                              ),
                        const SizedBox(height: Dimensions.space40),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
