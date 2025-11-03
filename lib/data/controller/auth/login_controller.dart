import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:verzusxyz/data/model/general_setting/general_setting_response_model.dart';
import 'package:verzusxyz/view/packages/signin_with_linkdin/signin_with_linkedin.dart';
import 'package:verzusxyz/view/packages/signin_with_linkdin/src/models/linkedin_config.dart';
import 'package:get/get.dart';
import 'package:verzusxyz/core/helper/shared_preference_helper.dart';
import 'package:verzusxyz/core/route/route.dart';
import 'package:verzusxyz/core/utils/my_strings.dart';
import 'package:verzusxyz/data/model/auth/login/login_response_model.dart';
import 'package:verzusxyz/data/model/global/response_model/response_model.dart';
import 'package:verzusxyz/data/repo/auth/login_repo.dart';
import 'package:verzusxyz/view/components/snack_bar/show_custom_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {
  LoginRepo loginRepo;
  LoginController({required this.loginRepo});

  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  var firebaseUser = FirebaseAuth.instance.currentUser.obs; // Observe the user
  final GoogleSignIn googleSignIn = GoogleSignIn();
  String? email;
  String? password;

  List<String> errors = [];
  bool remember = false;
  bool showPassword = false;

  @override
  void onInit() {
    super.onInit();
    firebaseUser.value = firebaseAuth.currentUser;
    firebaseAuth.authStateChanges().listen((user) {
      firebaseUser.value = user;
    });
  }

  void forgetPassword() {
    Get.toNamed(RouteHelper.forgotPasswordScreen);
  }

  void checkAndGotoNextStep(
    LoginResponseModel responseModel, {
    bool isSocialLogin = false,
  }) async {
    bool needEmailVerification = responseModel.data?.user?.ev == "1"
        ? false
        : true;
    bool needSmsVerification = responseModel.data?.user?.sv == '1'
        ? false
        : true;
    bool isTwoFactorEnable = responseModel.data?.user?.tv == '1' ? false : true;
    await loginRepo.apiClient.sharedPreferences.setBool(
      SharedPreferenceHelper.rememberMeKey,
      true,
    );

    String firstName = responseModel.data?.user?.firstname ?? "";
    String lastName = responseModel.data?.user?.lastname ?? "";

    await loginRepo.apiClient.sharedPreferences.setString(
      SharedPreferenceHelper.fullNameKey,
      '$firstName $lastName',
    );

    await loginRepo.apiClient.sharedPreferences.setBool(
      SharedPreferenceHelper.isSocialLoginKey,
      isSocialLogin,
    );
    await loginRepo.apiClient.sharedPreferences.setString(
      SharedPreferenceHelper.userIdKey,
      responseModel.data?.user?.id.toString() ?? '-1',
    );
    await loginRepo.apiClient.sharedPreferences.setString(
      SharedPreferenceHelper.accessTokenKey,
      responseModel.data?.accessToken ?? '',
    );
    await loginRepo.apiClient.sharedPreferences.setString(
      SharedPreferenceHelper.accessTokenType,
      responseModel.data?.tokenType ?? '',
    );
    await loginRepo.apiClient.sharedPreferences.setString(
      SharedPreferenceHelper.userEmailKey,
      responseModel.data?.user?.email ?? '',
    );
    await loginRepo.apiClient.sharedPreferences.setString(
      SharedPreferenceHelper.userPhoneNumberKey,
      responseModel.data?.user?.mobile ?? '',
    );
    await loginRepo.apiClient.sharedPreferences.setString(
      SharedPreferenceHelper.userNameKey,
      responseModel.data?.user?.username ?? '',
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

    if (remember) {
      changeRememberMe();
    }
  }

  bool isSubmitLoading = false;
  void loginUser() async {
    isSubmitLoading = true;
    update();

    ResponseModel model = await loginRepo.loginUser(
      emailController.text.toString(),
      passwordController.text.toString(),
    );

    if (model.statusCode == 200) {
      LoginResponseModel loginModel = LoginResponseModel.fromJson(
        jsonDecode(model.responseJson),
      );
      if (loginModel.status.toString().toLowerCase() ==
          MyStrings.success.toLowerCase()) {
        checkAndGotoNextStep(loginModel);
      } else {
        CustomSnackBar.error(
          errorList:
              loginModel.message?.error ?? [MyStrings.loginFailedTryAgain],
        );
      }
    } else {
      CustomSnackBar.error(errorList: [model.message]);
    }

    isSubmitLoading = false;
    update();
  }

  changeRememberMe() {
    remember = !remember;
    update();
  }

  void clearTextField() {
    passwordController.text = '';
    emailController.text = '';

    if (remember) {
      remember = false;
    }
    update();
  }

  bool isLinkedinLoading = false;
  Future<void> signInWithLinkedin(BuildContext context) async {
    try {
      isLinkedinLoading = true;
      update();

      SocialiteCredentials linkedinCredential = loginRepo.apiClient
          .getSocialCredentialsConfigData();
      String linkedinCredentialRedirectUrl =
          "${loginRepo.apiClient.getSocialCredentialsRedirectUrl()}/linkedin";

      SignInWithLinkedIn.signIn(
        context,
        config: LinkedInConfig(
          clientId: linkedinCredential.linkedin?.clientId ?? '',
          clientSecret: linkedinCredential.linkedin?.clientSecret ?? '',
          scope: ['openid', 'profile', 'email'],
          redirectUrl: "$linkedinCredentialRedirectUrl",
        ),
        onGetAuthToken: (data) {},
        onGetUserProfile: (token, user) async {
          await socialLoginUser(
            provider: 'linkedin',
            accessToken: token.accessToken ?? '',
          );
        },
        onSignInError: (error) {
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
  bool isSocialSubmitLoading = false;
  bool isGoogle = false;
  bool isFacebook = false;
  bool isLinkedin = false;
  bool isGoogleSignInLoading = false;
  Future<void> signInWithGoogle() async {
    try {
      isGoogleSignInLoading = true;
      update();
      googleSignIn.signOut();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        isGoogleSignInLoading = false;
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

    isGoogleSignInLoading = false;
    update();
  }

  //Social Login API PART

  Future socialLoginUser({String accessToken = '', String? provider}) async {
    isSocialSubmitLoading = true;

    update();

    try {
      ResponseModel responseModel = await loginRepo.socialLoginUser(
        accessToken: accessToken,
        provider: provider,
      );
      if (responseModel.statusCode == 200) {
        LoginResponseModel loginModel = LoginResponseModel.fromJson(
          jsonDecode(responseModel.responseJson),
        );
        if (loginModel.status.toString().toLowerCase() ==
            MyStrings.success.toLowerCase()) {
          remember = true;
          update();
          checkAndGotoNextStep(loginModel, isSocialLogin: true);
        } else {
          isSocialSubmitLoading = false;
          update();
          CustomSnackBar.error(
            errorList:
                loginModel.message?.error ?? [MyStrings.loginFailedTryAgain.tr],
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
}
