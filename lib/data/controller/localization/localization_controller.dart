import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:verzusxyz/core/helper/shared_preference_helper.dart';
import 'package:verzusxyz/core/utils/my_strings.dart';

import '../../model/language/language_model.dart';

/// A controller for managing the application's localization and language settings.
///
/// This class is responsible for loading the current language, setting a new language,
/// and persisting the selected language using `SharedPreferences`.
class LocalizationController extends GetxController {
  /// The shared preferences instance for storing and retrieving language settings.
  final SharedPreferences sharedPreferences;

  /// Creates a new [LocalizationController] instance.
  ///
  /// Requires a [SharedPreferences] instance and loads the current language upon initialization.
  LocalizationController({required this.sharedPreferences}) {
    loadCurrentLanguage();
  }

  Locale _locale = Locale(
    MyStrings.languages[0].languageCode,
    MyStrings.languages[0].countryCode,
  );
  bool _isLtr = true;
  List<LanguageModel> _languages = [];

  /// The currently selected locale.
  Locale get locale => _locale;

  /// A boolean indicating whether the current language is left-to-right.
  bool get isLtr => _isLtr;

  /// The list of available languages.
  List<LanguageModel> get languages => _languages;

  /// Sets the application's language and updates the locale.
  ///
  /// This method updates the locale using GetX, sets the text direction, and saves
  /// the new language to `SharedPreferences`.
  ///
  /// - [locale]: The new locale to set.
  void setLanguage(Locale locale) {
    Get.updateLocale(locale);
    _locale = locale;
    if (_locale.languageCode == 'ar') {
      _isLtr = false;
    } else {
      _isLtr = true;
    }
    saveLanguage(_locale);
    update();
  }

  /// Loads the current language from `SharedPreferences`.
  ///
  /// If no language is found in `SharedPreferences`, it defaults to the first language
  /// in the `MyStrings.languages` list.
  void loadCurrentLanguage() async {
    _locale = Locale(
      sharedPreferences.getString(SharedPreferenceHelper.languageCode) ??
          MyStrings.languages[0].languageCode,
      sharedPreferences.getString(SharedPreferenceHelper.countryCode) ??
          MyStrings.languages[0].countryCode,
    );
    _isLtr = _locale.languageCode != 'ar';
    update();
  }

  /// Saves the selected language to `SharedPreferences`.
  ///
  /// - [locale]: The locale to be saved.
  void saveLanguage(Locale locale) async {
    sharedPreferences.setString(
      SharedPreferenceHelper.languageCode,
      locale.languageCode,
    );
    sharedPreferences.setString(
      SharedPreferenceHelper.countryCode,
      locale.countryCode ?? '',
    );
  }

  int _selectedIndex = 0;

  /// The index of the selected language in the language list.
  int get selectedIndex => _selectedIndex;

  /// Sets the index of the selected language.
  ///
  /// - [index]: The new index to set.
  void setSelectIndex(int index) {
    _selectedIndex = index;
    update();
  }

  /// Searches for a language based on a query.
  ///
  /// Note: The current implementation is a placeholder and does not perform a real search.
  ///
  /// - [query]: The search query.
  void searchLanguage(String query) {
    if (query.isEmpty) {
      _languages = [];
    } else {
      _selectedIndex = -1;
      _languages = [];
    }
    update();
  }
}
