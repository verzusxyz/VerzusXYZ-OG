import 'package:flutter/material.dart';
import 'package:verzusxyz/data/controller/localization/my_language_controller.dart';
import 'package:verzusxyz/view/components/bottom-sheet/custom_bottom_sheet.dart';
import 'package:verzusxyz/view/components/buttons/rounded_button.dart';
import 'package:verzusxyz/view/components/buttons/rounded_loading_button.dart';
import 'package:verzusxyz/view/screens/bottom_nav_section/home/widget/top_section.dart';
import 'package:verzusxyz/view/screens/bottom_nav_section/menu/widget/delete_account_bottom_sheet_body.dart';
import 'package:verzusxyz/view/screens/bottom_nav_section/menu/widget/language-bottom-sheet/language_bottom_sheet_screen.dart';
import 'package:get/get.dart';
import 'package:verzusxyz/core/route/route.dart';
import 'package:verzusxyz/core/utils/dimensions.dart';
import 'package:verzusxyz/core/utils/my_color.dart';
import 'package:verzusxyz/core/utils/my_images.dart';
import 'package:verzusxyz/core/utils/my_strings.dart';
import 'package:verzusxyz/core/utils/style.dart';
import 'package:verzusxyz/data/controller/localization/localization_controller.dart';
import 'package:verzusxyz/data/controller/menu/my_menu_controller.dart';
import 'package:verzusxyz/data/repo/auth/general_setting_repo.dart';
import 'package:verzusxyz/data/repo/menu_repo/menu_repo.dart';
import 'package:verzusxyz/data/services/api_service.dart';
import 'package:verzusxyz/view/components/divider/custom_divider.dart';
import 'package:verzusxyz/view/screens/bottom_nav_section/menu/widget/menu_item.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(GeneralSettingRepo(apiClient: Get.find()));
    Get.put(MenuRepo(apiClient: Get.find()));
    final controller = Get.put(
      MyMenuController(menuRepo: Get.find(), repo: Get.find()),
    );
    Get.put(
      MyLanguageController(
        repo: Get.find(),
        localizationController: Get.find(),
      ),
    );
    Get.put(LocalizationController(sharedPreferences: Get.find()));
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocalizationController>(
      builder: (localizationController) => GetBuilder<MyMenuController>(
        builder: (menuController) => SafeArea(
          child: Container(
            decoration: const BoxDecoration(
              gradient: MyColor.gradientBackground,
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  vertical: Dimensions.space12,
                  horizontal: Dimensions.space10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TopSection(),
                    const SizedBox(height: Dimensions.space20),
                    Text(
                      MyStrings.account.tr,
                      style: regularDefault.copyWith(
                        color: MyColor.colorWhite,
                        fontFamily: "Inter",
                      ),
                    ),
                    const SizedBox(height: Dimensions.space5),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(
                        vertical: Dimensions.space15,
                        horizontal: Dimensions.space15,
                      ),
                      decoration: BoxDecoration(
                        color: MyColor.bottomColor,
                        borderRadius: BorderRadius.circular(
                          Dimensions.defaultRadius,
                        ),
                      ),
                      child: Column(
                        children: [
                          MenuItems(
                            imageSrc: MyImages.user,
                            label: MyStrings.profile.tr,
                            onPressed: () =>
                                Get.toNamed(RouteHelper.profileScreen),
                          ),
                          !menuController.isSocialLoggedIn
                              ? CustomDivider(
                                  space: Dimensions.space10,
                                  color: MyColor.colorWhite.withOpacity(.05),
                                )
                              : const SizedBox.shrink(),
                          !menuController.isSocialLoggedIn
                              ? MenuItems(
                                  imageSrc: MyImages.changePassword,
                                  label: MyStrings.changePassword,
                                  onPressed: () => Get.toNamed(
                                    RouteHelper.changePasswordScreen,
                                  ),
                                )
                              : const SizedBox.shrink(),
                          CustomDivider(
                            space: Dimensions.space10,
                            color: MyColor.colorWhite.withOpacity(.05),
                          ),
                          MenuItems(
                            imageSrc: MyImages.twoFaSecurity,
                            label: MyStrings.twoFactorAuth,
                            onPressed: () =>
                                Get.toNamed(RouteHelper.twoFactorScreen),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: Dimensions.space10),
                    Text(
                      MyStrings.general.tr,
                      style: regularDefault.copyWith(
                        color: MyColor.colorWhite,
                        fontFamily: "Inter",
                      ),
                    ),
                    const SizedBox(height: Dimensions.space10),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(
                        vertical: Dimensions.space15,
                        horizontal: Dimensions.space15,
                      ),
                      decoration: BoxDecoration(
                        color: MyColor.bottomColor,
                        borderRadius: BorderRadius.circular(
                          Dimensions.defaultRadius,
                        ),
                      ),
                      child: Column(
                        children: [
                          MenuItems(
                            imageSrc: MyImages.gameLog,
                            label: MyStrings.gameLog.tr,
                            onPressed: () => Get.toNamed(RouteHelper.gameLog),
                          ),
                          CustomDivider(
                            space: Dimensions.space10,
                            color: MyColor.colorWhite.withOpacity(.05),
                          ),
                          MenuItems(
                            imageSrc: MyImages.myDeposit,
                            label: MyStrings.myDeposit.tr,
                            onPressed: () =>
                                Get.toNamed(RouteHelper.depositsScreen),
                          ),
                          CustomDivider(
                            space: Dimensions.space10,
                            color: MyColor.colorWhite.withOpacity(.05),
                          ),
                          MenuItems(
                            imageSrc: MyImages.withdraw,
                            label: MyStrings.withdraw.tr,
                            onPressed: () =>
                                Get.toNamed(RouteHelper.withdrawScreen),
                          ),
                          CustomDivider(
                            space: Dimensions.space10,
                            color: MyColor.colorWhite.withOpacity(.05),
                          ),
                          MenuItems(
                            imageSrc: MyImages.transaction,
                            label: MyStrings.transaction.tr,
                            onPressed: () => Get.toNamed(
                              RouteHelper.transactionHistoryScreen,
                            ),
                          ),
                          Visibility(
                            visible: menuController.langSwitchEnable,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CustomDivider(
                                  space: Dimensions.space10,
                                  color: MyColor.colorWhite.withOpacity(.05),
                                ),
                                MenuItems(
                                  imageSrc: MyImages.language,
                                  label: MyStrings.language.tr,
                                  onPressed: () {
                                    CustomBottomSheet(
                                      bgColor: MyColor.bottomColor,
                                      child: const LanguageBottomSheetScreen(),
                                    ).customBottomSheet(context);
                                  },
                                ),
                              ],
                            ),
                          ),
                          CustomDivider(
                            space: Dimensions.space10,
                            color: MyColor.colorWhite.withOpacity(.05),
                          ),
                          MenuItems(
                            imageSrc: MyImages.refferal,
                            label: MyStrings.referal.tr,
                            onPressed: () =>
                                Get.toNamed(RouteHelper.refferalScreen),
                          ),
                          CustomDivider(
                            space: Dimensions.space10,
                            color: MyColor.colorWhite.withOpacity(.05),
                          ),
                          MenuItems(
                            imageSrc: MyImages.faq,
                            label: MyStrings.faq.tr,
                            onPressed: () {
                              Get.toNamed(RouteHelper.faqScreen);
                            },
                          ),
                          CustomDivider(
                            space: Dimensions.space10,
                            color: MyColor.colorWhite.withOpacity(.05),
                          ),
                          MenuItems(
                            imageSrc: MyImages.deleteAccount,
                            label: MyStrings.deleteAccount.tr,
                            onPressed: () {
                              CustomBottomSheet(
                                isNeedMargin: true,
                                isNeedPadding: false,
                                child: const DeleteAccountBottomsheetBody(),
                              ).customBottomSheet(context);
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: Dimensions.space10),
                    Text(
                      MyStrings.policy.tr,
                      style: regularDefault.copyWith(
                        color: MyColor.colorWhite,
                        fontFamily: "Inter",
                      ),
                    ),
                    const SizedBox(height: Dimensions.space10),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(
                        vertical: Dimensions.space15,
                        horizontal: Dimensions.space15,
                      ),
                      decoration: BoxDecoration(
                        color: MyColor.bottomColor,
                        borderRadius: BorderRadius.circular(
                          Dimensions.defaultRadius,
                        ),
                      ),
                      child: MenuItems(
                        imageSrc: MyImages.policy,
                        label: MyStrings.privacyPolicy.tr,
                        onPressed: () {
                          Get.toNamed(RouteHelper.privacyScreen);
                        },
                      ),
                    ),
                    const SizedBox(height: Dimensions.space40),
                    menuController.logoutLoading
                        ? const RoundedLoadingBtn(color: MyColor.redP)
                        : RoundedButton(
                            hasCornerRadious: true,
                            isColorChange: true,
                            textColor: MyColor.colorWhite,
                            verticalPadding: Dimensions.space15,
                            cornerRadius: Dimensions.space8,
                            color: MyColor.redP,
                            text: MyStrings.logout,
                            press: () {
                              menuController.logout();
                            },
                          ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
