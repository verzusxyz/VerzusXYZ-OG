import 'package:flutter/material.dart';
import 'package:verzusxyz/core/utils/dimensions.dart';
import 'package:verzusxyz/core/utils/my_color.dart';
import 'package:verzusxyz/core/utils/my_strings.dart';
import 'package:verzusxyz/data/controller/all_games/head-tail/head_tail_controller.dart';
import 'package:verzusxyz/data/repo/all-games/head-tail/head_tail_repo.dart';
import 'package:verzusxyz/view/components/buttons/rounded_button.dart';
import 'package:verzusxyz/view/components/buttons/rounded_loading_button.dart';
import 'package:verzusxyz/view/components/card/game_top_section.dart';
import 'package:verzusxyz/view/components/custom_loader/custom_loader.dart';
import 'package:verzusxyz/view/components/snack_bar/show_custom_snackbar.dart';
import 'package:verzusxyz/view/components/text-form-field/custom_text_field.dart';
import 'package:verzusxyz/view/screens/all-games/head_tail/widgets/available_balance_card.dart';
import 'package:verzusxyz/view/screens/all-games/head_tail/widgets/flip_animation.dart';
import 'package:verzusxyz/view/screens/all-games/head_tail/widgets/option_selection_section.dart';
import 'package:verzusxyz/view/screens/all-games/widgets/minimum_maximum_bonus_section.dart';
import 'package:get/get.dart';

class HeadTailScreen extends StatefulWidget {
  const HeadTailScreen({Key? key}) : super(key: key);

  @override
  State<HeadTailScreen> createState() => _HeadTailScreenState();
}

class _HeadTailScreenState extends State<HeadTailScreen> {
  @override
  void initState() {
    super.initState();
    final walletType = Get.arguments as String;
    Get.put(HeadTailRepo());
    Get.put(HeadTailController(
      headTailRepo: Get.find(),
      walletType: walletType,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<HeadTailController>(
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
                          curSymbol: '\$', // Assuming USD for now
                          balance: controller.availableBalance,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: MyColor.secondaryPrimaryColor,
                            border: Border.all(
                              color: MyColor.navBarActiveButtonColor,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.all(Dimensions.space50),
                          width: double.infinity,
                          child: const Center(child: FlipAnimation()),
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
                          onChanged: (value) {},
                          focusNode: controller.amountFocusNode,
                          textInputType: TextInputType.number,
                          currrency: 'USD', // Assuming USD for now
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
                          haswinAmount: controller.winningPercentage != "0",
                          maximum: controller.maximum,
                          minimum: controller.minimum,
                          winAmount: controller.winningPercentage,
                          currencySym: '\$', // Assuming USD for now
                        ),
                        const SizedBox(height: Dimensions.space10),
                        const OptionSelectionSection(),
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
                                      .amountController.text.isNotEmpty) {
                                    controller.submitInvestmentRequest();
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
