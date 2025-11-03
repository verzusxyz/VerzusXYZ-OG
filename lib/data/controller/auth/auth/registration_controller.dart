import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:verzusxyz/core/helper/string_format_helper.dart';
import 'package:verzusxyz/view/packages/signin_with_linkdin/signin_with_linkedin.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:verzusxyz/core/helper/shared_preference_helper.dart';
import 'package:verzusxyz/core/route/route.dart';
import 'package:verzusxyz/core/utils/my_strings.dart';
import 'package:verzusxyz/data/model/auth/sign_up_model/registration_response_model.dart';
import 'package:verzusxyz/data/model/auth/sign_up_model/sign_up_model.dart';
import 'package:verzusxyz/data/model/country_model/country_model.dart';
import 'package:verzusxyz/data/model/general_setting/general_setting_response_model.dart';
import 'package:verzusxyz/data/model/global/response_model/response_model.dart';
import 'package:verzusxyz/data/model/model/error_model.dart';
import 'package:verzusxyz/data/repo/auth/general_setting_repo.dart';
import 'package:verzusxyz/data/repo/auth/signup_repo.dart';
import 'package:verzusxyz/view/components/snack_bar/show_custom_snackbar.dart';

class RegistrationController extends GetxController {
  RegistrationRepo registrationRepo;
  GeneralSettingRepo generalSettingRepo;

  RegistrationController({
    required this.registrationRepo,
    required this.generalSettingRepo,
  });

  bool isLoading = true;
  bool agreeTC = false;

  final TextEditingController phController = TextEditingController();
  String initialCountry = 'US';
  PhoneNumber number = PhoneNumber(isoCode: 'US');

  GeneralSettingResponseModel generalSettingMainModel =
      GeneralSettingResponseModel();

  bool checkPasswordStrength = false;
  bool needAgree = true;
  bool showPassword = false;
  List<Countries> filteredCountries = [];
  togglePassword() {
    showPassword = !showPassword;
    update();
  }

  bool showConfirmPassword = false;
  toggleConfirmPassword() {
    showConfirmPassword = !showConfirmPassword;
    update();
  }

  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode confirmPasswordFocusNode = FocusNode();
  final FocusNode firstNameFocusNode = FocusNode();
  final FocusNode lastNameFocusNode = FocusNode();
  final FocusNode referralCodeFocusNode = FocusNode();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController cPasswordController = TextEditingController();
  final TextEditingController fNameController = TextEditingController();
  final TextEditingController lNameController = TextEditingController();
  final TextEditingController referralCodeController = TextEditingController();

  String? email;
  String? password;
  String? confirmPassword;
  String? countryName;
  String? countryCode;
  String? mobileCode;
  String? userName;
  String? phoneNo;
  String? firstName;
  String? lastName;

  RegExp regex = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
  bool submitLoading = false;

  signUpUser() async {
    if (needAgree && !agreeTC) {
      CustomSnackBar.error(errorList: [MyStrings.agreePolicyMessage]);
      return;
    }

    submitLoading = true;
    update();

    SignUpModel model = getUserData();
    ResponseModel responseModel = await registrationRepo.registerUser(model);

    if (responseModel.statusCode == 200) {
      RegistrationResponseModel model = RegistrationResponseModel.fromJson(
        jsonDecode(responseModel.responseJson),
      );
      if (model.status?.toLowerCase() == MyStrings.success.toLowerCase()) {
        CustomSnackBar.success(
          successList: model.message?.success ?? [MyStrings.success.tr],
        );
        checkAndGotoNextStep(model);
      } else {
        CustomSnackBar.error(
          errorList: model.message?.error ?? [MyStrings.somethingWentWrong.tr],
        );
      }
    } else {
      CustomSnackBar.error(errorList: [responseModel.message]);
    }

    submitLoading = false;
    update();
  }

  setCountryNameAndCode(String cName, String countryCode, String mobileCode) {
    countryName = cName;
    this.countryCode = countryCode;
    this.mobileCode = mobileCode;
    update();
  }

  updateAgreeTC() {
    agreeTC = !agreeTC;
    update();
  }

  SignUpModel getUserData() {
    String referenceValue = referralCodeController.text
        .toString()
        .split('=')
        .last;
    SignUpModel model = SignUpModel(
      firstName: fNameController.text.toString(),
      lastName: lNameController.text.toString(),
      email: emailController.text.toString(),
      password: passwordController.text.toString(),
      refference: referenceValue.toString(),
      agree: agreeTC ? true : false,
    );

    return model;
  }

  bool remember = true;
  void checkAndGotoNextStep(
    RegistrationResponseModel responseModel, {
    bool isSocialLogin = false,
  }) async {
    bool needEmailVerification = responseModel.data?.user?.ev == "1"
        ? false
        : true;
    bool needSmsVerification = responseModel.data?.user?.sv == '1'
        ? false
        : true;
    bool isTwoFactorEnable = responseModel.data?.user?.tv == '1' ? false : true;

    String firstName = responseModel.data?.user?.firstname ?? "";
    String lastName = responseModel.data?.user?.lastname ?? "";

    await registrationRepo.apiClient.sharedPreferences.setString(
      SharedPreferenceHelper.fullNameKey,
      '$firstName $lastName',
    );

    await registrationRepo.apiClient.sharedPreferences.setBool(
      SharedPreferenceHelper.rememberMeKey,
      true,
    );
    await registrationRepo.apiClient.sharedPreferences.setBool(
      SharedPreferenceHelper.isSocialLoginKey,
      isSocialLogin,
    );
    await registrationRepo.apiClient.sharedPreferences.setString(
      SharedPreferenceHelper.userIdKey,
      responseModel.data?.user?.id.toString() ?? '-1',
    );
    await registrationRepo.apiClient.sharedPreferences.setString(
      SharedPreferenceHelper.accessTokenKey,
      responseModel.data?.accessToken ?? '',
    );
    await registrationRepo.apiClient.sharedPreferences.setString(
      SharedPreferenceHelper.accessTokenType,
      responseModel.data?.tokenType ?? '',
    );
    await registrationRepo.apiClient.sharedPreferences.setString(
      SharedPreferenceHelper.userEmailKey,
      responseModel.data?.user?.email ?? '',
    );
    await registrationRepo.apiClient.sharedPreferences.setString(
      SharedPreferenceHelper.userPhoneNumberKey,
      responseModel.data?.user?.mobile ?? '',
    );
    await registrationRepo.apiClient.sharedPreferences.setString(
      SharedPreferenceHelper.userNameKey,
      responseModel.data?.user?.username ?? '',
    );
    await registrationRepo.apiClient.sharedPreferences.setString(
      SharedPreferenceHelper.lastNameKey,
      responseModel.data?.user?.lastname ?? '',
    );

    bool isProfileCompleteEnable =
        responseModel.data?.user?.profileComplete == '0' ? true : false;

    if (isProfileCompleteEnable) {
      Get.offAndToNamed(RouteHelper.profileCompleteScreen);
    } else if (needEmailVerification) {
      Get.offAndToNamed(RouteHelper.emailVerificationScreen);
    } else if (needSmsVerification) {
      Get.offAndToNamed(RouteHelper.smsVerificationScreen);
    } else if (isTwoFactorEnable) {
      Get.offAndToNamed(RouteHelper.twoFactorVerificationScreen);
    } else {
      Get.offAndToNamed(RouteHelper.bottomNavBar);
    }
  }

  void closeAllController() {
    isLoading = false;
    emailController.text = '';
    passwordController.text = '';
    cPasswordController.text = '';
    fNameController.text = '';
    lNameController.text = '';
  }

  clearAllData() {
    closeAllController();
  }

  List<ErrorModel> passwordValidationRules = [
    ErrorModel(text: MyStrings.hasUpperLetter.tr, hasError: true),
    ErrorModel(text: MyStrings.hasLowerLetter.tr, hasError: true),
    ErrorModel(text: MyStrings.hasDigit.tr, hasError: true),
    ErrorModel(text: MyStrings.hasSpecialChar.tr, hasError: true),
    ErrorModel(text: MyStrings.minSixChar.tr, hasError: true),
  ];

  bool isCountryLoading = true;
  void initData() async {
    isLoading = true;

    update();
    await getCountryData();

    ResponseModel response = await generalSettingRepo.getGeneralSetting();
    if (response.statusCode == 200) {
      GeneralSettingResponseModel model = GeneralSettingResponseModel.fromJson(
        jsonDecode(response.responseJson),
      );

      if (model.status?.toLowerCase() == 'success') {
        generalSettingMainModel = model;
        registrationRepo.apiClient.storeGeneralSetting(model);
      } else {
        List<String> message = [MyStrings.somethingWentWrong.tr];
        CustomSnackBar.error(errorList: model.message?.error ?? message);
        return;
      }
    } else {
      if (response.statusCode == 503) {
        noInternet = true;
        update();
      }
      CustomSnackBar.error(errorList: [response.message]);
      return;
    }

    needAgree =
        generalSettingMainModel.data?.generalSetting?.agree.toString() == '0'
        ? false
        : true;
    checkPasswordStrength =
        generalSettingMainModel.data?.generalSetting?.securePassword
                .toString() ==
            '0'
        ? false
        : true;

    isLoading = false;
    update();
  }

  bool countryLoading = true;
  List<Countries> countryList = [];

  TextEditingController searchCountryController = TextEditingController();

  Future<dynamic> getCountryData() async {
    ResponseModel mainResponse = await registrationRepo.getCountryList();

    if (mainResponse.statusCode == 200) {
      CountryModel model = CountryModel.fromJson(
        jsonDecode(mainResponse.responseJson),
      );
      List<Countries>? tempList = model.data?.countries;

      if (tempList != null && tempList.isNotEmpty) {
        countryList.addAll(tempList);
      }

      countryLoading = false;
      update();
      return;
    } else {
      CustomSnackBar.error(errorList: [mainResponse.message]);
      countryLoading = false;
      update();
      return;
    }
  }

  String? validatePassword(String value) {
    if (value.isEmpty) {
      return MyStrings.enterYourPassword_.tr;
    } else {
      if (checkPasswordStrength) {
        if (!regex.hasMatch(value)) {
          return MyStrings.invalidPassMsg.tr;
        } else {
          return null;
        }
      } else {
        return null;
      }
    }
  }

  bool noInternet = false;
  void changeInternet(bool hasInternet) {
    noInternet = false;
    initData();
    update();
  }

  void updateValidationList(String value) {
    passwordValidationRules[0].hasError = value.contains(RegExp(r'[A-Z]'))
        ? false
        : true;
    passwordValidationRules[1].hasError = value.contains(RegExp(r'[a-z]'))
        ? false
        : true;
    passwordValidationRules[2].hasError = value.contains(RegExp(r'[0-9]'))
        ? false
        : true;
    passwordValidationRules[3].hasError =
        value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]')) ? false : true;
    passwordValidationRules[4].hasError = value.length >= 6 ? false : true;

    update();
  }

  bool hasPasswordFocus = false;
  void changePasswordFocus(bool hasFocus) {
    hasPasswordFocus = hasFocus;
    update();
  }

  void clearTextField() {
    passwordController.text = '';
    emailController.text = '';

    update();
  }

  bool isLinkedinLoading = false;
  Future<void> signInWithLinkedin(BuildContext context) async {
    try {
      isLinkedinLoading = true;
      update();

      SocialiteCredentials linkedinCredential = registrationRepo.apiClient
          .getSocialCredentialsConfigData();
      String linkedinCredentialRedirectUrl =
          "${registrationRepo.apiClient.getSocialCredentialsRedirectUrl()}/linkedin";
      print(linkedinCredentialRedirectUrl);
      print(linkedinCredential.linkedin?.toJson());
      SignInWithLinkedIn.signIn(
        context,
        config: LinkedInConfig(
          clientId: linkedinCredential.linkedin?.clientId ?? '',
          clientSecret: linkedinCredential.linkedin?.clientSecret ?? '',
          scope: ['openid', 'profile', 'email'],
          redirectUrl: "$linkedinCredentialRedirectUrl",
        ),
        onGetAuthToken: (data) {
          print('Auth token data: ${data.toJson()}');
        },
        onGetUserProfile: (token, user) async {
          print('${token.idToken}-');
          print('LinkedIn User: ${user.toJson()}');

          await socialLoginUser(
            provider: 'linkedin',
            accessToken: token.accessToken ?? '',
          );
        },
        onSignInError: (error) {
          print('Error on sign in: $error');
          CustomSnackBar.error(
            errorList:
                [error.description!] ?? [MyStrings.loginFailedTryAgain.tr],
          );
          isLinkedinLoading = false;
          update();
        },
      );
    } catch (e) {
      debugPrint(e.toString());

      CustomSnackBar.error(errorList: [e.toString()]);
    }
  }

  //SIGN IN With Google
  final GoogleSignIn googleSignIn = GoogleSignIn();
  bool isSocialSubmitLoading = false;
  bool isGoogle = false;
  bool isMetamask = false;
  bool isFacebook = false;
  bool isLinkedin = false;

  Future<void> signInWithGoogle() async {
    try {
      isGoogle = true;
      update();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        // throw Exception('Google Sign-In canceled by user');
        isGoogle = false;
        update();
        return;
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      await socialLoginUser(
        provider: 'google',
        accessToken: googleAuth.accessToken ?? '',
      );
    } catch (e) {
      debugPrint(e.toString());

      CustomSnackBar.error(errorList: [e.toString()]);
    }
  }

  //Social Login API PART

  Future socialLoginUser({String accessToken = '', String? provider}) async {
    isSocialSubmitLoading = true;

    update();

    try {
      ResponseModel responseModel = await registrationRepo.socialLoginUser(
        accessToken: accessToken,
        provider: provider,
      );
      if (responseModel.statusCode == 200) {
        RegistrationResponseModel regModel = RegistrationResponseModel.fromJson(
          jsonDecode(responseModel.responseJson),
        );
        if (regModel.status.toString().toLowerCase() ==
            MyStrings.success.toLowerCase()) {
          update();
          checkAndGotoNextStep(regModel, isSocialLogin: true);
        } else {
          isSocialSubmitLoading = false;
          update();
          CustomSnackBar.error(
            errorList:
                regModel.message?.error ?? [MyStrings.loginFailedTryAgain.tr],
          );
        }
      } else {
        isSocialSubmitLoading = false;
        update();
        CustomSnackBar.error(errorList: [responseModel.message]);
      }
    } catch (e) {
      print(e.toString());
    }

    isGoogle = false;
    isLinkedin = false;
    isSocialSubmitLoading = false;
    update();
  }

  bool checkSocialAuthActiveOrNot({String provider = 'all'}) {
    if (provider == 'google') {
      return registrationRepo.apiClient
              .getSocialCredentialsConfigData()
              .google
              ?.status ==
          '1';
    } else if (provider == 'facebook') {
      return registrationRepo.apiClient
              .getSocialCredentialsConfigData()
              .facebook
              ?.status ==
          '1';
    } else if (provider == 'linkedin') {
      return registrationRepo.apiClient
              .getSocialCredentialsConfigData()
              .linkedin
              ?.status ==
          '1';
    } else {
      return registrationRepo.apiClient.getSocialCredentialsEnabledAll();
    }
  }
}
