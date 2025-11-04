import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:verzusxyz/core/utils/dimensions.dart';
import 'package:verzusxyz/core/utils/my_color.dart';
import 'package:verzusxyz/core/utils/my_images.dart';
import 'package:verzusxyz/core/utils/my_strings.dart';
import 'package:verzusxyz/core/utils/style.dart';
import 'package:verzusxyz/data/controller/auth/forget_password/verify_password_controller.dart';
import 'package:verzusxyz/data/repo/auth/login_repo.dart';
import 'package:verzusxyz/data/services/api_service.dart';
import 'package:verzusxyz/view/components/app-bar/custom_appbar.dart';
import 'package:verzusxyz/view/components/image/custom_svg_picture.dart';
import 'package:verzusxyz/view/components/text/default_text.dart';

import '../../../../components/buttons/gradient_rounded_button.dart';

class VerifyForgetPassScreen extends StatefulWidget {
  const VerifyForgetPassScreen({Key? key}) : super(key: key);

  @override
  State<VerifyForgetPassScreen> createState() => _VerifyForgetPassScreenState();
}

class _VerifyForgetPassScreenState extends State<VerifyForgetPassScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(LoginRepo(apiClient: Get.find()));
    final controller = Get.put(VerifyPasswordController(loginRepo: Get.find()));

    controller.email = Get.arguments;

    super.initState();
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
          bgColor: MyColor.searchFieldColor,
          title: MyStrings.passVerification.tr,
        ),
        body: GetBuilder<VerifyPasswordController>(
          builder: (controller) => controller.isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: MyColor.getPrimaryColor(),
                  ),
                )
              : SingleChildScrollView(
                  padding: Dimensions.screenPaddingHV,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: Dimensions.space50),
                        Container(
                          height: 100,
                          width: 100,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: MyColor.primaryColor.withOpacity(.07),
                            shape: BoxShape.circle,
                          ),
                          child: CustomSvgPicture(
                            image: MyImages.emailVerifyImage,
                            height: 50,
                            width: 50,
                            color: MyColor.getPrimaryColor(),
                          ),
                        ),
                        const SizedBox(height: Dimensions.space25),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: DefaultText(
                            text:
                                '${MyStrings.verifyPasswordSubText.tr} : ${controller.getFormatedMail().tr}',
                            textAlign: TextAlign.center,
                            textStyle: regularDefaultInter.copyWith(
                              color: MyColor.textColor,
                            ),
                            textColor: MyColor.textColor,
                          ),
                        ),
                        const SizedBox(height: Dimensions.space40),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: Dimensions.space30,
                          ),
                          child: PinCodeTextField(
                            appContext: context,
                            pastedTextStyle: regularDefaultInter.copyWith(
                              color: MyColor.getPrimaryColor(),
                            ),
                            length: 6,
                            textStyle: regularDefaultInter.copyWith(
                              color: MyColor.getTextColor(),
                            ),
                            obscureText: false,
                            obscuringCharacter: '*',
                            blinkWhenObscuring: false,
                            animationType: AnimationType.fade,
                            pinTheme: PinTheme(
                              shape: PinCodeFieldShape.box,
                              borderWidth: 1,
                              borderRadius: BorderRadius.circular(5),
                              fieldHeight: 40,
                              fieldWidth: 40,
                              inactiveColor: MyColor.secondaryColor800,
                              inactiveFillColor: MyColor.secondaryColor900,
                              activeFillColor: MyColor.getScreenBgColor(),
                              activeColor: MyColor.getPrimaryColor(),
                              selectedFillColor: MyColor.getScreenBgColor(),
                              selectedColor: MyColor.getPrimaryColor(),
                            ),
                            cursorColor: MyColor.getTextColor(),
                            animationDuration: const Duration(
                              milliseconds: 100,
                            ),
                            enableActiveFill: true,
                            keyboardType: TextInputType.number,
                            beforeTextPaste: (text) {
                              return true;
                            },
                            onChanged: (value) {
                              setState(() {
                                controller.currentText = value;
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: Dimensions.space25),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: Dimensions.space14,
                          ),
                          child: GradientRoundedButton(
                            showLoadingIcon: controller.verifyLoading,
                            verticalPadding: 15,
                            text: MyStrings.verify.tr,
                            press: () {
                              if (controller.currentText.length != 6) {
                                controller.hasError = true;
                              } else {
                                controller.verifyForgetPasswordCode(
                                  controller.currentText,
                                );
                              }
                            },
                          ),
                        ),
                        const SizedBox(height: Dimensions.space25),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            DefaultText(
                              text: MyStrings.didNotReceiveCode.tr,
                              textColor: MyColor.getTextColor(),
                            ),
                            const SizedBox(width: Dimensions.space5),
                            controller.isResendLoading
                                ? const SizedBox(
                                    height: 17,
                                    width: 17,
                                    child: CircularProgressIndicator(
                                      color: MyColor.primaryColor,
                                    ),
                                  )
                                : TextButton(
                                    onPressed: () {
                                      controller.resendForgetPassCode();
                                    },
                                    child: DefaultText(
                                      text: MyStrings.resend.tr,
                                      textStyle: regularDefault.copyWith(
                                        color: MyColor.getPrimaryColor(),
                                      ),
                                    ),
                                  ),
                          ],
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
