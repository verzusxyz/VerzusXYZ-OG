import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:verzusxyz/data/controller/common/theme_controller.dart';
import 'package:verzusxyz/data/controller/localization/localization_controller.dart';
import 'package:verzusxyz/data/controller/splash/splash_controller.dart';
import 'package:verzusxyz/data/repo/splash/splash_repo.dart';

/// Initializes and registers all the necessary dependencies for the application.
///
/// This function sets up and injects controllers, repositories, and other services
/// using the `Get` library for dependency management. It also initializes
/// `SharedPreferences` for local storage.
///
/// This function is called at the start of the application to ensure that all
/// required services are available for injection throughout the app.
///
/// - Returns a [Future] that completes with a map of language codes to language data.
Future<Map<String, Map<String, String>>> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  Get.lazyPut(() => sharedPreferences, fenix: true);
  Get.lazyPut(() => SplashRepo());
  Get.lazyPut(() => LocalizationController(sharedPreferences: Get.find()));
  Get.lazyPut(
    () =>
        SplashController(repo: Get.find(), localizationController: Get.find()),
  );
  Get.lazyPut(() => ThemeController(sharedPreferences: Get.find()));

  Map<String, Map<String, String>> language = {};
  language['en_US'] = {'': ''};

  return language;
}
