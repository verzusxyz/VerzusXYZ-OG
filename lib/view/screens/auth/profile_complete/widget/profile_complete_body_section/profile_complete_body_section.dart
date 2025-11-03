import 'package:flutter/material.dart';
import 'package:verzusxyz/core/utils/dimensions.dart';
import 'package:verzusxyz/core/utils/my_color.dart';
import 'package:verzusxyz/core/utils/my_images.dart';
import 'package:verzusxyz/core/utils/my_strings.dart';
import 'package:verzusxyz/core/utils/style.dart';
import 'package:verzusxyz/data/controller/account/profile_complete_controller.dart';
import 'package:verzusxyz/data/repo/account/profile_repo.dart';
import 'package:verzusxyz/data/services/api_service.dart';
import 'package:verzusxyz/view/components/custom_loader/custom_loader.dart';
import 'package:verzusxyz/view/components/text-form-field/custom_text_field.dart';
import 'package:verzusxyz/view/screens/auth/registration/widget/country_bottom_sheet.dart';
import 'package:verzusxyz/view/screens/auth/registration/widget/country_text_field.dart';
import 'package:get/get.dart';

import '../../../../../components/buttons/gradient_rounded_button.dart';

class ProfileCompleteBodySection extends StatefulWidget {
  const ProfileCompleteBodySection({super.key});

  @override
  State<ProfileCompleteBodySection> createState() =>
      _ProfileCompleteBodySectionState();
}

class _ProfileCompleteBodySectionState
    extends State<ProfileCompleteBodySection> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(ProfileRepo(apiClient: Get.find()));
    var controller = Get.put(
      ProfileCompleteController(profileRepo: Get.find()),
    );
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.initialData();
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final formKey = GlobalKey<FormState>();
  final phoneFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return GetBuilder<ProfileCompleteController>(
      builder: (controller) => SingleChildScrollView(
        child: controller.isLoading
            ? const CustomLoader(
                loaderColor: MyColor.primaryColor,
                isFullScreen: true,
              )
            : Column(
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
                        Center(
                          child: Image.asset(
                            MyImages.appLogo,
                            height: Dimensions.space50,
                            width: Dimensions.space185,
                          ),
                        ),
                        const SizedBox(height: Dimensions.space30),
                        Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: Dimensions.space2),
                              CustomTextField(
                                borderColor: MyColor.transparentColor,
                                disableBorderColor: MyColor.transparentColor,
                                fillColor: MyColor.textFieldColor,
                                animatedLabel: true,
                                needOutlineBorder: true,
                                labelText: MyStrings.username.tr,
                                textInputType: TextInputType.text,
                                inputAction: TextInputAction.next,
                                focusNode: controller.userNameFocusNode,
                                controller: controller.userNameController,
                                nextFocus: controller.countryFocusNode,
                                onChanged: (value) {
                                  return;
                                },
                              ),
                              const SizedBox(height: Dimensions.space25),
                              if (controller.countryData == '') ...[
                                CountryTextField(
                                  press: () {
                                    CountryBottomSheet.countryBottomSheet(
                                      context,
                                      controller,
                                    );
                                  },
                                  text: controller.countryName == null
                                      ? MyStrings.selectACountry.tr
                                      : (controller.countryName)!.tr,
                                ),
                              ],
                              controller.countryData != ''
                                  ? const SizedBox()
                                  : const SizedBox(height: Dimensions.space25),
                              Visibility(
                                visible: controller.countryData == '',
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Container(
                                          width: 50,
                                          height: 47,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: MyColor.textFieldColor,
                                            borderRadius: BorderRadius.circular(
                                              Dimensions.defaultRadius,
                                            ),
                                            border: Border.all(
                                              color:
                                                  controller.countryName == null
                                                  ? MyColor.getTextFieldDisableBorder()
                                                  : MyColor.getTextFieldEnableBorder(),
                                              width: 0.5,
                                            ),
                                          ),
                                          child: Text(
                                            "+${controller.mobileCode ?? ""}",
                                            style: regularDefault.copyWith(
                                              color: MyColor.getPrimaryColor(),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: Dimensions.space5 + 3,
                                        ),
                                        Expanded(
                                          child: CustomTextField(
                                            animatedLabel: true,
                                            needOutlineBorder: true,
                                            labelText: MyStrings.phoneNo.tr,
                                            fillColor: MyColor.textFieldColor,
                                            controller:
                                                controller.mobileController,
                                            textInputType: TextInputType.phone,
                                            inputAction: TextInputAction.next,
                                            onChanged: (value) {
                                              return;
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: Dimensions.space20),
                                  ],
                                ),
                              ),
                              CustomTextField(
                                borderColor: MyColor.transparentColor,
                                disableBorderColor: MyColor.transparentColor,
                                fillColor: MyColor.textFieldColor,
                                animatedLabel: true,
                                needOutlineBorder: true,
                                labelText: MyStrings.address,
                                textInputType: TextInputType.text,
                                inputAction: TextInputAction.next,
                                focusNode: controller.addressFocusNode,
                                controller: controller.addressController,
                                nextFocus: controller.stateFocusNode,
                                onChanged: (value) {
                                  return;
                                },
                              ),
                              const SizedBox(height: Dimensions.space25),
                              CustomTextField(
                                borderColor: MyColor.transparentColor,
                                disableBorderColor: MyColor.transparentColor,
                                fillColor: MyColor.textFieldColor,
                                animatedLabel: true,
                                needOutlineBorder: true,
                                labelText: MyStrings.state,
                                textInputType: TextInputType.text,
                                inputAction: TextInputAction.next,
                                focusNode: controller.stateFocusNode,
                                controller: controller.stateController,
                                nextFocus: controller.cityFocusNode,
                                onChanged: (value) {
                                  return;
                                },
                              ),
                              const SizedBox(height: Dimensions.space25),
                              CustomTextField(
                                borderColor: MyColor.transparentColor,
                                disableBorderColor: MyColor.transparentColor,
                                fillColor: MyColor.textFieldColor,
                                animatedLabel: true,
                                needOutlineBorder: true,
                                labelText: MyStrings.city.tr,
                                textInputType: TextInputType.text,
                                inputAction: TextInputAction.next,
                                focusNode: controller.cityFocusNode,
                                controller: controller.cityController,
                                nextFocus: controller.zipCodeFocusNode,
                                onChanged: (value) {
                                  return;
                                },
                              ),
                              const SizedBox(height: Dimensions.space25),
                              CustomTextField(
                                borderColor: MyColor.transparentColor,
                                disableBorderColor: MyColor.transparentColor,
                                fillColor: MyColor.textFieldColor,
                                animatedLabel: true,
                                needOutlineBorder: true,
                                labelText: MyStrings.zipCode.tr,
                                textInputType: TextInputType.text,
                                inputAction: TextInputAction.done,
                                focusNode: controller.zipCodeFocusNode,
                                controller: controller.zipCodeController,
                                onChanged: (value) {
                                  return;
                                },
                              ),
                              const SizedBox(height: Dimensions.space35),
                              const SizedBox(height: Dimensions.space25),
                              GradientRoundedButton(
                                showLoadingIcon: controller.submitLoading,
                                verticalPadding: 15,
                                text: MyStrings.submit.tr,
                                press: () {
                                  if (formKey.currentState!.validate()) {
                                    controller.updateProfile();
                                  }
                                },
                              ),
                              const SizedBox(height: Dimensions.space35),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
