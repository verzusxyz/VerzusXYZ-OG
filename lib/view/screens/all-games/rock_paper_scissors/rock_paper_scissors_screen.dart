import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:verzusxyz/core/utils/dimensions.dart';
import 'package:verzusxyz/core/utils/my_audio.dart';
import 'package:verzusxyz/core/utils/my_color.dart';
import 'package:verzusxyz/core/utils/my_strings.dart';
import 'package:verzusxyz/core/utils/style.dart';
import 'package:verzusxyz/data/controller/all_games/rock_paper_scissors_controller.dart';
import 'package:verzusxyz/data/repo/all-games/rock_paper_scissors/rock_paper_scissors_repo.dart';
import 'package:verzusxyz/data/services/api_service.dart';
import 'package:verzusxyz/view/components/buttons/rounded_button.dart';
import 'package:verzusxyz/view/components/buttons/rounded_loading_button.dart';
import 'package:verzusxyz/view/components/card/game_top_section.dart';
import 'package:verzusxyz/view/components/custom_loader/custom_loader.dart';
import 'package:verzusxyz/view/components/snack_bar/show_custom_snackbar.dart';
import 'package:verzusxyz/view/components/text-form-field/custom_text_field.dart';
import 'package:verzusxyz/view/screens/all-games/head_tail/widgets/available_balance_card.dart';
import 'package:verzusxyz/view/screens/all-games/widgets/minimum_maximum_bonus_section.dart';
import 'package:verzusxyz/view/screens/all-games/widgets/option_selection_cotainer.dart';
import 'package:get/get.dart';

class RockPaperScissorsScreen extends StatefulWidget {
  const RockPaperScissorsScreen({Key? key}) : super(key: key);

  @override
  State<RockPaperScissorsScreen> createState() =>
      _RockPaperScissorsScreenState();
}

class _RockPaperScissorsScreenState extends State<RockPaperScissorsScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(RockPaperScissorsRepo(apiClient: Get.find()));
    final controller = Get.put(
      RockPaperScissorsController(rockPaperScissorsRepo: Get.find()),
    );
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.initData();
      controller.startUpdatingImage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<RockPaperScissorsController>(
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
                        AvailableBalanceCard(
                          balance: controller.availableBalance,
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
                          padding: const EdgeInsets.all(Dimensions.space10),
                          width: double.infinity,
                          child: FittedBox(
                            fit: BoxFit.cover,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  controller.currentImage,
                                  height: Dimensions.space160,
                                  fit: BoxFit.cover,
                                ),
                                Visibility(
                                  visible: controller.showResult,
                                  child: Text(
                                    MyStrings.versus.tr,
                                    style: semiBoldMediumLarge.copyWith(
                                      color: MyColor.colorWhite,
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: controller.showResult,
                                  child: Image.asset(
                                    controller.rockScissorPaperImages[controller
                                                .userChoice ==
                                            Choice.rock
                                        ? 0
                                        : controller.userChoice == Choice.paper
                                        ? 1
                                        : controller.userChoice ==
                                              Choice.scissors
                                        ? 2
                                        : 0],
                                    height: Dimensions.space160,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: Dimensions.space15),
                        CustomTextField(
                          animatedLabel: true,
                          focusNode: controller.amountFocusNode,
                          borderColor: MyColor.textFieldBorder,
                          disableBorderColor: MyColor.textFieldBorder,
                          needOutlineBorder: true,
                          borderRadious: 8,
                          controller: controller.amountController,
                          labelText: MyStrings.enterAmount.tr,
                          labelTextColor: MyColor.subTitleTextColor,
                          isSuffixContainer: true,
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
                          haswinAmount: true,
                          maximum: controller.maximum,
                          minimum: controller.minimum,
                          winAmount: controller.winningPercentage,
                          currencySym: controller.defaultCurrency,
                        ),
                        const SizedBox(height: Dimensions.space10),
                        Container(
                          margin: const EdgeInsets.symmetric(
                            vertical: Dimensions.space10,
                          ),
                          padding: const EdgeInsets.all(Dimensions.space6),
                          decoration: BoxDecoration(
                            color: MyColor.secondaryPrimaryColor,
                            borderRadius: BorderRadius.circular(
                              Dimensions.space8,
                            ),
                          ),
                          child: GridView.builder(
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                ),
                            shrinkWrap: true,
                            itemCount: controller.rockScissorPaperImages.length,
                            itemBuilder: (context, index) {
                              return OptionSelectionContainer(
                                isSelected:
                                    controller.userChoice != null &&
                                    controller.userChoice!.index == index,
                                images:
                                    controller.rockScissorPaperImages[index],
                                onTap: () {
                                  AudioPlayer().play(
                                    AssetSource(MyAudio.clickAudio),
                                  );
                                  controller.amountFocusNode.unfocus();
                                  if (index == 0) {
                                    controller.setUserChoice(Choice.rock);
                                  }
                                  if (index == 1) {
                                    controller.setUserChoice(Choice.paper);
                                  }
                                  if (index == 2) {
                                    controller.setUserChoice(Choice.scissors);
                                  }
                                },
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: Dimensions.space14),
                        controller.isSubmitting
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
                                    if (controller.userChoice != null) {
                                      controller.submitInvestmentRequest();
                                    } else {
                                      CustomSnackBar.error(
                                        errorList: [MyStrings.selectYourChoice],
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
                        const SizedBox(height: Dimensions.space50),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
