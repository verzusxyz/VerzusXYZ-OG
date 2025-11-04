import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:verzusxyz/core/utils/dimensions.dart';
import 'package:verzusxyz/core/utils/my_color.dart';
import 'package:verzusxyz/core/utils/my_strings.dart';
import 'package:verzusxyz/core/utils/style.dart';
import 'package:verzusxyz/data/controller/auth/forget_password/forget_password_controller.dart';
import 'package:verzusxyz/data/repo/auth/login_repo.dart';
import 'package:verzusxyz/data/services/api_service.dart';
import 'package:verzusxyz/view/components/app-bar/custom_appbar.dart';
import 'package:verzusxyz/view/components/text-form-field/custom_text_field.dart';
import 'package:verzusxyz/view/components/text/default_text.dart';

import '../../../../components/buttons/gradient_rounded_button.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(LoginRepo(apiClient: Get.find()));
    Get.put(ForgetPasswordController(loginRepo: Get.find()));

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: MyColor.gradientBackground),
      child: Scaffold(
        backgroundColor: MyColor.transparentColor,
        appBar: CustomAppBar(
          fromAuth: true,
          isShowBackBtn: true,
          title: MyStrings.forgetPassword.tr,
          bgColor: MyColor.searchFieldColor,
        ),
        body: GetBuilder<ForgetPasswordController>(
          builder: (auth) => SingleChildScrollView(
            padding: Dimensions.screenPaddingHV,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: Dimensions.space30 + 15),
                  DefaultText(
                    text: MyStrings.forgetPasswordSubText.tr,
                    textAlign: TextAlign.center,
                    textStyle: regularLargeInter.copyWith(
                      color: MyColor.textColor,
                    ),
                  ),
                  const SizedBox(height: Dimensions.space40),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.space14,
                    ),
                    child: Column(
                      children: [
                        CustomTextField(
                          fillColor: MyColor.bottomColor,
                          animatedLabel: false,
                          needOutlineBorder: true,
                          labelText: MyStrings.usernameOrEmail.tr,
                          hintText: MyStrings.usernameOrEmailHint.tr,
                          textInputType: TextInputType.emailAddress,
                          inputAction: TextInputAction.done,
                          controller: auth.emailOrUsernameController,
                          onSuffixTap: () {},
                          onChanged: (value) {
                            return;
                          },
                          validator: (value) {
                            if (auth.emailOrUsernameController.text.isEmpty) {
                              return MyStrings.enterEmailOrUserName.tr;
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: Dimensions.space25),
                        GradientRoundedButton(
                          showLoadingIcon: auth.submitLoading,
                          verticalPadding: 15,
                          text: MyStrings.confirm.tr,
                          press: () {
                            if (_formKey.currentState!.validate()) {
                              auth.submitForgetPassCode();
                            }
                          },
                        ),
                        const SizedBox(height: Dimensions.space40),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
