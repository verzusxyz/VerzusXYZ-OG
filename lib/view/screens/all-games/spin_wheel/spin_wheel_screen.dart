import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:verzusxyz/core/utils/dimensions.dart';
import 'package:verzusxyz/core/utils/my_audio.dart';
import 'package:verzusxyz/core/utils/my_color.dart';
import 'package:verzusxyz/core/utils/my_strings.dart';
import 'package:verzusxyz/data/controller/all_games/spin_wheel/spin_wheel_controller.dart';
import 'package:verzusxyz/data/repo/all-games/spin_wheel/spin_wheel_repo.dart';
import 'package:verzusxyz/data/services/api_service.dart';
import 'package:verzusxyz/view/components/buttons/rounded_button.dart';
import 'package:verzusxyz/view/components/buttons/rounded_loading_button.dart';
import 'package:verzusxyz/view/components/card/game_top_section.dart';
import 'package:verzusxyz/view/components/custom_loader/custom_loader.dart';
import 'package:verzusxyz/view/components/snack_bar/show_custom_snackbar.dart';
import 'package:verzusxyz/view/components/text-form-field/custom_text_field.dart';
import 'package:verzusxyz/view/screens/all-games/head_tail/widgets/available_balance_card.dart';
import 'package:verzusxyz/view/screens/all-games/spin_wheel/widgets/select_bet_buttons.dart';
import 'package:verzusxyz/view/screens/all-games/spin_wheel/widgets/spin_wheel.dart';
import 'package:verzusxyz/view/screens/all-games/widgets/minimum_maximum_bonus_section.dart';
import 'package:get/get.dart';

class SpinWheelScreen extends StatefulWidget {
  const SpinWheelScreen({Key? key}) : super(key: key);

  @override
  State<SpinWheelScreen> createState() => _SpinWheelScreenState();
}

class _SpinWheelScreenState extends State<SpinWheelScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(SpinWheelRepo(apiClient: Get.find()));
    final controller = Get.put(SpinWheelControllers(spinWheelRepo: Get.find()));
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.initData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SpinWheelControllers>(
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
                          decoration: BoxDecoration(
                            color: MyColor.secondaryPrimaryColor,
                            border: Border.all(
                              color: MyColor.navBarActiveButtonColor,
                            ),
                            borderRadius: BorderRadius.circular(
                              Dimensions.space8,
                            ),
                          ),
                          padding: const EdgeInsets.all(Dimensions.space20),
                          width: double.infinity,
                          child: const SpinWheel(),
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
                          labelTextColor: MyColor.subTitleTextColor,
                          isSuffixContainer: true,
                          focusNode: controller.amountFocusNode,
                          currrency: controller.defaultCurrency,
                          onChanged: (value) {},
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
                            horizontal: Dimensions.space3,
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: Dimensions.space20,
                            horizontal: Dimensions.space10,
                          ),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: MyColor.secondaryPrimaryColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  controller.changeSelection();
                                },
                                child: SelectBetButton(
                                  onTap: () {
                                    AudioPlayer().play(
                                      AssetSource(MyAudio.clickAudio),
                                    );
                                    controller.isBlue = true;
                                    controller.isRed = false;
                                    controller.amountFocusNode.unfocus();
                                    controller.update();
                                  },
                                  isSelected: controller.isBlue,
                                  buttonColor: MyColor.blueColor,
                                ),
                              ),
                              const SizedBox(width: Dimensions.space15),
                              InkWell(
                                onTap: () {
                                  controller.changeSelection();
                                },
                                child: SelectBetButton(
                                  onTap: () {
                                    AudioPlayer().play(
                                      AssetSource(MyAudio.clickAudio),
                                    );
                                    controller.isBlue = false;
                                    controller.isRed = true;
                                    controller.amountFocusNode.unfocus();
                                    controller.update();
                                  },
                                  isSelected: controller.isRed,
                                  buttonColor: MyColor.redColor,
                                ),
                              ),
                            ],
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
                                    if (controller.isRed == true ||
                                        controller.isBlue == true) {
                                      controller.submitInvestmentRequest();
                                      controller.play();
                                    } else {
                                      CustomSnackBar.error(
                                        errorList: [
                                          MyStrings.chooseFieldidRequired,
                                        ],
                                      );
                                    }
                                  } else {
                                    CustomSnackBar.error(
                                      errorList: [
                                        MyStrings.enterInvestmentAmount,
                                      ],
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
