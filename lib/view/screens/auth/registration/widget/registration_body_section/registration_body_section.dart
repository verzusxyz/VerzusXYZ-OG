import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:verzusxyz/core/route/route.dart';
import 'package:verzusxyz/core/utils/dimensions.dart';
import 'package:verzusxyz/core/utils/my_color.dart';
import 'package:verzusxyz/core/utils/my_images.dart';
import 'package:verzusxyz/core/utils/my_strings.dart';
import 'package:verzusxyz/core/utils/style.dart';
import 'package:verzusxyz/data/controller/auth/auth/registration_controller.dart';
import 'package:verzusxyz/view/components/divider/custom_divider.dart';
import 'package:verzusxyz/view/components/text-form-field/custom_text_field.dart';
import 'package:get/get.dart';

import '../../../../../components/buttons/gradient_rounded_button.dart';
import '../validation_widget.dart';

class RegistrationBodySection extends StatelessWidget {
  const RegistrationBodySection({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return GetBuilder<RegistrationController>(
      builder: (controller) => SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: Dimensions.space20),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.space28,
              ),
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
                            text: MyStrings.signUpAnd.tr,
                            style: semiBoldOverLarge.copyWith(
                              color: MyColor.colorWhite,
                            ),
                          ),
                          TextSpan(
                            text: ' ${MyStrings.play.tr}',
                            style: semiBoldOverLarge.copyWith(
                              color: MyColor.primaryColor2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: Dimensions.space30),
                  Row(
                    children: [
                      if (controller.checkSocialAuthActiveOrNot(
                        provider: 'google',
                      )) ...[
                        //need to check google  social login status
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              controller.signInWithGoogle();
                            },
                            child: Container(
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
                                  ? Center(
                                      child: SizedBox(
                                        height: Dimensions.space25,
                                        width: Dimensions.space25,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: MyColor.getPrimaryColor(),
                                        ),
                                      ),
                                    )
                                  : Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          MyImages.google,
                                          height: 25,
                                        ),
                                        const SizedBox(
                                          width: Dimensions.space10,
                                        ),
                                        Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            MyStrings.google.tr,
                                            style: semiBoldMediumLarge.copyWith(
                                              fontFamily: 'Inter',
                                            ),
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
                      if (controller.checkSocialAuthActiveOrNot(
                        provider: 'linkedin',
                      )) ...[
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              controller.signInWithLinkedin(context);
                            },
                            child: Container(
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
                                  ? Center(
                                      child: SizedBox(
                                        height: Dimensions.space25,
                                        width: Dimensions.space25,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: MyColor.getPrimaryColor(),
                                        ),
                                      ),
                                    )
                                  : Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          MyImages.linkedIn,
                                          height: 25,
                                        ),
                                        const SizedBox(
                                          width: Dimensions.space10,
                                        ),
                                        Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            MyStrings.linkedIn.tr,
                                            style: semiBoldMediumLarge.copyWith(
                                              fontFamily: 'Inter',
                                            ),
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
                  const SizedBox(height: Dimensions.space10),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          MyStrings.firstName.tr,
                          style: regularDefault.copyWith(
                            color: MyColor.colorWhite,
                            fontFamily: 'Inter',
                          ),
                        ),
                        const SizedBox(height: Dimensions.space2),
                        CustomTextField(
                          fillColor: MyColor.textFieldColor,
                          animatedLabel: true,
                          borderColor: MyColor.transparentColor,
                          disableBorderColor: MyColor.transparentColor,
                          needOutlineBorder: true,
                          onChanged: (value) {},
                          labelText: MyStrings.enterFirstname.tr,
                          controller: controller.fNameController,
                          focusNode: controller.firstNameFocusNode,
                          textInputType: TextInputType.text,
                          inputAction: TextInputAction.next,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return MyStrings.fieldErrorMsg.tr;
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: Dimensions.space15),
                        Text(
                          MyStrings.lastName.tr,
                          style: regularDefault.copyWith(
                            color: MyColor.colorWhite,
                            fontFamily: 'Inter',
                          ),
                        ),
                        const SizedBox(height: Dimensions.space2),
                        CustomTextField(
                          fillColor: MyColor.textFieldColor,
                          animatedLabel: true,
                          borderColor: MyColor.transparentColor,
                          disableBorderColor: MyColor.transparentColor,
                          needOutlineBorder: true,
                          onChanged: (value) {},
                          labelText: MyStrings.enterLastname.tr,
                          controller: controller.lNameController,
                          focusNode: controller.lastNameFocusNode,
                          textInputType: TextInputType.text,
                          inputAction: TextInputAction.next,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return MyStrings.fieldErrorMsg.tr;
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: Dimensions.space15),
                        Text(
                          MyStrings.email.tr,
                          style: regularDefault.copyWith(
                            color: MyColor.colorWhite,
                            fontFamily: 'Inter',
                          ),
                        ),
                        const SizedBox(height: Dimensions.space2),
                        CustomTextField(
                          fillColor: MyColor.textFieldColor,
                          animatedLabel: true,
                          needOutlineBorder: true,
                          borderColor: MyColor.transparentColor,
                          disableBorderColor: MyColor.transparentColor,
                          labelText: MyStrings.enterYourEmail.tr,
                          controller: controller.emailController,
                          focusNode: controller.emailFocusNode,
                          onChanged: (value) {},
                          textInputType: TextInputType.emailAddress,
                          inputAction: TextInputAction.done,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return MyStrings.fieldErrorMsg.tr;
                            } else {
                              return null;
                            }
                          },
                        ),

                        const SizedBox(height: Dimensions.space20),
                        Text(
                          MyStrings.password.tr,
                          style: regularDefault.copyWith(
                            color: MyColor.colorWhite,
                            fontFamily: 'Inter',
                          ),
                        ),
                        const SizedBox(height: Dimensions.space2),
                        Focus(
                          onFocusChange: (hasFocus) {
                            controller.changePasswordFocus(hasFocus);
                          },
                          child: CustomTextField(
                            fillColor: MyColor.textFieldColor,
                            animatedLabel: true,
                            needOutlineBorder: true,
                            borderColor: MyColor.transparentColor,
                            disableBorderColor: MyColor.transparentColor,
                            labelText: MyStrings.enterYourPassword_.tr,
                            controller: controller.passwordController,
                            focusNode: controller.passwordFocusNode,
                            isShowSuffixIcon: true,
                            isPassword: true,
                            onSuffixTap: () {
                              controller.togglePassword();
                            },
                            textInputType: TextInputType.text,
                            inputAction: TextInputAction.done,
                            onChanged: (value) {
                              if (controller.checkPasswordStrength) {
                                controller.updateValidationList(value);
                              }
                            },
                            validator: (value) {
                              return controller.validatePassword(value ?? '');
                            },
                          ),
                        ),
                        Visibility(
                          visible:
                              controller.hasPasswordFocus &&
                              controller.checkPasswordStrength,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: Dimensions.textToTextSpace,
                              ),
                              ValidationWidget(
                                list: controller.passwordValidationRules,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: Dimensions.space20),
                        Text(
                          MyStrings.confirmPassword.tr,
                          style: regularDefault.copyWith(
                            color: MyColor.colorWhite,
                            fontFamily: 'Inter',
                          ),
                        ),
                        const SizedBox(height: Dimensions.space2),
                        CustomTextField(
                          fillColor: MyColor.textFieldColor,
                          animatedLabel: true,
                          needOutlineBorder: true,
                          borderColor: MyColor.transparentColor,
                          disableBorderColor: MyColor.transparentColor,
                          labelText: MyStrings.enterYourPassword_.tr,
                          controller: controller.cPasswordController,
                          focusNode: controller.confirmPasswordFocusNode,
                          onChanged: (value) {},
                          isShowSuffixIcon: true,
                          isPassword: true,
                          onSuffixTap: () {
                            controller.toggleConfirmPassword();
                          },
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
                        const SizedBox(height: Dimensions.space20),
                        Text(
                          "${MyStrings.refferalCode.tr} (${MyStrings.optional}) ",
                          style: regularDefault.copyWith(
                            color: MyColor.colorWhite,
                            fontFamily: 'Inter',
                          ),
                        ),
                        const SizedBox(height: Dimensions.space2),
                        CustomTextField(
                          fillColor: MyColor.textFieldColor,
                          animatedLabel: true,
                          borderColor: MyColor.transparentColor,
                          disableBorderColor: MyColor.transparentColor,
                          needOutlineBorder: true,
                          onChanged: (value) {},
                          labelText: MyStrings.enterReferralCode.tr,
                          controller: controller.referralCodeController,
                          focusNode: controller.referralCodeFocusNode,
                          textInputType: TextInputType.text,
                          inputAction: TextInputAction.next,
                        ),
                        const SizedBox(height: Dimensions.space10),
                        Visibility(
                          visible: controller.needAgree,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 25,
                                height: 25,
                                child: Checkbox(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      Dimensions.defaultRadius,
                                    ),
                                  ),
                                  activeColor: MyColor.getPrimaryColor(),
                                  checkColor: MyColor.textColor,
                                  focusColor: MyColor.getPrimaryColor(),
                                  value: controller.agreeTC,
                                  fillColor:
                                      MaterialStateProperty.resolveWith<Color>((
                                        Set<MaterialState> states,
                                      ) {
                                        if (states.contains(
                                          MaterialState.disabled,
                                        )) {
                                          return MyColor.getPrimaryColor()
                                              .withOpacity(.32);
                                        }
                                        return MyColor.getPrimaryColor()
                                            .withOpacity(0.2);
                                      }),
                                  side: MaterialStateBorderSide.resolveWith(
                                    (states) => BorderSide(
                                      width: 1.0,
                                      color: controller.agreeTC
                                          ? MyColor.getPrimaryColor()
                                          : MyColor.getPrimaryColor(),
                                    ),
                                  ),
                                  onChanged: (bool? value) {
                                    controller.updateAgreeTC();
                                  },
                                ),
                              ),
                              const SizedBox(width: Dimensions.space8),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      controller.updateAgreeTC();
                                    },
                                    child: Text(
                                      MyStrings.iAgreeWith.tr,
                                      style: regularDefaultInter.copyWith(
                                        color: MyColor.textColor,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: Dimensions.space3),
                                  GestureDetector(
                                    onTap: () {
                                      Get.toNamed(RouteHelper.privacyScreen);
                                    },
                                    child: Text(
                                      MyStrings.policies.tr.toLowerCase(),
                                      style: regularDefaultInter.copyWith(
                                        color: MyColor.getPrimaryColor(),
                                        decoration: TextDecoration.underline,
                                        decorationColor:
                                            MyColor.getPrimaryColor(),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: Dimensions.space3),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: Dimensions.space25),
                        GradientRoundedButton(
                          showLoadingIcon: controller.submitLoading,
                          verticalPadding: 15,
                          text: MyStrings.signup.tr,
                          press: () {
                            if (formKey.currentState!.validate()) {
                              controller.signUpUser();
                            }
                          },
                        ),
                        const SizedBox(height: Dimensions.space35),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              MyStrings.alreadyAccount.tr,
                              overflow: TextOverflow.ellipsis,
                              style: regularLargeInter.copyWith(
                                color: MyColor.colorWhite,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Get.offAndToNamed(RouteHelper.loginScreen);
                              },
                              child: Text(
                                MyStrings.login.tr,
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
                  const SizedBox(height: Dimensions.space25),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
