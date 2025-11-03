import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:verzusxyz/core/utils/my_strings.dart';
import 'package:verzusxyz/core/utils/dimensions.dart';
import 'package:verzusxyz/core/utils/my_color.dart';
import 'package:verzusxyz/data/controller/account/profile_controller.dart';
import 'package:verzusxyz/view/components/buttons/rounded_button.dart';
import 'package:verzusxyz/view/components/buttons/rounded_loading_button.dart';
import 'package:verzusxyz/view/components/text-form-field/custom_text_field.dart';

class EditProfileForm extends StatefulWidget {
  const EditProfileForm({Key? key}) : super(key: key);

  @override
  State<EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (controller) => Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(
          vertical: Dimensions.space15,
          horizontal: Dimensions.space15,
        ),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: MyColor.colorBgCard,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Form(
          child: Column(
            children: [
              const SizedBox(height: Dimensions.space20),
              CustomTextField(
                labelTextColor: MyColor.secondaryPrimaryColor,
                animatedLabel: true,
                fillColor: MyColor.secondaryPrimaryColor,
                needOutlineBorder: true,
                labelText: MyStrings.firstName.tr,
                onChanged: (value) {},
                focusNode: controller.firstNameFocusNode,
                controller: controller.firstNameController,
              ),
              const SizedBox(height: Dimensions.space15),
              CustomTextField(
                animatedLabel: true,
                needOutlineBorder: true,
                labelText: MyStrings.lastName.tr,
                onChanged: (value) {},
                fillColor: MyColor.secondaryPrimaryColor,
                focusNode: controller.lastNameFocusNode,
                controller: controller.lastNameController,
              ),
              const SizedBox(height: Dimensions.space15),
              CustomTextField(
                animatedLabel: true,
                needOutlineBorder: true,
                labelText: MyStrings.address.tr,
                onChanged: (value) {},
                fillColor: MyColor.secondaryPrimaryColor,
                focusNode: controller.addressFocusNode,
                controller: controller.addressController,
              ),
              const SizedBox(height: Dimensions.space15),
              CustomTextField(
                animatedLabel: true,
                needOutlineBorder: true,
                fillColor: MyColor.secondaryPrimaryColor,
                labelText: MyStrings.state.tr,
                onChanged: (value) {},
                focusNode: controller.stateFocusNode,
                controller: controller.stateController,
              ),
              const SizedBox(height: Dimensions.space15),
              CustomTextField(
                animatedLabel: true,
                needOutlineBorder: true,
                fillColor: MyColor.secondaryPrimaryColor,
                labelText: MyStrings.zipCode.tr,
                onChanged: (value) {},
                focusNode: controller.zipCodeFocusNode,
                controller: controller.zipCodeController,
              ),
              const SizedBox(height: Dimensions.space15),
              CustomTextField(
                animatedLabel: true,
                needOutlineBorder: true,
                labelText: MyStrings.city.tr,
                fillColor: MyColor.secondaryPrimaryColor,
                onChanged: (value) {},
                focusNode: controller.cityFocusNode,
                controller: controller.cityController,
              ),
              const SizedBox(height: Dimensions.space30),
              controller.isSubmitLoading
                  ? const RoundedLoadingBtn(color: MyColor.primaryButtonColor)
                  : RoundedButton(
                      hasCornerRadious: true,
                      isColorChange: true,
                      textColor: MyColor.colorBlack,
                      verticalPadding: Dimensions.space15,
                      cornerRadius: Dimensions.space8,
                      color: MyColor.primaryButtonColor,
                      text: MyStrings.updateProfile,
                      press: () {
                        controller.updateProfile();
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
