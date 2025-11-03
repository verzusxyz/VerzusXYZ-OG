import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:verzusxyz/core/route/route.dart';
import 'package:verzusxyz/core/utils/my_strings.dart';
import 'package:verzusxyz/data/model/global/response_model/response_model.dart';
import 'package:verzusxyz/data/model/profile_complete/profile_complete_post_model.dart';
import 'package:verzusxyz/data/model/profile_complete/profile_complete_response_model.dart';
import 'package:verzusxyz/data/model/user/user.dart';
import 'package:verzusxyz/data/repo/account/profile_repo.dart';
import 'package:verzusxyz/environment.dart';
import 'package:verzusxyz/view/components/snack_bar/show_custom_snackbar.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/helper/shared_preference_helper.dart';
import '../../model/country_model/country_model.dart';

class ProfileCompleteController extends GetxController {
  ProfileRepo profileRepo;
  ProfileCompleteController({required this.profileRepo});

  String? countryName;
  String? countryCode;
  String? mobileCode;
  String? userName;
  String? phoneNo;
  TextEditingController userNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController mobileController = TextEditingController();

  FocusNode userNameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode mobileNoFocusNode = FocusNode();
  FocusNode addressFocusNode = FocusNode();
  FocusNode stateFocusNode = FocusNode();
  FocusNode zipCodeFocusNode = FocusNode();
  FocusNode cityFocusNode = FocusNode();
  FocusNode countryFocusNode = FocusNode();

  bool isLoading = true;
  bool submitLoading = false;
  RegExp regex = RegExp(r'[!@#$%^&*(),.?":{}|<>]');

  bool isCountryCodeSpaceHide = true;
  toggleHideCountryCodeErrorSpace({bool value = false}) {
    isCountryCodeSpaceHide = value;
    update();
  }

  updateProfile() async {
    String username = userNameController.text.toString();
    String mobileNumber = mobileController.text.toString();
    String address = addressController.text.toString();
    String city = cityController.text.toString();
    String zip = zipCodeController.text.toString();
    String state = stateController.text.toString();

    submitLoading = true;
    update();

    ProfileCompletePostModel model = ProfileCompletePostModel(
      username: username,
      countryName: countryName ?? "",
      countryCode: countryCode ?? "",
      mobileNumber: mobileNumber,
      mobileCode: mobileCode ?? "",
      address: address,
      state: state,
      zip: zip,
      city: city,
      image: null,
    );

    ResponseModel responseModel = await profileRepo.completeProfile(model);

    if (responseModel.statusCode == 200) {
      ProfileCompleteResponseModel model =
          ProfileCompleteResponseModel.fromJson(
            jsonDecode(responseModel.responseJson),
          );
      if (model.status?.toLowerCase() == MyStrings.success.toLowerCase()) {
        checkAndGotoNextStep(model.data?.user);
      } else {
        CustomSnackBar.error(
          errorList: model.message?.error ?? [MyStrings.requestFail],
        );
      }
    } else {
      CustomSnackBar.error(errorList: [responseModel.message]);
    }

    submitLoading = false;
    update();
  }

  bool remember = true;
  void checkAndGotoNextStep(User? user) async {
    bool needEmailVerification = user?.ev == "1" ? false : true;
    bool needSmsVerification = user?.sv == "1" ? false : true;
    SharedPreferences preferences = profileRepo.apiClient.sharedPreferences;

    await preferences.setBool(SharedPreferenceHelper.firstTimeOnAppKey, false);

    await preferences.setBool(SharedPreferenceHelper.rememberMeKey, true);
    await profileRepo.apiClient.sharedPreferences.setBool(
      SharedPreferenceHelper.firstTimeOnAppKey,
      false,
    );
    await preferences.setString(
      SharedPreferenceHelper.userIdKey,
      user?.id.toString() ?? '-1',
    );
    await preferences.setString(
      SharedPreferenceHelper.userEmailKey,
      user?.email ?? '',
    );
    await preferences.setString(
      SharedPreferenceHelper.userNameKey,
      user?.username ?? '',
    );
    await preferences.setString(
      SharedPreferenceHelper.userPhoneNumberKey,
      user?.mobile ?? '',
    );

    if (needEmailVerification) {
      Get.offAndToNamed(RouteHelper.emailVerificationScreen);
    } else if (needSmsVerification) {
      Get.offAndToNamed(RouteHelper.smsVerificationScreen);
    } else {
      Get.offAndToNamed(RouteHelper.bottomNavBar);
    }
  }

  String imageUrl = '';

  File? imageFile;
  String emailData = '';
  String countryData = '';
  String countryCodeData = '';
  String phoneCodeData = '';
  String phoneData = '';

  initialData() async {
    await getCountryData();
  }

  TextEditingController searchCountryController = TextEditingController();
  bool countryLoading = true;
  List<Countries> countryList = [];
  List<Countries> filteredCountries = [];

  String dialCode = Environment.defaultPhoneCode;
  void updateMobilecode(String code) {
    dialCode = code;
    update();
  }

  Future<dynamic> getCountryData() async {
    ResponseModel mainResponse = await profileRepo.getCountryList();

    if (mainResponse.statusCode == 200) {
      CountryModel model = CountryModel.fromJson(
        jsonDecode(mainResponse.responseJson),
      );
      List<Countries>? tempList = model.data?.countries;

      if (tempList != null && tempList.isNotEmpty) {
        countryList.addAll(tempList);
        filteredCountries.addAll(tempList);
      }
      var selectDefCountry = tempList!.firstWhere(
        (country) =>
            country.countryCode!.toLowerCase() ==
            Environment.defaultCountryCode.toLowerCase(),
        orElse: () => Countries(),
      );
      if (selectDefCountry.dialCode != null) {
        selectCountryData(selectDefCountry);
        setCountryNameAndCode(
          selectDefCountry.country.toString(),
          selectDefCountry.countryCode.toString(),
          selectDefCountry.dialCode.toString(),
        );
      }
      countryLoading = false;
      isLoading = false;
      update();
    } else {
      CustomSnackBar.error(errorList: [mainResponse.message]);

      countryLoading = false;

      isLoading = false;
      update();
      return;
    }
  }

  setCountryNameAndCode(String cName, String countryCode, String mobileCode) {
    countryName = cName;
    this.countryCode = countryCode;
    this.mobileCode = mobileCode;
    update();
  }

  Countries selectedCountryData = Countries();
  selectCountryData(Countries value) {
    selectedCountryData = value;
    update();
  }
}
