import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:verzusxyz/core/helper/string_format_helper.dart';
import 'package:verzusxyz/core/utils/dimensions.dart';
import 'package:verzusxyz/core/utils/my_audio.dart';
import 'package:verzusxyz/core/utils/my_color.dart';
import 'package:verzusxyz/core/utils/my_images.dart';
import 'package:verzusxyz/core/utils/my_strings.dart';
import 'package:verzusxyz/core/utils/style.dart';
import 'package:verzusxyz/core/utils/url_container.dart';
import 'package:verzusxyz/core/utils/util.dart';
import 'package:verzusxyz/data/controller/all_games/poker/poker_controller.dart';
import 'package:verzusxyz/data/repo/all-games/poker/poker_repo.dart';
import 'package:verzusxyz/data/services/api_service.dart';
import 'package:verzusxyz/view/components/buttons/rounded_button.dart';
import 'package:verzusxyz/view/components/buttons/rounded_loading_button.dart';
import 'package:verzusxyz/view/components/card/game_top_section.dart';
import 'package:verzusxyz/view/components/custom_loader/custom_loader.dart';

import 'package:verzusxyz/view/components/image/custom_network_image.dart';

import 'package:verzusxyz/view/components/snack_bar/show_custom_snackbar.dart';
import 'package:verzusxyz/view/components/text-form-field/custom_text_field.dart';
import 'package:verzusxyz/view/screens/all-games/black_jack/widgets/button.dart';
import 'package:verzusxyz/view/screens/all-games/head_tail/widgets/available_balance_card.dart';
import 'package:get/get.dart';

class PokerScreen extends StatefulWidget {
  const PokerScreen({Key? key}) : super(key: key);

  @override
  State<PokerScreen> createState() => _PokerScreenState();
}

class _PokerScreenState extends State<PokerScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(PokerRepo(apiClient: Get.find()));
    final controller = Get.put(PokerController(pokerRepo: Get.find()));
    super.initState();
    controller.loadGameInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<PokerController>(
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
                        GridView.builder(
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 5,
                              ),
                          itemCount: controller.pokerImg.length,
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                CustomNetworkImage(
                                  key: ValueKey(controller.pokerImg[index]),
                                  imageUrl:
                                      "${UrlContainer.pokerImage}${controller.pokerImg[index]}",
                                  width: 200,
                                  height: 200,
                                  loaderColor: MyColor.activeIndicatorColor,
                                  placeholder: Image.asset(
                                    MyImages.placeHolderImage,
                                  ),
                                  hasHeight: false,
                                  coverImage: false,
                                ),
                                controller.gesBon[index].isNotEmpty
                                    ? Text(
                                        MyUtils.getIntoSign() +
                                            controller.gesBon[index]
                                                .replaceAll(".00", "")
                                                .tr +
                                            MyUtils.getPercentSign(),
                                        style: regularLarge.copyWith(
                                          color: MyColor.colorWhite,
                                        ),
                                      )
                                    : const SizedBox(),
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: Dimensions.space20),
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
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GridView.builder(
                                padding: const EdgeInsets.all(
                                  Dimensions.space10,
                                ),
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: controller.pokerBackCards.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 5,
                                      childAspectRatio: .5,
                                    ),
                                itemBuilder: (context, index) {
                                  return Container(
                                    padding: const EdgeInsets.all(
                                      Dimensions.space5,
                                    ),
                                    child:
                                        controller
                                            .pokerBackCards[index]
                                            .isNetworkImage
                                        ? CustomNetworkImage(
                                            key: ValueKey(
                                              "${controller.pokerBackCards[index]}",
                                            ),
                                            imageUrl:
                                                "${UrlContainer.blackJackCardsImage}${controller.pokerBackCards[index].imagePath}.png",
                                            width: 200,
                                            height: 200,
                                            loaderColor:
                                                MyColor.activeIndicatorColor,
                                            placeholder: Image.asset(
                                              MyImages.placeHolderImage,
                                            ),
                                            hasHeight: false,
                                            coverImage: false,
                                          )
                                        : Image.asset(
                                            controller
                                                .pokerBackCards[index]
                                                .imagePath,
                                            height: Dimensions.space60,
                                            fit: BoxFit.contain,
                                          ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: Dimensions.space15),
                        controller.isCallAndFoldShow
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        if (!controller.isCalled) {
                                          controller.call();
                                          AudioPlayer().play(
                                            AssetSource(MyAudio.clickAudio),
                                          );
                                        }
                                      },
                                      child: Buttons(
                                        isLoading: controller.isCalled,
                                        text: MyStrings.call,
                                        color: MyColor.greenP,
                                        loaderColor: MyColor.greenP,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: Dimensions.space5),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        if (!controller.isFold) {
                                          controller.fold();
                                          AudioPlayer().play(
                                            AssetSource(MyAudio.clickAudio),
                                          );
                                        }
                                      },
                                      child: Buttons(
                                        isLoading: controller.isFold,
                                        text: MyStrings.fold,
                                        color: MyColor.redColor,
                                        loaderColor: MyColor.redColor,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : const SizedBox(),
                        controller.isDeal
                            ? SizedBox(
                                width: double.infinity,
                                child: InkWell(
                                  onTap: () {
                                    if (!controller.isDealLoading) {
                                      controller.deal();
                                      AudioPlayer().play(
                                        AssetSource(MyAudio.clickAudio),
                                      );
                                    }
                                  },
                                  child: Buttons(
                                    isLoading: controller.isDealLoading,
                                    text: MyStrings.deal,
                                    color: MyColor.greenP,
                                    loaderColor: MyColor.greenP,
                                  ),
                                ),
                              )
                            : const SizedBox(),
                        controller.isInvested
                            ? const SizedBox()
                            : CustomTextField(
                                animatedLabel: true,
                                borderColor: MyColor.textFieldBorder,
                                disableBorderColor: MyColor.textFieldBorder,
                                needOutlineBorder: true,
                                borderRadious: Dimensions.space8,
                                controller: controller.amountController,
                                labelText: MyStrings.enterAmount.tr,
                                focusNode: controller.amiountFocusNode,
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
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${MyStrings.minimum.tr}: ${(Converter.formatNumber(controller.minimum))} ${controller.defaultCurrency} | ${MyStrings.maximum.tr}: ${(Converter.formatNumber(controller.maximum))} ${controller.defaultCurrency}",
                                      style: regularDefault.copyWith(
                                        color: MyColor.colorWhite,
                                        fontFamily: "Inter",
                                      ),
                                    ),
                                    const SizedBox(height: Dimensions.space15),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: Dimensions.space20),
                        controller.isInvested
                            ? const SizedBox()
                            : Container(
                                child: controller.isSubmitted
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
