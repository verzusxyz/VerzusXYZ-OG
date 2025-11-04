import 'package:flutter/material.dart';
import 'package:verzusxyz/view/screens/auth/login/login_body_section/login_body_section.dart';
import 'package:get/get.dart';
import 'package:verzusxyz/core/utils/my_color.dart';
import 'package:verzusxyz/core/utils/my_images.dart';
import 'package:verzusxyz/data/controller/auth/login_controller.dart';
import 'package:verzusxyz/data/repo/auth/login_repo.dart';
import 'package:verzusxyz/view/components/will_pop_widget.dart';

/// A widget that displays the login screen of the application.
///
/// This widget is responsible for initializing the `LoginController` and
/// displaying the login form.
class LoginScreen extends StatefulWidget {
  /// Creates a new [LoginScreen] instance.
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    Get.put(LoginRepo());
    Get.put(LoginController(loginRepo: Get.find()));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<LoginController>().remember = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopWidget(
      nextRoute: '',
      child: Scaffold(
        backgroundColor: MyColor.screenBgColor,
        body: GetBuilder<LoginController>(
          builder: (controller) => SizedBox(
            width: double.infinity,
            child: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(MyImages.loginBg),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: MyColor.secondaryColor950.withOpacity(0.8),
                ),
                const SingleChildScrollView(child: LoginBodySection()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
