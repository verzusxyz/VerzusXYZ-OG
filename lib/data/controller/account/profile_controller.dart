import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:verzusxyz/core/helper/string_format_helper.dart';
import 'package:verzusxyz/data/model/global/response_model/response_model.dart';
import 'package:verzusxyz/data/model/profile/profile_post_model.dart';
import 'package:get/get.dart';
import 'package:verzusxyz/core/helper/shared_preference_helper.dart';
import 'package:verzusxyz/core/utils/my_strings.dart';
import 'package:verzusxyz/core/utils/url_container.dart';
import 'package:verzusxyz/data/model/profile/profile_response_model.dart';
import 'package:verzusxyz/data/model/user_post_model/user_post_model.dart';
import 'package:verzusxyz/data/repo/account/profile_repo.dart';
import 'package:verzusxyz/view/components/snack_bar/show_custom_snackbar.dart';

class ProfileController extends GetxController {
  ProfileRepo profileRepo;
  ProfileResponseModel model = ProfileResponseModel();

  ProfileController({required this.profileRepo});

  String imageUrl = '';

  bool isLoading = false;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  FocusNode firstNameFocusNode = FocusNode();
  FocusNode lastNameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode mobileNoFocusNode = FocusNode();
  FocusNode addressFocusNode = FocusNode();
  FocusNode stateFocusNode = FocusNode();
  FocusNode zipCodeFocusNode = FocusNode();
  FocusNode cityFocusNode = FocusNode();
  FocusNode countryFocusNode = FocusNode();

  File? imageFile;
  bool user2faIsOne = false;

  loadProfileInfo() async {
    isLoading = true;
    update();
    ResponseModel responseModel = await profileRepo.loadProfileInfo();
    if (responseModel.statusCode == 200) {
      model = ProfileResponseModel.fromJson(
        jsonDecode(responseModel.responseJson),
      );
      if (model.data != null &&
          model.status?.toLowerCase() == MyStrings.success.toLowerCase()) {
        loadData(model);
      } else {
        isLoading = false;
        update();
      }
    } else {
      CustomSnackBar.error(errorList: [responseModel.message]);
    }
  }

  bool isSubmitLoading = false;
  updateProfile() async {
    isSubmitLoading = true;
    update();

    String firstName = firstNameController.text;
    String lastName = lastNameController.text.toString();
    String address = addressController.text.toString();
    String city = cityController.text.toString();
    String zip = zipCodeController.text.toString();
    String state = stateController.text.toString();

    if (firstName.isNotEmpty && lastName.isNotEmpty) {
      isLoading = true;
      update();

      ProfilePostModel model = ProfilePostModel(
        address: address,
        state: state,
        zip: zip,
        city: city,
        firstname: firstName,
        lastName: lastName,
      );

      bool b = await profileRepo.updateProfile(model, true);

      if (b) {
        await loadProfileInfo();
      }
    } else {
      if (firstName.isEmpty) {
        CustomSnackBar.error(errorList: [MyStrings.kFirstNameNullError.tr]);
      }
      if (lastName.isEmpty) {
        CustomSnackBar.error(errorList: [MyStrings.kLastNameNullError.tr]);
      }
    }

    isSubmitLoading = false;
    update();
  }

  void loadData(ProfileResponseModel? model) {
    String firstName = model?.data?.user?.firstname ?? "";
    String lastName = model?.data?.user?.lastname ?? "";

    profileRepo.apiClient.sharedPreferences.setString(
      SharedPreferenceHelper.fullNameKey,
      '$firstName $lastName',
    );

    profileRepo.apiClient.sharedPreferences.setString(
      SharedPreferenceHelper.userNameKey,
      '${model?.data?.user?.username}',
    );
    profileRepo.apiClient.sharedPreferences.setString(
      SharedPreferenceHelper.lastNameKey,
      '${model?.data?.user?.lastname}',
    );

    firstNameController.text = model?.data?.user?.firstname ?? '';
    lastNameController.text = model?.data?.user?.lastname ?? '';
    emailController.text = model?.data?.user?.email ?? '';
    mobileNoController.text = model?.data?.user?.mobile ?? '';
    addressController.text = model?.data?.user?.address ?? '';
    stateController.text = model?.data?.user?.state ?? '';
    zipCodeController.text = model?.data?.user?.zip ?? '';
    cityController.text = model?.data?.user?.city ?? '';
    user2faIsOne = model?.data?.user?.ts == '1' ? true : false;

    if (imageUrl.isNotEmpty && imageUrl != 'null') {
      imageUrl =
          '${UrlContainer.domainUrl}/assets/images/user/profile/$imageUrl';
    }

    printx(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>${model?.data?.user?.toJson() ?? ""}");
    isLoading = false;
    update();
  }
}
