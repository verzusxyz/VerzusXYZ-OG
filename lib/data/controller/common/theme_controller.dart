import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:verzusxyz/core/helper/shared_preference_helper.dart';
import 'package:verzusxyz/core/utils/my_strings.dart';

/// A controller for managing the application's theme.
///
/// This class is responsible for loading the current theme, toggling between
/// dark and light themes, and persisting the selected theme using `SharedPreferences`.
class ThemeController extends GetxController implements GetxService {
  /// The shared preferences instance for storing and retrieving theme settings.
  final SharedPreferences sharedPreferences;

  bool _darkTheme = true;

  /// A boolean indicating whether the dark theme is currently enabled.
  bool get darkTheme => _darkTheme;

  /// Creates a new [ThemeController] instance.
  ///
  -  /// Requires a [SharedPreferences] instance and loads the current theme upon initialization.
  ThemeController({required this.sharedPreferences}) {
    _loadCurrentTheme();
  }

  void _loadCurrentTheme() {
    _darkTheme =
        sharedPreferences.getBool(SharedPreferenceHelper.theme) ?? true;
    update();
  }

  /// Toggles the application's theme between dark and light mode.
  ///
  /// This method updates the theme state and persists the new setting to `SharedPreferences`.
  /// Note: The actual theme change logic using `Get.changeTheme` is currently commented out.
  void toggleTheme() {
    _darkTheme = !_darkTheme;
    sharedPreferences.setBool(SharedPreferenceHelper.theme, _darkTheme);
    // if (_darkTheme) {
    //   Get.changeTheme(dark);
    // } else {
    //   Get.changeTheme(light);
    // }
    update();
  }
}
