import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:verzusxyz/core/route/route.dart';
import 'package:verzusxyz/data/repo/auth/login_repo.dart';
import 'package:verzusxyz/view/components/snack_bar/show_custom_snackbar.dart';

class LoginController extends GetxController {
  final LoginRepo loginRepo;

  LoginController({required this.loginRepo});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;
  bool remember = false;

  Future<void> loginUser() async {
    isLoading = true;
    update();

    UserCredential? userCredential = await loginRepo.loginUser(
      emailController.text,
      passwordController.text,
    );

    if (userCredential != null) {
      Get.offAndToNamed(RouteHelper.bottomNavBar);
    } else {
      // Handle login failure
      CustomSnackBar.error(errorList: ['Login failed. Please try again.']);
    }

    isLoading = false;
    update();
  }

  Future<void> signInWithGoogle() async {
    isLoading = true;
    update();

    UserCredential? userCredential = await loginRepo.signInWithGoogle();

    if (userCredential != null) {
      Get.offAndToNamed(RouteHelper.bottomNavBar);
    } else {
      // Handle login failure
      CustomSnackBar.error(errorList: ['Google Sign-In failed. Please try again.']);
    }

    isLoading = false;
    update();
  }

  void forgetPassword() {
    Get.toNamed(RouteHelper.forgotPasswordScreen);
  }

  void changeRememberMe() {
    remember = !remember;
    update();
  }
}
