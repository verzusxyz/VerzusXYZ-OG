import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:verzusxyz/core/helper/shared_preference_helper.dart';
import 'package:verzusxyz/core/route/route.dart';
import 'package:verzusxyz/core/utils/messages.dart';
import 'package:verzusxyz/core/utils/my_strings.dart';
import 'package:verzusxyz/data/controller/localization/localization_controller.dart';
import 'package:verzusxyz/data/model/general_setting/general_setting_response_model.dart';
import 'package:verzusxyz/data/model/global/response_model/response_model.dart';
import 'package:verzusxyz/data/repo/auth/general_setting_repo.dart';
import 'package:verzusxyz/view/components/snack_bar/show_custom_snackbar.dart';

/// A controller for managing the splash screen's logic and data.
///
/// This class handles the initialization of the application, including loading
/// general settings, language data, and determining the appropriate next screen
/// to navigate to.
class SplashController extends GetxController {
  /// The repository for fetching general settings and language data.
  final GeneralSettingRepo repo;

  /// The controller for managing localization and language settings.
  final LocalizationController localizationController;

  /// Creates a new [SplashController] instance.
  ///
  /// Requires a [GeneralSettingRepo] and a [LocalizationController].
  SplashController({required this.repo, required this.localizationController});

  /// A flag indicating whether the splash screen is currently loading data.
  bool isLoading = true;

  /// A flag indicating whether there is an internet connection.
  bool noInternet = false;

  /// Initiates the process of loading initial data and navigating to the next screen.
  ///
  /// This method loads the selected language, checks if the user is remembered,
  /// and fetches the general settings from the backend.
  void gotoNextPage() async {
    await loadLanguage();
    bool isRemember =
        repo.apiClient.sharedPreferences.getBool(
          SharedPreferenceHelper.rememberMeKey,
        ) ??
        false;
    bool isFirstTime =
        repo.apiClient.sharedPreferences.getBool(
          SharedPreferenceHelper.firstTimeOnAppKey,
        ) ??
        true;
    noInternet = false;
    update();

    initSharedData();
    getGSData(isRemember, isFirstTime);
  }

  /// Retrieves the general settings data from the backend.
  ///
  /// - [isRemember]: A boolean indicating if the user's session is remembered.
  /// - [isFirstTime]: A boolean indicating if it's the user's first time on the app.
  void getGSData(bool isRemember, bool isFirstTime) async {
    ResponseModel response = await repo.getGeneralSetting();

    if (response.statusCode == 200) {
      GeneralSettingResponseModel model = GeneralSettingResponseModel.fromJson(
        jsonDecode(response.responseJson),
      );
      if (model.status?.toLowerCase() == MyStrings.success) {
        repo.apiClient.storeGeneralSetting(model);
      } else {
        List<String> message = [MyStrings.somethingWentWrong];
        CustomSnackBar.error(errorList: model.message?.error ?? message);
      }
    } else {
      if (response.statusCode == 503) {
        noInternet = true;
        update();
      }
      CustomSnackBar.error(errorList: [response.message]);
    }

    isLoading = false;
    update();

    if (isRemember) {
      Future.delayed(const Duration(seconds: 1), () {
        Get.offAndToNamed(RouteHelper.bottomNavBar);
      });
    } else {
      Future.delayed(const Duration(seconds: 1), () {
        Get.offAndToNamed(RouteHelper.loginScreen);
      });
    }
  }

  /// Initializes shared data in `SharedPreferences` if it doesn't already exist.
  ///
  /// This method sets the default country and language codes.
  Future<void> initSharedData() async {
    if (!repo.apiClient.sharedPreferences.containsKey(
      SharedPreferenceHelper.countryCode,
    )) {
      await repo.apiClient.sharedPreferences.setString(
        SharedPreferenceHelper.countryCode,
        MyStrings.languages[0].countryCode,
      );
    }
    if (!repo.apiClient.sharedPreferences.containsKey(
      SharedPreferenceHelper.languageCode,
    )) {
      await repo.apiClient.sharedPreferences.setString(
        SharedPreferenceHelper.languageCode,
        MyStrings.languages[0].languageCode,
      );
    }
  }

  /// Loads the language data from the backend.
  ///
  /// This method fetches the language strings for the currently selected language
  /// and adds them to the GetX translations.
  Future<void> loadLanguage() async {
    localizationController.loadCurrentLanguage();
    String languageCode = localizationController.locale.languageCode;

    ResponseModel response = await repo.getLanguage(languageCode);
    if (response.statusCode == 200) {
      try {
        Map<String, Map<String, String>> language = {};
        var resJson = jsonDecode(response.responseJson);
        saveLanguageList(response.responseJson);
        var value = resJson['data']['language_data'] as Map<String, dynamic>;
        Map<String, String> json = {};
        value.forEach((key, value) {
          json[key] = value.toString();
        });
        language[
            '${localizationController.locale.languageCode}_${localizationController.locale.countryCode}'] =
            json;
        Get.addTranslations(Messages(languages: language).keys);
      } catch (e) {
        if (kDebugMode) {
          print(e.toString());
        }
      }
    } else {
      CustomSnackBar.error(errorList: [response.message]);
    }
  }

  /// Saves the language list to `SharedPreferences`.
  ///
  /// - [languageJson]: The language data in JSON string format.
  void saveLanguageList(String languageJson) async {
    await repo.apiClient.sharedPreferences.setString(
      SharedPreferenceHelper.languageListKey,
      languageJson,
    );
  }
}
