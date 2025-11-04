import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:verzusxyz/core/helper/shared_preference_helper.dart';
import 'package:verzusxyz/core/route/route.dart';
import 'package:verzusxyz/data/controller/localization/localization_controller.dart';
import 'package:verzusxyz/data/repo/splash/splash_repo.dart';

/// A controller for managing the splash screen's logic and data.
///
/// This class handles the initialization of the application, including loading
/// language data, and determining the appropriate next screen to navigate to.
class SplashController extends GetxController {
  final SplashRepo repo;
  final LocalizationController localizationController;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  SplashController({required this.repo, required this.localizationController});

  bool isLoading = true;

  void gotoNextPage() async {
    await localizationController.loadCurrentLanguage();
    final User? user = _auth.currentUser;

    if (user != null) {
      Get.offAndToNamed(RouteHelper.bottomNavBar);
    } else {
      Get.offAndToNamed(RouteHelper.loginScreen);
    }
  }
}
