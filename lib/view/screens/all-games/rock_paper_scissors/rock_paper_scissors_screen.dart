import 'package:flutter/material.dart';
import 'package:verzusxyz/core/utils/dimensions.dart';
import 'package:verzusxyz/core/utils/my_color.dart';
import 'package:verzusxyz/core/utils/my_strings.dart';
import 'package:verzusxyz/data/controller/all_games/rock_paper_scissors_controller.dart';
import 'package:verzusxyz/data/repo/all-games/rock_paper_scissors/rock_paper_scissors_repo.dart';
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
    super.initState();
    final walletType = Get.arguments as String;
    Get.put(RockPaperScissorsRepo());
    Get.put(RockPaperScissorsController(
      rockPaperScissorsRepo: Get.find(),
      walletType: walletType,
    ));
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
                          curSymbol: '\$', // Assuming USD
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
                          child:
                              Text('Result will be shown here...'), // Placeholder
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
                          currrency: 'USD',
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
                          currencySym: '\$',
                        ),
                        const SizedBox(height: Dimensions.space10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            OptionSelectionContainer(
                              isSelected: controller.userChoice == Choice.rock,
                              images:
                                  'assets/images/games/rock.png', // Placeholder
                              onTap: () => controller.setUserChoice(Choice.rock),
                            ),
                            OptionSelectionContainer(
                              isSelected: controller.userChoice == Choice.paper,
                              images:
                                  'assets/images/games/paper.png', // Placeholder
                              onTap: () =>
                                  controller.setUserChoice(Choice.paper),
                            ),
                            OptionSelectionContainer(
                              isSelected:
                                  controller.userChoice == Choice.scissors,
                              images:
                                  'assets/images/games/scissors.png', // Placeholder
                              onTap: () =>
                                  controller.setUserChoice(Choice.scissors),
                            ),
                          ],
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
