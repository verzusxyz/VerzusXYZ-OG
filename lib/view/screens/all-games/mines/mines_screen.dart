import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:verzusxyz/core/utils/dimensions.dart';
import 'package:verzusxyz/core/utils/my_audio.dart';
import 'package:verzusxyz/core/utils/my_color.dart';
import 'package:verzusxyz/core/utils/my_images.dart';
import 'package:verzusxyz/core/utils/my_strings.dart';
import 'package:verzusxyz/core/utils/style.dart';
import 'package:verzusxyz/data/controller/all_games/mines/mines_screen_controller.dart';
import 'package:verzusxyz/data/repo/all-games/mines/mines_repo.dart';
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

class MinesScreen extends StatefulWidget {
  const MinesScreen({Key? key}) : super(key: key);

  @override
  State<MinesScreen> createState() => _MinesScreenState();
}

class _MinesScreenState extends State<MinesScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(MinesRepo(apiClient: Get.find()));
    final controller = Get.put(MinesScreenController(minesRepo: Get.find()));
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.loadGameInfo();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<MinesScreenController>(
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
                          name: controller.gameName.tr,
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
                            borderRadius: BorderRadius.circular(
                              Dimensions.space8,
                            ),
                          ),
                          padding: const EdgeInsets.all(Dimensions.space20),
                          width: double.infinity,
                          child: Column(
                            children: [
                              GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: controller.mines.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 5,
                                    ),
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      if (controller
                                          .amountController
                                          .text
                                          .isEmpty) {
                                        CustomSnackBar.error(
                                          errorList: [
                                            MyStrings.enterInvestmentAmount,
                                          ],
                                        );
                                      } else {
                                        if (controller
                                            .minesController
                                            .text
                                            .isEmpty) {
                                          CustomSnackBar.error(
                                            errorList: [
                                              MyStrings.selectNumberofMines,
                                            ],
                                          );
                                        } else {
                                          if (!controller.startMine) {
                                            CustomSnackBar.error(
                                              errorList: [
                                                MyStrings.investFirst,
                                              ],
                                            );
                                          } else {
                                            controller.tapBox(index);
                                          }
                                        }
                                      }

                                      controller.update();
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.all(
                                        Dimensions.space5,
                                      ),
                                      decoration: const BoxDecoration(
                                        color: MyColor.minesBackFieldColor,
                                      ),
                                      child: Image.asset(
                                        controller.mines[index].tapped
                                            ? controller.mines[index].imagePath
                                            : MyImages.treasureBoxOff,
                                      ),
                                    ),
                                  );
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
                          haswinAmount: false,
                          maximum: controller.maxAoumnnt,
                          minimum: controller.minimumAoumnnt,
                          winAmount: "",
                          currencySym: controller.defaultCurrency,
                        ),
                        controller.cashOutAvailable
                            ? const SizedBox()
                            : Container(
                                margin: const EdgeInsets.symmetric(
                                  vertical: Dimensions.space10,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: Dimensions.space6,
                                  horizontal: Dimensions.space10,
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
                                      MyStrings.enterNumberofMines.tr,
                                      style: regularDefault.copyWith(
                                        color: MyColor.colorWhite,
                                        fontFamily: "Inter",
                                      ),
                                    ),
                                    const SizedBox(height: Dimensions.space5),
                                    CustomTextField(
                                      animatedLabel: true,
                                      borderColor: MyColor.textFieldBorder,
                                      disableBorderColor:
                                          MyColor.textFieldBorder,
                                      needOutlineBorder: true,
                                      borderRadious: 8,
                                      controller: controller.minesController,
                                      labelText: MyStrings.numberOfMines.tr,
                                      labelTextColor: MyColor.subTitleTextColor,
                                      onChanged: (value) {},
                                      focusNode: controller.minesFocusNode,
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
                                verticalPadding: 15,
                                cornerRadius: 8,
                                color: controller.cashOutAvailable
                                    ? MyColor.greenP
                                    : MyColor.primaryButtonColor,
                                text: controller.cashOutAvailable
                                    ? MyStrings.cashOut
                                    : MyStrings.playNow,
                                press: () {
                                  if (controller
                                      .amountController
                                      .text
                                      .isNotEmpty) {
                                    if (controller
                                        .minesController
                                        .text
                                        .isNotEmpty) {
                                      AudioPlayer().play(
                                        AssetSource(MyAudio.clickAudio),
                                      );
                                      controller.cashOutAvailable
                                          ? controller.cashOut()
                                          : controller
                                                .submitInvestmentRequest();
                                    } else {
                                      CustomSnackBar.error(
                                        errorList: [
                                          MyStrings.selectNumberofMines,
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
                        const SizedBox(height: Dimensions.space30),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
