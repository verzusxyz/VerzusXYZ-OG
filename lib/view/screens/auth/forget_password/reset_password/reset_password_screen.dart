import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:verzusxyz/core/route/route.dart';
import 'package:verzusxyz/core/utils/dimensions.dart';
import 'package:verzusxyz/core/utils/my_color.dart';
import 'package:verzusxyz/core/utils/my_strings.dart';
import 'package:verzusxyz/core/utils/style.dart';
import 'package:verzusxyz/data/controller/auth/forget_password/reset_password_controller.dart';
import 'package:verzusxyz/data/repo/auth/login_repo.dart';
import 'package:verzusxyz/data/services/api_service.dart';
import 'package:verzusxyz/view/components/text-form-field/custom_text_field.dart';
import 'package:verzusxyz/view/components/text/default_text.dart';
import 'package:verzusxyz/view/components/text/header_text.dart';
import 'package:verzusxyz/view/components/will_pop_widget.dart';
import 'package:verzusxyz/view/screens/auth/registration/widget/validation_widget.dart';
import '../../../../components/app-bar/custom_appbar.dart';
import '../../../../components/buttons/gradient_rounded_button.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(LoginRepo(apiClient: Get.find()));
    final controller = Get.put(ResetPasswordController(loginRepo: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.email = Get.arguments[0];
      controller.code = Get.arguments[1];
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopWidget(
      nextRoute: RouteHelper.loginScreen,
      child: Container(
        decoration: const BoxDecoration(gradient: MyColor.gradientBackground),
        child: Scaffold(
          backgroundColor: MyColor.transparentColor,
          appBar: CustomAppBar(
            fromAuth: true,
            isShowBackBtn: true,
            bgColor: MyColor.searchFieldColor,
            title: MyStrings.resetPassword.tr,
          ),
          body: GetBuilder<ResetPasswordController>(
            builder: (controller) => SingleChildScrollView(
              padding: Dimensions.screenPaddingHV,
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: Dimensions.space30),
                    const SizedBox(height: Dimensions.space15),
                    DefaultText(
                      text: MyStrings.resetPassContent.tr,
                      textAlign: TextAlign.start,
                      fontSize: Dimensions.fontMediumLarge - 1,
                      textStyle: regularLargeInter.copyWith(
                        color: MyColor.colorWhite,
                      ),
                    ),
                    const SizedBox(height: Dimensions.space15),
                    Focus(
                      onFocusChange: (hasFocus) {
                        controller.changePasswordFocus(hasFocus);
                      },
                      child: CustomTextField(
                        fillColor: MyColor.bottomColor,
                        animatedLabel: true,
                        needOutlineBorder: true,
                        focusNode: controller.passwordFocusNode,
                        nextFocus: controller.confirmPasswordFocusNode,
                        labelText: MyStrings.password,
                        isShowSuffixIcon: true,
                        isPassword: true,
                        textInputType: TextInputType.text,
                        controller: controller.passController,
                        validator: (value) {
                          return controller.validatePassword(value);
                        },
                        onChanged: (value) {
                          if (controller.checkPasswordStrength) {
                            controller.updateValidationList(value);
                          }
                          return;
                        },
                      ),
                    ),
                    Visibility(
                      visible:
                          controller.hasPasswordFocus &&
                          controller.checkPasswordStrength,
                      child: ValidationWidget(
                        list: controller.passwordValidationRules,
                        fromReset: true,
                      ),
                    ),
                    const SizedBox(height: Dimensions.space15),
                    CustomTextField(
                      fillColor: MyColor.bottomColor,
                      animatedLabel: true,
                      needOutlineBorder: true,
                      inputAction: TextInputAction.done,
                      isPassword: true,
                      labelText: MyStrings.confirmPassword.tr,
                      hintText: MyStrings.confirmYourPassword.tr,
                      isShowSuffixIcon: true,
                      controller: controller.confirmPassController,
                      onChanged: (value) {
                        return;
                      },
                      validator: (value) {
                        if (controller.passController.text.toLowerCase() !=
                            controller.confirmPassController.text
                                .toLowerCase()) {
                          return MyStrings.kMatchPassError.tr;
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(height: Dimensions.space35),
                    GradientRoundedButton(
                      showLoadingIcon: controller.submitLoading,
                      verticalPadding: 15,
                      text: MyStrings.submit.tr,
                      press: () {
                        if (formKey.currentState!.validate()) {
                          controller.resetPassword();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
