import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:verzusxyz/core/helper/string_format_helper.dart';
import 'package:verzusxyz/core/utils/dimensions.dart';
import 'package:verzusxyz/core/utils/my_audio.dart';
import 'package:verzusxyz/core/utils/my_color.dart';
import 'package:verzusxyz/core/utils/my_images.dart';
import 'package:verzusxyz/core/utils/my_strings.dart';
import 'package:verzusxyz/core/utils/style.dart';
import 'package:verzusxyz/core/utils/util.dart';
import 'package:verzusxyz/data/controller/all_games/slot_machine/number_slot_controller.dart';
import 'package:verzusxyz/data/repo/all-games/play_number_slot/play_number_slot_repo.dart';
import 'package:verzusxyz/data/services/api_service.dart';
import 'package:verzusxyz/view/components/buttons/rounded_button.dart';
import 'package:verzusxyz/view/components/buttons/rounded_loading_button.dart';
import 'package:verzusxyz/view/components/card/game_top_section.dart';
import 'package:verzusxyz/view/components/custom_loader/custom_loader.dart';
import 'package:verzusxyz/view/components/snack_bar/show_custom_snackbar.dart';
import 'package:verzusxyz/view/components/text-form-field/custom_text_field.dart';
import 'package:verzusxyz/view/screens/all-games/head_tail/widgets/available_balance_card.dart';
import 'package:verzusxyz/view/screens/all-games/slot_machine/widgets/card_slot.dart';
import 'package:get/get.dart';

class PlayNumberSlotScreen extends StatefulWidget {
  const PlayNumberSlotScreen({Key? key}) : super(key: key);

  @override
  State<PlayNumberSlotScreen> createState() => _PlayNumberSlotScreenState();
}

class _PlayNumberSlotScreenState extends State<PlayNumberSlotScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(PlayNumberSlotRepo(apiClient: Get.find()));
    final controller = Get.put(
      PlayNumberSlotController(playNumberSlot: Get.find()),
    );
    super.initState();
    controller.loadGameInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<PlayNumberSlotController>(
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
                          padding: const EdgeInsets.all(Dimensions.space10),
                          width: double.infinity,
                          child: const SlotMachinePage(),
                        ),
                        const SizedBox(height: Dimensions.space15),
                        CustomTextField(
                          animatedLabel: true,
                          borderColor: MyColor.textFieldBorder,
                          disableBorderColor: MyColor.textFieldBorder,
                          needOutlineBorder: true,
                          focusNode: controller.amountFocusNode,
                          borderRadious: Dimensions.space8,
                          controller: controller.amountController,
                          labelText: MyStrings.enterAmount.tr,
                          labelTextColor: MyColor.subTitleTextColor,
                          isSuffixContainer: true,
                          onChanged: (value) {},
                          textInputType: TextInputType.number,
                          inputAction: TextInputAction.next,
                          currrency: controller.defaultCurrency,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return MyStrings.fieldErrorMsg.tr;
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: Dimensions.space10),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: Dimensions.space18,
                                  ),
                                  child: Image.asset(
                                    MyImages.info,
                                    color: MyColor.colorWhite,
                                    height: Dimensions.space18,
                                  ),
                                ),
                                const SizedBox(width: Dimensions.space5),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${MyStrings.minimum.tr}: ${(Converter.formatNumber(controller.minimumAoumnnt))} ${controller.defaultCurrency} | ${MyStrings.maximum.tr}: ${(Converter.formatNumber(controller.maxAoumnnt))} ${controller.defaultCurrency}",
                                        style: regularDefault.copyWith(
                                          color: MyColor.colorWhite,
                                          fontFamily: "Inter",
                                        ),
                                      ),
                                      controller.levels.isNotEmpty
                                          ? Text(
                                              "${"${MyStrings.winAmount.tr}: ${MyStrings.single}"} (${controller.levels[0]}${MyUtils.getPercentSign()}) | ${MyStrings.double.tr}(${controller.levels[1]}${MyUtils.getPercentSign()}) | ${MyStrings.triple.tr}(${controller.levels[2]}${MyUtils.getPercentSign()})",
                                              style: regularDefault.copyWith(
                                                color: MyColor
                                                    .inActiveIndicatorColor,
                                                fontFamily: "Inter",
                                              ),
                                            )
                                          : const SizedBox(
                                              height: Dimensions.space15,
                                            ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
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
                                MyStrings.selectNumberBetweenZerotoNine,
                                style: regularDefault.copyWith(
                                  color: MyColor.colorWhite,
                                  fontFamily: 'Inter',
                                ),
                              ),
                              const SizedBox(height: Dimensions.space5),
                              CustomTextField(
                                animatedLabel: true,
                                fillColor: MyColor.gusessNumberFieldColor,
                                borderColor: MyColor.textFieldBorder,
                                disableBorderColor: MyColor.textFieldBorder,
                                needOutlineBorder: true,
                                focusNode: controller.enterNumberFocusNode,
                                borderRadious: Dimensions.space8,
                                controller: controller.enterNumberController,
                                labelText: MyStrings.enterNumber.tr,
                                labelTextColor: MyColor.subTitleTextColor,
                                maxLines: 1,
                                maxLength: 1,
                                textAlign: true,
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
                                  if (controller
                                      .amountController
                                      .text
                                      .isNotEmpty) {
                                    if (controller
                                        .enterNumberController
                                        .text
                                        .isNotEmpty) {
                                      controller.submitInvestmentRequest();
                                      AudioPlayer().play(
                                        AssetSource(MyAudio.clickAudio),
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
        ),
      ),
    );
  }
}
