import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:verzusxyz/core/utils/my_color.dart';
import 'package:verzusxyz/core/utils/my_strings.dart';
import 'package:verzusxyz/core/utils/style.dart';
import 'package:verzusxyz/data/controller/account/change_password_controller.dart';
import 'package:verzusxyz/data/repo/account/change_password_repo.dart';
import 'package:verzusxyz/view/components/app-bar/custom_appbar.dart';
import 'package:verzusxyz/view/screens/account/change-password/widget/change_password_form.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  @override
  void initState() {
    super.initState();
    Get.put(ChangePasswordRepo());
    Get.put(ChangePasswordController(changePasswordRepo: Get.find()));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<ChangePasswordController>().clearData();
    });
  }

  @override
  void dispose() {
    Get.find<ChangePasswordController>().clearData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColor.bottomColor,
        appBar: CustomAppBar(
          isShowBackBtn: true,
          title: MyStrings.changePassword.tr,
          bgColor: MyColor.bottomColor,
        ),
        body: GetBuilder<ChangePasswordController>(
          builder: (controller) => SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 45, horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    MyStrings.createNewPassword.tr,
                    style: regularExtraLarge.copyWith(
                      color: MyColor.getTextColor(),
                      fontWeight: FontWeight.w500,
                      fontFamily: "Inter",
                    ),
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.only(right: 50),
                    child: Text(
                      MyStrings.createPasswordSubText.tr,
                      style: regularDefault.copyWith(
                        color: MyColor.getTextColor().withOpacity(0.8),
                        fontFamily: "Inter",
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  const ChangePasswordForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
