import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:verzusxyz/core/route/route.dart';
import 'package:verzusxyz/data/controller/localization/localization_controller.dart';
import 'package:verzusxyz/data/repo/settings/settings_repo.dart';
import 'package:verzusxyz/data/services/settings_service.dart';

/// A controller for managing the splash screen's logic and data.
///
/// This class handles the initialization of the application, including loading
/// language data and global settings, and determining the appropriate next screen to navigate to.
class SplashController extends GetxController {
  final SettingsRepo settingsRepo;
  final LocalizationController localizationController;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  SplashController({required this.settingsRepo, required this.localizationController});

  bool isLoading = true;

  void gotoNextPage() async {
    await localizationController.loadCurrentLanguage();
    await _fetchSettings();

    final User? user = _auth.currentUser;

    if (user != null) {
      Get.offAndToNamed(RouteHelper.bottomNavBar);
    } else {
      Get.offAndToNamed(RouteHelper.loginScreen);
    }
  }

  Future<void> _fetchSettings() async {
    try {
      final settings = await settingsRepo.getSettings();
      Get.find<SettingsService>().setSettings(settings);
    } catch (e) {
      // Handle the case where settings can't be fetched.
      // For now, we'll just print the error.
      print('Error fetching settings: $e');
    }
  }
}
