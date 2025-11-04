import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:verzusxyz/core/route/route.dart';
import 'package:verzusxyz/data/model/auth/sign_up_model/sign_up_model.dart';
import 'package.verzusxyz/data/repo/auth/signup_repo.dart';
import 'package:verzusxyz/data/services/settings_service.dart';
import 'package:verzusxyz/view/components/snack_bar/show_custom_snackbar.dart';

class RegistrationController extends GetxController {
  final RegistrationRepo registrationRepo;
  final SettingsService settingsService;

  RegistrationController({required this.registrationRepo, required this.settingsService});

  bool isLoading = false;
  bool agreeTC = false;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController cPasswordController = TextEditingController();
  final TextEditingController fNameController = TextEditingController();
  final TextEditingController lNameController = TextEditingController();
  final TextEditingController referralCodeController = TextEditingController();

  bool get needAgreePolicy => settingsService.needAgreePolicy;
  bool get checkPasswordStrength => settingsService.checkPasswordStrength;

  Future<void> signUpUser() async {
    if (needAgreePolicy && !agreeTC) {
      CustomSnackBar.error(errorList: ['Please agree to the terms and conditions.']);
      return;
    }

    isLoading = true;
    update();

    SignUpModel model = SignUpModel(
      firstName: fNameController.text,
      lastName: lNameController.text,
      email: emailController.text,
      password: passwordController.text,
      refference: referralCodeController.text,
      agree: agreeTC,
    );

    UserCredential? userCredential = await registrationRepo.registerUser(model);

    if (userCredential != null) {
      Get.offAndToNamed(RouteHelper.bottomNavBar);
    } else {
      // Handle registration failure
      CustomSnackBar.error(errorList: ['Registration failed. Please try again.']);
    }

    isLoading = false;
    update();
  }

  void updateAgreeTC() {
    agreeTC = !agreeTC;
    update();
  }
}
