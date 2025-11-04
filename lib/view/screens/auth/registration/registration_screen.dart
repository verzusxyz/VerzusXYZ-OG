import 'package:flutter/material.dart';
import 'package:verzusxyz/view/screens/auth/registration/widget/registration_body_section/registration_body_section.dart';
import 'package:get/get.dart';
import 'package:verzusxyz/core/route/route.dart';
import 'package:verzusxyz/core/utils/my_color.dart';
import 'package:verzusxyz/core/utils/my_images.dart';
import 'package:verzusxyz/data/controller/auth/auth/registration_controller.dart';
import 'package:verzusxyz/data/repo/auth/signup_repo.dart';
import 'package:verzusxyz/view/components/will_pop_widget.dart';

/// A widget that displays the registration screen of the application.
///
/// This widget is responsible for initializing the `RegistrationController` and
/// displaying the registration form.
class RegistrationScreen extends StatefulWidget {
  /// Creates a new [RegistrationScreen] instance.
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  void initState() {
    super.initState();
    Get.put(RegistrationRepo());
    Get.put(
      RegistrationController(
        registrationRepo: Get.find(),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegistrationController>(
      builder: (controller) => WillPopWidget(
        nextRoute: RouteHelper.loginScreen,
        child: Scaffold(
          backgroundColor: MyColor.primaryColor,
          body: GetBuilder<RegistrationController>(
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
                  const RegistrationBodySection(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
