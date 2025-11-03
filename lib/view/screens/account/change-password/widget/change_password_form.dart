import 'package:flutter/material.dart';
import 'package:verzusxyz/core/utils/my_color.dart';
import 'package:get/get.dart';
import 'package:verzusxyz/core/utils/dimensions.dart';
import 'package:verzusxyz/core/utils/my_strings.dart';
import 'package:verzusxyz/data/controller/account/change_password_controller.dart';
import 'package:verzusxyz/view/components/buttons/rounded_button.dart';
import 'package:verzusxyz/view/components/buttons/rounded_loading_button.dart';
import 'package:verzusxyz/view/components/text-form-field/custom_text_field.dart';

class ChangePasswordForm extends StatefulWidget {
  const ChangePasswordForm({Key? key}) : super(key: key);

  @override
  State<ChangePasswordForm> createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<ChangePasswordForm> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChangePasswordController>(
      builder: (controller) => Form(
        key: formKey,
        child: Column(
          children: [
            CustomTextField(
              focusNode: controller.currentPassFocusNode,
              suffixImage: "",
              animatedLabel: true,
              borderColor: MyColor.textFieldBorder,
              disableBorderColor: const Color.fromARGB(255, 104, 100, 139),
              needOutlineBorder: true,
              labelText: MyStrings.currentPassword.tr,
              onChanged: (value) {
                return;
              },
              validator: (value) {
                if (value.toString().isEmpty) {
                  return MyStrings.enterCurrentPass.tr;
                } else {
                  return null;
                }
              },
              controller: controller.currentPassController,

              isPassword: true,
            ),
            const SizedBox(height: Dimensions.space20),
            CustomTextField(
              focusNode: controller.passwordFocusNode,
              suffixImage: "",
              borderColor: MyColor.textFieldBorder,
              disableBorderColor: MyColor.textFieldBorder,
              needOutlineBorder: true,
              animatedLabel: true,
              labelText: MyStrings.newPassword.tr,
              onChanged: (value) {
                return;
              },
              validator: (value) {
                if (value.toString().isEmpty) {
                  return MyStrings.enterNewPass.tr;
                } else {
                  return null;
                }
              },
              controller: controller.passController,

              isPassword: true,
            ),
            const SizedBox(height: Dimensions.space20),
            CustomTextField(
              suffixImage: "",
              focusNode: controller.confirmPassFocusNode,
              borderColor: MyColor.textFieldBorder,
              disableBorderColor: MyColor.textFieldBorder,
              needOutlineBorder: true,

              animatedLabel: true,
              labelText: MyStrings.confirmPassword.tr,
              onChanged: (value) {
                return;
              },
              validator: (value) {
                if (controller.confirmPassController.text !=
                    controller.passController.text) {
                  return MyStrings.kMatchPassError.tr;
                } else {
                  return null;
                }
              },
              controller: controller.confirmPassController,

              isPassword: true,
            ),
            const SizedBox(height: Dimensions.space25),
            controller.submitLoading
                ? const RoundedLoadingBtn(color: MyColor.primaryButtonColor)
                : RoundedButton(
                    hasCornerRadious: true,
                    isColorChange: true,

                    textColor: MyColor.colorBlack,
                    verticalPadding: Dimensions.space15,
                    cornerRadius: Dimensions.space8,
                    color: MyColor.primaryButtonColor,
                    text: MyStrings.changePassword.tr,

                    press: () {
                      if (formKey.currentState!.validate()) {
                        controller.changePassword();
                      }
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
