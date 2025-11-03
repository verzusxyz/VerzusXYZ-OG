import 'dart:convert';
import 'dart:ui';
import 'package:verzusxyz/data/model/language/main_language_response_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/helper/shared_preference_helper.dart';
import '../../../core/route/route.dart';
import '../../../core/utils/messages.dart';
import '../../../view/components/snack_bar/show_custom_snackbar.dart';
import '../../model/global/response_model/response_model.dart';
import '../../model/language/language_model.dart';
import '../../repo/auth/general_setting_repo.dart';
import '../localization/localization_controller.dart';

class MyLanguageController extends GetxController {
  GeneralSettingRepo repo;
  LocalizationController localizationController;
  MyLanguageController({
    required this.repo,
    required this.localizationController,
  });

  bool isLoading = true;
  List<LanguageModel> appLanguageList = [];

  void loadAppLanguage() {
    appLanguageList.clear();
    isLoading = true;

    SharedPreferences pref = repo.apiClient.sharedPreferences;
    String languageString =
        pref.getString(SharedPreferenceHelper.languageListKey) ?? '';

    var language = jsonDecode(languageString);
    MainLanguageResponseModel model = MainLanguageResponseModel.fromJson(
      language,
    );

    if (model.data?.languages != null && model.data!.languages!.isNotEmpty) {
      for (var listItem in model.data!.languages!) {
        LanguageModel model = LanguageModel(
          imageUrl: listItem.icon ?? '',
          languageCode: listItem.code ?? '',
          countryCode: listItem.name ?? '',
          languageName: listItem.name ?? '',
        );
        appLanguageList.add(model);
      }
    }

    String languageCode =
        pref.getString(SharedPreferenceHelper.languageCode) ?? 'en';

    if (appLanguageList.isNotEmpty) {
      int index = appLanguageList.indexWhere(
        (element) =>
            element.languageCode.toLowerCase() == languageCode.toLowerCase(),
      );
      changeSelectedIndex(index);
    }

    isLoading = false;
    update();
  }

  bool isChangeLangLoading = false;

  void changeLanguage(int index, {bool isComeFromSplashScreen = false}) async {
    isChangeLangLoading = true;
    update();

    LanguageModel selectedLangModel = appLanguageList[index];
    String languageCode = selectedLangModel.languageCode ?? "";

    ResponseModel response = await repo.getLanguage(languageCode);

    if (response.statusCode == 200) {
      try {
        Map<String, Map<String, String>> language = {};
        var resJson = jsonDecode(response.responseJson);
        await repo.apiClient.sharedPreferences.setString(
          SharedPreferenceHelper.languageListKey,
          response.responseJson,
        );
        var value = resJson['data']['language_data'] as Map<String, dynamic>;
        Map<String, String> json = {};
        value.forEach((key, value) {
          json[key] = value.toString();
        });

        language['${appLanguageList[index].languageCode}_${'US'}'] = json;

        Get.clearTranslations();
        Get.addTranslations(Messages(languages: language).keys);

        Locale local = Locale(appLanguageList[index].languageCode, 'US');
        localizationController.setLanguage(local);
      } catch (e) {
        CustomSnackBar.error(errorList: [e.toString()]);
      }
    } else {
      CustomSnackBar.error(errorList: [response.message]);
    }

    isChangeLangLoading = false;
    update();

    Get.back();
  }

  int selectedIndex = 0;
  void changeSelectedIndex(int index) {
    selectedIndex = index;
    update();
  }
}
