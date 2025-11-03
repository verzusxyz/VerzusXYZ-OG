import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:verzusxyz/core/utils/dimensions.dart';
import 'package:verzusxyz/core/utils/my_audio.dart';
import 'package:verzusxyz/core/utils/my_color.dart';
import 'package:verzusxyz/core/utils/my_images.dart';
import 'package:verzusxyz/core/utils/my_strings.dart';
import 'package:verzusxyz/core/utils/style.dart';
import 'package:verzusxyz/core/utils/util.dart';
import 'package:verzusxyz/data/controller/all_games/keno/keno_screen_controller.dart';
import 'package:verzusxyz/data/repo/all-games/keno/keno_repo.dart';
import 'package:verzusxyz/data/services/api_service.dart';
import 'package:verzusxyz/view/components/buttons/rounded_button.dart';
import 'package:verzusxyz/view/components/buttons/rounded_loading_button.dart';
import 'package:verzusxyz/view/components/card/game_top_section.dart';
import 'package:verzusxyz/view/components/custom_loader/custom_loader.dart';
import 'package:verzusxyz/view/components/snack_bar/show_custom_snackbar.dart';
import 'package:verzusxyz/view/components/text-form-field/custom_text_field.dart';
import 'package:verzusxyz/view/screens/all-games/head_tail/widgets/available_balance_card.dart';
import 'package:verzusxyz/view/screens/all-games/keno/widgets/keno_buttons.dart';
import 'package:verzusxyz/view/screens/all-games/widgets/minimum_maximum_bonus_section.dart';
import 'package:get/get.dart';

class KenoScreen extends StatefulWidget {
  const KenoScreen({Key? key}) : super(key: key);

  @override
  State<KenoScreen> createState() => _KenoScreenState();
}

class _KenoScreenState extends State<KenoScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(KenoRepo(apiClient: Get.find()));
    final controller = Get.put(KenoScreenController(kenoRepo: Get.find()));

    super.initState();
    controller.loadGameInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<KenoScreenController>(
        builder: (controller) => Container(
          height: double.infinity,
          decoration: const BoxDecoration(gradient: MyColor.gradientBackground),
          child: controller.isLoading
              ? const CustomLoader(loaderColor: MyColor.primaryColor)
              : SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
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
                        Column(
                          children: [
                            GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.kenoNumbers.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 10,
                                  ),
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    if (!controller
                                        .kenoNumbers[index]
                                        .isSelected) {
                                      if (controller.selectedCount < 10) {
                                        AudioPlayer().play(
                                          AssetSource(MyAudio.kenoTapAudio),
                                        );
                                        controller
                                                .kenoNumbers[index]
                                                .isSelected =
                                            true;
                                      } else {
                                        CustomSnackBar.error(
                                          errorList: [(MyStrings.maximumLimit)],
                                        );
                                      }
                                    }
                                    controller.printSelectedNumbers();
                                    controller.update();
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.all(
                                      Dimensions.space1,
                                    ),
                                    decoration: BoxDecoration(
                                      color:
                                          controller
                                              .kenoNumbers[index]
                                              .isSelected
                                          ? MyColor.navBarActiveButtonColor
                                          : controller
                                                .kenoNumbers[index]
                                                .isFromAdmin
                                          ? MyColor.greenP
                                          : MyColor.colorBgCard,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        color:
                                            controller
                                                .kenoNumbers[index]
                                                .isSelected
                                            ? MyColor.navBarActiveButtonColor
                                            : controller
                                                  .kenoNumbers[index]
                                                  .isFromAdmin
                                            ? MyColor.greenP
                                            : MyColor.navBarActiveButtonColor,
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        controller.kenoNumbers[index].number
                                            .toString()
                                            .tr,
                                        style: semiBoldLarge.copyWith(
                                          color:
                                              controller
                                                  .kenoNumbers[index]
                                                  .isSelected
                                              ? MyColor.colorBgCard
                                              : controller
                                                    .kenoNumbers[index]
                                                    .isFromAdmin
                                              ? MyColor.colorBgCard
                                              : MyColor.navBarActiveButtonColor,
                                          fontFamily: "Inter",
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: Dimensions.space10),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: RichText(
                                textAlign: TextAlign.left,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: MyStrings.select.tr,
                                      style: regularLarge.copyWith(
                                        color: MyColor.colorWhite,
                                        fontFamily: "Inter",
                                      ),
                                    ),
                                    TextSpan(
                                      text: MyStrings.tenNumbers.tr,
                                      style: regularLarge.copyWith(
                                        color: MyColor.navBarActiveButtonColor,
                                        fontFamily: "Inter",
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: Dimensions.space20),
                            Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      AudioPlayer().play(
                                        AssetSource(MyAudio.kenoTapAudio),
                                      );
                                      controller.selectRandomNumbers();
                                    },
                                    child: KenoButtons(
                                      text: MyStrings.random.tr,
                                      image: MyImages.random,
                                      borderColor: MyColor.skyBlueColor,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: Dimensions.space10),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      AudioPlayer().play(
                                        AssetSource(MyAudio.kenoTapAudio),
                                      );
                                      controller.resetAllSelection();
                                    },
                                    child: KenoButtons(
                                      text: MyStrings.refresh.tr,
                                      image: MyImages.refresh,
                                      borderColor: MyColor.colorGreen,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: Dimensions.space15),
                        CustomTextField(
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
                          haswinAmount: false,
                          maximum: controller.maxAoumnnt,
                          minimum: controller.minimumAoumnnt,
                          winAmount: "",
                          currencySym: controller.defaultCurrency,
                        ),
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
                                text: MyStrings.playNow.tr,
                                press: () {
                                  controller.amountFocusNode.unfocus();
                                  if (controller
                                      .amountController
                                      .text
                                      .isNotEmpty) {
                                    if (controller.selectedNumbers.length ==
                                        10) {
                                      controller.submitInvestmentRequest();
                                    } else {
                                      CustomSnackBar.error(
                                        errorList: [
                                          MyStrings
                                              .youHaveToSelectMinimumTenNumber,
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
                        Container(
                          margin: const EdgeInsets.only(
                            top: Dimensions.space20,
                          ),
                          decoration: BoxDecoration(
                            color: MyColor.secondaryPrimaryColor,
                            border: Border.all(
                              color: MyColor.navBarActiveButtonColor,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.all(Dimensions.space20),
                          width: double.infinity,
                          child: Column(
                            children: [
                              Text(
                                MyStrings.howToWin.tr,
                                style: semiBoldOverLarge.copyWith(
                                  color: MyColor.colorWhite,
                                  fontFamily: "Inter",
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: MyStrings.clickThe.tr,
                                      style: regularLarge.copyWith(
                                        color: MyColor.colorWhite,
                                        fontFamily: "Inter",
                                      ),
                                    ),
                                    TextSpan(
                                      text: MyStrings.ten.tr,
                                      style: regularLarge.copyWith(
                                        color: MyColor.navBarActiveButtonColor,
                                        fontFamily: "Inter",
                                      ),
                                    ),
                                    TextSpan(
                                      text: MyStrings
                                          .numberThatAreOnYourScratchOffAndThenClick
                                          .tr,
                                      style: regularLarge.copyWith(
                                        color: MyColor.colorWhite,
                                        fontFamily: "Inter",
                                      ),
                                    ),
                                    TextSpan(
                                      text: " \"${MyStrings.playnow.tr}\" ",
                                      style: semiBoldMediumLarge.copyWith(
                                        color: MyColor.navBarActiveButtonColor,
                                        fontFamily: "Inter",
                                      ),
                                    ),
                                    TextSpan(
                                      text: MyStrings
                                          .buttonToSeeIfYouAreAWinner
                                          .tr,
                                      style: regularLarge.copyWith(
                                        color: MyColor.colorWhite,
                                        fontFamily: "Inter",
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: Dimensions.space20),
                              ListView.separated(
                                padding: EdgeInsets.zero,
                                physics: const NeverScrollableScrollPhysics(),
                                separatorBuilder: (context, index) {
                                  return const Divider();
                                },
                                shrinkWrap: true,
                                itemCount: controller.gameLavels.length,
                                itemBuilder: ((context, index) {
                                  return ListTile(
                                    leading: Text(
                                      "${MyStrings.ifMatch.tr} ${controller.gameLavels[index].level.toString().tr} ${MyStrings.number.tr}",
                                      style: regularLarge.copyWith(
                                        color: MyColor.colorWhite,
                                        fontFamily: "Inter",
                                      ),
                                    ),
                                    trailing: Text(
                                      "${controller.gameLavels[index].percent.toString()} ${MyUtils.getPercentSign()}",
                                      style: regularLarge.copyWith(
                                        color: MyColor.navBarActiveButtonColor,
                                        fontFamily: "Inter",
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ],
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
