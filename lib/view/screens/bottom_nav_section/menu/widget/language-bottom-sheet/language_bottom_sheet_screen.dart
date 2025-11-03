import 'package:flutter/material.dart';
import 'package:verzusxyz/core/utils/dimensions.dart';
import 'package:verzusxyz/core/utils/my_color.dart';
import 'package:verzusxyz/core/utils/my_strings.dart';
import 'package:verzusxyz/core/utils/style.dart';
import 'package:verzusxyz/data/controller/localization/localization_controller.dart';
import 'package:verzusxyz/data/controller/localization/my_language_controller.dart';
import 'package:verzusxyz/data/repo/auth/general_setting_repo.dart';
import 'package:verzusxyz/view/components/bottom-sheet/bottom_sheet_bar.dart';
import 'package:verzusxyz/view/components/custom_loader/custom_loader.dart';
import 'package:get/get.dart';

class LanguageBottomSheetScreen extends StatefulWidget {
  const LanguageBottomSheetScreen({super.key});

  @override
  State<LanguageBottomSheetScreen> createState() =>
      _LanguageBottomSheetScreenState();
}

class _LanguageBottomSheetScreenState extends State<LanguageBottomSheetScreen> {
  @override
  void initState() {
    Get.put(GeneralSettingRepo(apiClient: Get.find()));
    Get.put(LocalizationController(sharedPreferences: Get.find()));
    final controller = Get.put(
      MyLanguageController(
        repo: Get.find(),
        localizationController: Get.find(),
      ),
    );
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.loadAppLanguage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyLanguageController>(
      builder: (myLanguageController) {
        return Center(
          child: SizedBox(
            height: 300,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: Dimensions.space10),
                  const BottomSheetBar(),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      MyStrings.selectALanguage.tr,
                      style: regularMediumLarge.copyWith(
                        color: MyColor.navBarActiveButtonColor,
                      ),
                    ),
                  ),
                  myLanguageController.isChangeLangLoading
                      ? const Center(
                          child: CustomLoader(loaderColor: MyColor.colorWhite),
                        )
                      : ListView.builder(
                          itemCount:
                              myLanguageController.appLanguageList.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            final language =
                                myLanguageController.appLanguageList[index];
                            final selectedValue =
                                myLanguageController
                                    .appLanguageList[myLanguageController
                                    .selectedIndex];

                            return RadioListTile(
                              activeColor: MyColor.navBarActiveButtonColor,
                              title: Text(
                                language.languageName.tr ?? "",
                                style: regularDefault.copyWith(
                                  color: MyColor.colorWhite,
                                ),
                              ),
                              value: language,
                              groupValue: selectedValue,
                              onChanged: (value) {
                                myLanguageController.changeLanguage(index);
                              },
                              controlAffinity: ListTileControlAffinity.trailing,
                            );
                          },
                        ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
