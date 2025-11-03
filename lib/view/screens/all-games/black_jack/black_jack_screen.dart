import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:verzusxyz/core/utils/dimensions.dart';
import 'package:verzusxyz/core/utils/my_audio.dart';
import 'package:verzusxyz/core/utils/my_color.dart';
import 'package:verzusxyz/core/utils/my_images.dart';
import 'package:verzusxyz/core/utils/my_strings.dart';
import 'package:verzusxyz/core/utils/style.dart';
import 'package:verzusxyz/data/controller/all_games/black_jack/black_jack_controller.dart';
import 'package:verzusxyz/data/repo/all-games/black_jack/black_jack_repo.dart';
import 'package:verzusxyz/data/services/api_service.dart';
import 'package:verzusxyz/view/components/buttons/rounded_button.dart';
import 'package:verzusxyz/view/components/buttons/rounded_loading_button.dart';
import 'package:verzusxyz/view/components/card/game_top_section.dart';
import 'package:verzusxyz/view/components/custom_loader/custom_loader.dart';
import 'package:verzusxyz/view/components/snack_bar/show_custom_snackbar.dart';
import 'package:verzusxyz/view/components/text-form-field/custom_text_field.dart';
import 'package:verzusxyz/view/screens/all-games/black_jack/widgets/button.dart';
import 'package:verzusxyz/view/screens/all-games/black_jack/widgets/dealer_section.dart';
import 'package:verzusxyz/view/screens/all-games/black_jack/widgets/my_section.dart';
import 'package:verzusxyz/view/screens/all-games/head_tail/widgets/available_balance_card.dart';
import 'package:verzusxyz/view/screens/all-games/widgets/minimum_maximum_bonus_section.dart';
import 'package:get/get.dart';

class BlackJackScreen extends StatefulWidget {
  const BlackJackScreen({Key? key}) : super(key: key);

  @override
  State<BlackJackScreen> createState() => _BlackJackScreenState();
}

class _BlackJackScreenState extends State<BlackJackScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(BlackJackRepo(apiClient: Get.find()));
    final controller = Get.put(BlackJackController(blackJackRepo: Get.find()));
    super.initState();
    controller.loadGameInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<BlackJackController>(
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
                          name: controller.name,
                          instruction: controller.instruction,
                        ),
                        const SizedBox(height: Dimensions.space5),
                        controller.playNow
                            ? const SizedBox()
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AvailableBalanceCard(
                                    balance: controller.availableBalance,
                                    curSymbol: controller.defaultCurrencySymbol,
                                  ),
                                  Stack(
                                    children: [
                                      Image.asset(MyImages.rule),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                            0.85,
                                        height:
                                            MediaQuery.of(context).size.height *
                                            0.25,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            top:
                                                MediaQuery.of(
                                                  context,
                                                ).size.height *
                                                0.09,
                                            left: 40,
                                          ),
                                          child: SingleChildScrollView(
                                            child: Text(
                                              controller.shortDescription,
                                              style: regularDefault.copyWith(
                                                fontFamily: "Inter",
                                                color: MyColor.colorWhite,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: Dimensions.space15),
                                  CustomTextField(
                                    animatedLabel: true,
                                    borderColor: MyColor.textFieldBorder,
                                    disableBorderColor: MyColor.textFieldBorder,
                                    needOutlineBorder: true,
                                    borderRadious: Dimensions.space8,
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
                                    haswinAmount: true,
                                    maximum: controller.maximum,
                                    minimum: controller.minimum,
                                    winAmount: controller.winningPercentage,
                                    currencySym: controller.defaultCurrency,
                                  ),
                                  const SizedBox(height: Dimensions.space30),
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
                                              controller
                                                  .submitInvestmentRequest();
                                              AudioPlayer().play(
                                                AssetSource(MyAudio.clickAudio),
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
                                        ),
                                ],
                              ),
                        controller.playNow
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(height: Dimensions.space20),
                                  const DealerSection(),
                                  const SizedBox(height: Dimensions.space50),
                                  const MySection(),
                                  const SizedBox(height: Dimensions.space20),
                                  controller.showResult
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: InkWell(
                                                onTap: () {
                                                  controller.back();
                                                  AudioPlayer().play(
                                                    AssetSource(
                                                      MyAudio.clickAudio,
                                                    ),
                                                  );
                                                },
                                                child: const Buttons(
                                                  text: MyStrings.back,
                                                  color: MyColor.redColor,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: Dimensions.space10,
                                            ),
                                            Expanded(
                                              child: InkWell(
                                                onTap: () {
                                                  if (!controller.isSubmitted) {
                                                    controller.playAgain();
                                                    AudioPlayer().play(
                                                      AssetSource(
                                                        MyAudio.clickAudio,
                                                      ),
                                                    );
                                                  }
                                                },
                                                child: Buttons(
                                                  isLoading:
                                                      controller.isSubmitted,
                                                  loaderColor: MyColor
                                                      .navBarActiveButtonColor,
                                                  text: MyStrings.playAgain,
                                                  color: MyColor
                                                      .navBarActiveButtonColor,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: InkWell(
                                                onTap: () {
                                                  if (controller.hitStatus !=
                                                      MyStrings.errorResponse) {
                                                    if (!controller.isHitted) {
                                                      AudioPlayer().play(
                                                        AssetSource(
                                                          MyAudio.clickAudio,
                                                        ),
                                                      );
                                                      controller.hit();
                                                    }
                                                  } else {
                                                    CustomSnackBar.error(
                                                      errorList: [
                                                        MyStrings
                                                            .youCantHitMore,
                                                      ],
                                                    );
                                                  }
                                                },
                                                child: Buttons(
                                                  isLoading:
                                                      controller.isHitted,
                                                  loaderColor:
                                                      controller.hitStatus !=
                                                          MyStrings
                                                              .errorResponse
                                                      ? MyColor.redColor
                                                      : MyColor.redAccent,
                                                  text: MyStrings.hit,
                                                  color:
                                                      controller.hitStatus !=
                                                          MyStrings
                                                              .errorResponse
                                                      ? MyColor.redColor
                                                      : MyColor.redAccent,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: Dimensions.space20,
                                            ),
                                            Expanded(
                                              child: InkWell(
                                                onTap: () {
                                                  if (!controller.isStaying) {
                                                    controller.stay();
                                                    AudioPlayer().play(
                                                      AssetSource(
                                                        MyAudio.clickAudio,
                                                      ),
                                                    );
                                                  }
                                                },
                                                child: Buttons(
                                                  isLoading:
                                                      controller.isStaying,
                                                  loaderColor: MyColor
                                                      .navBarActiveButtonColor,
                                                  text: MyStrings.stay.tr,
                                                  color: MyColor
                                                      .navBarActiveButtonColor,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                ],
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
