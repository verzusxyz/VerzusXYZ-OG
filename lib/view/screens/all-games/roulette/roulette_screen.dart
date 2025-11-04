import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:verzusxyz/core/utils/dimensions.dart';
import 'package:verzusxyz/core/utils/my_color.dart';
import 'package:verzusxyz/core/utils/my_strings.dart';
import 'package:verzusxyz/data/controller/all_games/roulette/roulette_controller.dart';
import 'package:verzusxyz/data/repo/all-games/roulete/roulette_repo.dart';
import 'package:verzusxyz/view/components/buttons/rounded_button.dart';
import 'package:verzusxyz/view/components/buttons/rounded_loading_button.dart';
import 'package:verzusxyz/view/components/card/game_top_section.dart';
import 'package:verzusxyz/view/components/snack_bar/show_custom_snackbar.dart';
import 'package:verzusxyz/view/components/text-form-field/custom_text_field.dart';
import 'package:verzusxyz/view/screens/all-games/head_tail/widgets/available_balance_card.dart';
import 'packagepackage:verzusxyz/view/screens/all-games/roulette/widget/custom_wheel.dart';
import 'package:verzusxyz/view/screens/all-games/widgets/bet_board.dart';
import 'package:verzusxyz/view/screens/all-games/widgets/minimum_maximum_bonus_section.dart';
import 'package:get/get.dart';

class RouletteScreen extends StatefulWidget {
  const RouletteScreen({Key? key}) : super(key: key);

  @override
  State<RouletteScreen> createState() => _RouletteScreenState();
}

class _RouletteScreenState extends State<RouletteScreen> {
  @override
  void initState() {
    super.initState();
    final walletType = Get.arguments as String;
    Get.put(RouletteRepo());
    Get.put(RouletteController(
      rouletteRepo: Get.find(),
      walletType: walletType,
    ));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<RouletteController>(
        builder: (controller) => Container(
          height: double.infinity,
          decoration: const BoxDecoration(gradient: MyColor.gradientBackground),
          child: SingleChildScrollView(
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
                    curSymbol: '\$',
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: MyColor.secondaryPrimaryColor,
                      border: Border.all(
                        color: MyColor.navBarActiveButtonColor,
                      ),
                      borderRadius: BorderRadius.circular(Dimensions.space8),
                    ),
                    padding: const EdgeInsets.all(Dimensions.space20),
                    width: double.infinity,
                    child: const Stack(
                      alignment: Alignment.center,
                      children: [CustomSpinWheel()],
                    ),
                  ),
                  const SizedBox(height: Dimensions.space15),
                  CustomTextField(
                    animatedLabel: true,
                    borderColor: MyColor.textFieldBorder,
                    disableBorderColor: MyColor.textFieldBorder,
                    needOutlineBorder: true,
                    borderRadious: 8,
                    focusNode: controller.amountFocusNode,
                    controller: controller.amountController,
                    labelText: MyStrings.enterAmount.tr,
                    labelTextColor: MyColor.subTitleTextColor,
                    isSuffixContainer: true,
                    onChanged: (value) {},
                    currrency: 'USD',
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
                    hasBonusAmount: controller.selectedNumbers.isNotEmpty,
                    maximum: controller.maximum,
                    minimum: controller.minimum,
                    winAmount: controller.winningPercentage,
                    currencySym: '\$',
                    bonusAmount: '0', // Placeholder
                  ),
                  const SizedBox(height: Dimensions.space10),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: Dimensions.space10,
                      horizontal: Dimensions.space10,
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: Dimensions.space6,
                      horizontal: Dimensions.space50,
                    ),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: MyColor.secondaryPrimaryColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const BetBoard(),
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
                          color: MyColor.primaryButtonColor,
                          text: MyStrings.playNow,
                          press: () {
                            if (controller.amountController.text.isNotEmpty) {
                              controller.submitInvestmentRequest();
                            } else {
                              CustomSnackBar.error(
                                errorList: [MyStrings.enterInvestmentAmount],
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
