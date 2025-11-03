import 'package:flutter/material.dart';
import 'package:verzusxyz/core/route/route.dart';
import 'package:verzusxyz/core/utils/dimensions.dart';
import 'package:verzusxyz/core/utils/my_color.dart';
import 'package:verzusxyz/core/utils/my_images.dart';
import 'package:verzusxyz/core/utils/my_strings.dart';
import 'package:verzusxyz/core/utils/style.dart';
import 'package:verzusxyz/core/utils/util.dart';
import 'package:verzusxyz/data/controller/auth/login_controller.dart';
import 'package:verzusxyz/environment.dart';
import 'package:verzusxyz/view/components/divider/custom_divider.dart';
import 'package:verzusxyz/view/components/text-form-field/custom_text_field.dart';
import 'package:verzusxyz/view/components/text/default_text.dart';
import 'package:get/get.dart';
import '../../../../components/buttons/gradient_rounded_button.dart';

class LoginBodySection extends StatelessWidget {
  const LoginBodySection({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return GetBuilder<LoginController>(
      builder: (controller) => Column(
        children: [
          const SizedBox(height: Dimensions.space20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.space28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: Dimensions.space50),
                Center(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: MyStrings.welcomeTo.tr,
                          style: semiBoldOverLarge.copyWith(
                            color: MyColor.colorWhite,
                          ),
                        ),
                        TextSpan(
                          text: ' ${Environment.appName.tr}',
                          style: semiBoldOverLarge.copyWith(
                            color: MyColor.primaryColor2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    MyStrings.enterYourEmailAndPassword.tr,
                    textAlign: TextAlign.center,
                    style: regularDefaultInter.copyWith(
                      color: MyColor.textColor,
                    ),
                  ),
                ),
                const SizedBox(height: Dimensions.space50),
                Row(
                  children: [
                    if (controller.loginRepo.apiClient
                            .getSocialCredentialsConfigData()
                            .google
                            ?.status ==
                        '1') ...[
                      //need to check google  social login status
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            controller.signInWithGoogle();
                          },
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(Dimensions.space15),
                            decoration: BoxDecoration(
                              color: MyColor.colorWhite,
                              borderRadius: BorderRadius.circular(
                                Dimensions.space8,
                              ),
                            ),
                            child:
                                (controller.isSocialSubmitLoading &&
                                    controller.isGoogle)
                                ? const Center(
                                    child: SizedBox(
                                      height: Dimensions.space25,
                                      width: Dimensions.space25,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: MyColor.colorBlack,
                                      ),
                                    ),
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(MyImages.google, height: 25),
                                      const SizedBox(width: Dimensions.space10),
                                      Text(
                                        MyStrings.google.tr,
                                        style: semiBoldMediumLarge.copyWith(
                                          fontFamily: 'Inter',
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                      ),
                      const SizedBox(height: Dimensions.space10),
                    ],
                    const SizedBox(width: Dimensions.space10),

                    if (controller.loginRepo.apiClient
                            .getSocialCredentialsConfigData()
                            .linkedin
                            ?.status ==
                        '1') ...[
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            controller.signInWithLinkedin(context);
                          },
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(Dimensions.space15),
                            decoration: BoxDecoration(
                              color: MyColor.colorWhite,
                              borderRadius: BorderRadius.circular(
                                Dimensions.space8,
                              ),
                            ),
                            child:
                                (controller.isSocialSubmitLoading &&
                                    controller.isLinkedin)
                                ? const Center(
                                    child: SizedBox(
                                      height: Dimensions.space25,
                                      width: Dimensions.space25,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: MyColor.colorBlack,
                                      ),
                                    ),
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        MyImages.linkedIn,
                                        height: 25,
                                      ),
                                      const SizedBox(width: Dimensions.space10),
                                      Text(
                                        MyStrings.linkedIn.tr,
                                        style: semiBoldMediumLarge.copyWith(
                                          fontFamily: 'Inter',
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                      ),
                      const SizedBox(height: Dimensions.space10),
                    ],
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(
                        child: CustomDivider(color: MyColor.colorWhite),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.space15,
                        ),
                        child: Text(
                          MyStrings.orContinueWith.tr,
                          style: regularSmall.copyWith(
                            color: MyColor.textColor,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ),
                      const Expanded(
                        child: CustomDivider(color: MyColor.colorWhite),
                      ),
                    ],
                  ),
                ),
                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text(
                            MyStrings.email.tr,
                            style: regularDefault.copyWith(
                              color: MyColor.colorWhite,
                              fontFamily: 'Inter',
                            ),
                          ),
                          Text(
                            MyUtils.getRequiredSign(),
                            style: regularDefault.copyWith(
                              color: MyColor.colorRed,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: Dimensions.space2),
                      CustomTextField(
                        fillColor: MyColor.textFieldColor,
                        animatedLabel: true,
                        borderColor: MyColor.transparentColor,
                        disableBorderColor: MyColor.transparentColor,
                        needOutlineBorder: true,
                        controller: controller.emailController,
                        labelText: MyStrings.enterYourEmail.tr,
                        onChanged: (value) {},
                        focusNode: controller.emailFocusNode,
                        nextFocus: controller.passwordFocusNode,
                        textInputType: TextInputType.emailAddress,
                        inputAction: TextInputAction.next,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return MyStrings.fieldErrorMsg.tr;
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(height: Dimensions.space20),
                      Row(
                        children: [
                          Text(
                            MyStrings.password,
                            style: regularDefault.copyWith(
                              color: MyColor.colorWhite,
                              fontFamily: 'Inter',
                            ),
                          ),
                          Text(
                            MyUtils.getRequiredSign(),
                            style: regularDefault.copyWith(
                              color: MyColor.colorRed,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: Dimensions.space2),
                      CustomTextField(
                        fillColor: MyColor.textFieldColor,
                        animatedLabel: true,
                        needOutlineBorder: true,
                        borderColor: MyColor.transparentColor,
                        disableBorderColor: MyColor.transparentColor,
                        labelText: MyStrings.enterYourPassword_.tr,
                        controller: controller.passwordController,
                        focusNode: controller.passwordFocusNode,
                        onChanged: (value) {},
                        isShowSuffixIcon: true,
                        onSuffixTap: () {
                          controller.showPassword = !controller.showPassword;
                          controller.update();
                        },
                        isPassword: controller.showPassword,
                        textInputType: TextInputType.text,
                        inputAction: TextInputAction.done,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return MyStrings.fieldErrorMsg.tr;
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(height: Dimensions.space25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              controller.clearTextField();
                              Get.toNamed(RouteHelper.forgotPasswordScreen);
                            },
                            child: DefaultText(
                              text: MyStrings.forgotPassword.tr,
                              textColor: MyColor.colorRed,
                              textStyle: regularLargeInter,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: Dimensions.space25),
                      GradientRoundedButton(
                        showLoadingIcon: controller.isSubmitLoading,
                        verticalPadding: 15,
                        text: MyStrings.signIn.tr,
                        press: () {
                          if (formKey.currentState!.validate()) {
                            controller.loginUser();
                          }
                        },
                      ),
                      const SizedBox(height: Dimensions.space35),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            MyStrings.doNotHaveAccount.tr,
                            overflow: TextOverflow.ellipsis,
                            style: regularLargeInter.copyWith(
                              color: MyColor.colorWhite,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Get.offAndToNamed(RouteHelper.registrationScreen);
                            },
                            child: Text(
                              MyStrings.signUP.tr,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: regularLargeInter.copyWith(
                                color: MyColor.primaryButtonColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
