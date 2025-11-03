import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:verzusxyz/core/helper/shared_preference_helper.dart';
import 'package:verzusxyz/core/utils/my_strings.dart';

/// A controller for managing the application's theme.
class ThemeController extends GetxController implements GetxService {
  /// The shared preferences instance for storing and retrieving the theme settings.
  final SharedPreferences sharedPreferences;

  bool _darkTheme = true;

  /// Whether the dark theme is currently enabled.
  bool get darkTheme => _darkTheme;

  /// Creates a new [ThemeController] instance.
  ///
  /// - [sharedPreferences]: The shared preferences instance.
  ThemeController({required this.sharedPreferences}) {
    _loadCurrentTheme();
  }

  void _loadCurrentTheme() {
    _darkTheme =
        sharedPreferences.getBool(SharedPreferenceHelper.theme) ?? true;
    update();
  }

  /// Toggles the application's theme between dark and light mode.
  void changeTheme() {
    _darkTheme = !_darkTheme;
    sharedPreferences.setBool(MyStrings.theme, _darkTheme);
    if (_darkTheme) {
      //Get.changeTheme(dark);
    } else {
      //Get.changeTheme(light);
    }

    update();
  }
}
