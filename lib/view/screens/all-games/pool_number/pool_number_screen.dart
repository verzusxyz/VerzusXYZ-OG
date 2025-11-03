import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:verzusxyz/core/utils/dimensions.dart';
import 'package:verzusxyz/core/utils/my_audio.dart';
import 'package:verzusxyz/core/utils/my_color.dart';
import 'package:verzusxyz/core/utils/my_strings.dart';
import 'package:verzusxyz/data/controller/all_games/pool_number/pool_number_controller.dart';
import 'package:verzusxyz/data/repo/all-games/pool_number/pool_number_repo.dart';
import 'package:verzusxyz/data/services/api_service.dart';
import 'package:verzusxyz/view/components/buttons/rounded_button.dart';
import 'package:verzusxyz/view/components/buttons/rounded_loading_button.dart';
import 'package:verzusxyz/view/components/card/game_top_section.dart';
import 'package:verzusxyz/view/components/custom_loader/custom_loader.dart';
import 'package:verzusxyz/view/components/snack_bar/show_custom_snackbar.dart';
import 'package:verzusxyz/view/components/text-form-field/custom_text_field.dart';
import 'package:verzusxyz/view/screens/all-games/head_tail/widgets/available_balance_card.dart';
import 'package:verzusxyz/view/screens/all-games/pool_number/widgets/ball_animation_widget.dart';
import 'package:verzusxyz/view/screens/all-games/widgets/minimum_maximum_bonus_section.dart';
import 'package:verzusxyz/view/screens/all-games/widgets/option_selection_cotainer.dart';
import 'package:get/get.dart';

class PoolNumberScreen extends StatefulWidget {
  const PoolNumberScreen({Key? key}) : super(key: key);

  @override
  State<PoolNumberScreen> createState() => _PoolNumberScreenState();
}

class _PoolNumberScreenState extends State<PoolNumberScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(PoolNumberRepo(apiClient: Get.find()));
    final controller = Get.put(
      PoolNumberController(poolNumberRepo: Get.find()),
    );
    super.initState();
    controller.loadGameInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<PoolNumberController>(
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
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.all(Dimensions.space10),
                          width: double.infinity,
                          height: 300,
                          child: Column(
                            children: [
                              FittedBox(
                                child: Center(
                                  child: PoolNumberResult(
                                    isPlaying: !controller.showResult,
                                    resultNo: '${(controller.d ?? -1)}',
                                    size: Size(
                                      MediaQuery.of(context).size.width,
                                      300,
                                    ),
                                  ),
                                ),
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
                          borderRadious: Dimensions.space8,
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
                          haswinAmount: true,
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
                                  controller.updateSelectedIndex(index);
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
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
