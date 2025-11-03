import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:verzusxyz/core/utils/dimensions.dart';
import 'package:verzusxyz/core/utils/my_audio.dart';
import 'package:verzusxyz/core/utils/my_color.dart';
import 'package:verzusxyz/core/utils/my_images.dart';
import 'package:verzusxyz/core/utils/my_strings.dart';
import 'package:verzusxyz/core/utils/style.dart';
import 'package:verzusxyz/data/controller/all_games/guess_the_number_controller.dart';
import 'package:verzusxyz/data/repo/all-games/guess_the_number/guess_the_number_repo.dart';
import 'package:verzusxyz/data/services/api_service.dart';
import 'package:verzusxyz/view/components/buttons/rounded_button.dart';
import 'package:verzusxyz/view/components/buttons/rounded_loading_button.dart';
import 'package:verzusxyz/view/components/card/game_top_section.dart';
import 'package:verzusxyz/view/components/custom_loader/custom_loader.dart';
import 'package:verzusxyz/view/components/snack_bar/show_custom_snackbar.dart';
import 'package:verzusxyz/view/components/text-form-field/custom_text_field.dart';
import 'package:verzusxyz/view/screens/all-games/head_tail/widgets/available_balance_card.dart';
import 'package:verzusxyz/view/screens/all-games/widgets/minimum_maximum_bonus_section.dart';
import 'package:get/get.dart';

class GuessTheNumberScreen extends StatefulWidget {
  const GuessTheNumberScreen({Key? key}) : super(key: key);

  @override
  State<GuessTheNumberScreen> createState() => _GuessTheNumberScreenState();
}

class _GuessTheNumberScreenState extends State<GuessTheNumberScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(GuessTheNumberRepo(apiClient: Get.find()));
    final controller = Get.put(
      GuessTheNumberController(guessTheNumberRepo: Get.find()),
    );

    super.initState();

    controller.loadGameInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<GuessTheNumberController>(
        builder: (controller) {
          return Container(
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: MyColor.gradientBackground,
            ),
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
                            name: controller.gameName.tr,
                            instruction: controller.instruction,
                          ),
                          const SizedBox(height: Dimensions.space5),
                          AvailableBalanceCard(
                            balance: controller.availAbleBalance,
                            curSymbol: controller.defaultCurrencySymbol,
                          ),
                          Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: MyColor.secondaryPrimaryColor,
                                  border: Border.all(
                                    color: MyColor.navBarActiveButtonColor,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: Dimensions.space15,
                                  vertical: 40,
                                ),
                                width: double.infinity,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width *
                                          .6,
                                      child: Text(
                                        controller.screenmsg.tr,
                                        style: semiBoldOverLarge.copyWith(
                                          color: MyColor.gameTextColor,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              controller.type == ""
                                  ? const SizedBox()
                                  : Align(
                                      alignment: Alignment.bottomRight,
                                      child:
                                          controller.checkCounter ==
                                                  int.tryParse(
                                                    controller.chances,
                                                  )! ||
                                              controller.checkCounter >
                                                  int.tryParse(
                                                    controller.chances,
                                                  )!
                                          ? const SizedBox()
                                          : controller.isSubmitted
                                          ? const SizedBox()
                                          : Padding(
                                              padding:
                                                  const EdgeInsetsDirectional.only(
                                                    end: Dimensions.space5,
                                                  ),
                                              child: Image.asset(
                                                controller.type == "1"
                                                    ? MyImages.goDown
                                                    : MyImages.goUp,
                                                width: 55,
                                              ),
                                            ),
                                    ),
                            ],
                          ),
                          controller.hideAmountField
                              ? const SizedBox()
                              : const SizedBox(height: Dimensions.space15),
                          controller.hideAmountField
                              ? const SizedBox()
                              : CustomTextField(
                                  animatedLabel: true,
                                  borderColor: MyColor.textFieldBorder,
                                  disableBorderColor: MyColor.textFieldBorder,
                                  needOutlineBorder: true,
                                  borderRadious: 8,
                                  controller: controller.amountController,
                                  focusNode: controller.amountFocusNode,
                                  labelText: MyStrings.enterAmount.tr,
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
                            showMinimumAndMaximum: controller.hideAmountField
                                ? false
                                : true,
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
                            padding: const EdgeInsets.all(Dimensions.space15),
                            margin: const EdgeInsets.symmetric(
                              vertical: Dimensions.space10,
                            ),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: MyColor.secondaryPrimaryColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  MyStrings.chooseNumberBetweenZeroToHundred.tr,
                                  style: regularDefault.copyWith(
                                    color: MyColor.colorWhite,
                                    fontFamily: "Inter",
                                  ),
                                ),
                                const SizedBox(height: Dimensions.space10),
                                CustomTextField(
                                  animatedLabel: true,
                                  fillColor: MyColor.gusessNumberFieldColor,
                                  borderColor: MyColor.textFieldBorder,
                                  disableBorderColor: MyColor.textFieldBorder,
                                  needOutlineBorder: true,
                                  focusNode: controller.guessTheNumberFocusNode,
                                  borderRadious: 8,
                                  controller: controller.guessNumberController,
                                  labelText: MyStrings.guessTheNumber.tr,
                                  labelTextColor: MyColor.subTitleTextColor,
                                  maxLines: 1,
                                  textAlign: true,
                                  hasLabelTextSize: true,
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
                                    AudioPlayer().play(
                                      AssetSource(MyAudio.clickAudio),
                                    );
                                    controller.guessTheNumberFocusNode
                                        .unfocus();
                                    final guessNumber = int.tryParse(
                                      controller.guessNumberController.text,
                                    );
                                    if (controller
                                        .amountController
                                        .text
                                        .isNotEmpty) {
                                      if (controller
                                          .guessNumberController
                                          .text
                                          .isNotEmpty) {
                                        if (guessNumber! < 0 ||
                                            guessNumber > 100) {
                                          CustomSnackBar.error(
                                            errorList: [
                                              MyStrings
                                                  .guessTheNumberBetweenZerotoHundred,
                                            ],
                                          );
                                        } else {
                                          if (controller.checkCounter == 0) {
                                            controller
                                                .submitInvestmentRequest();
                                          } else {
                                            controller.endTheGame();
                                            controller.checkCounter++;
                                          }
                                        }
                                      } else {
                                        CustomSnackBar.error(
                                          errorList: [MyStrings.guessTheNumber],
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
                        ],
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }
}
