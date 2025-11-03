import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:verzusxyz/core/helper/shared_preference_helper.dart';
import 'package:verzusxyz/core/utils/method.dart';
import 'package:verzusxyz/core/utils/my_strings.dart';
import 'package:verzusxyz/core/utils/url_container.dart';
import 'package:verzusxyz/data/model/auth/verification/email_verification_model.dart';
import 'package:verzusxyz/data/model/global/response_model/response_model.dart';
import 'package:verzusxyz/data/services/api_service.dart';
import 'package:verzusxyz/view/components/snack_bar/show_custom_snackbar.dart';

/// A repository class for handling user authentication, including login, password reset, and social login.
///
/// This class interacts with the backend API to perform authentication-related tasks.
class LoginRepo {
  /// The API client for making HTTP requests.
  final ApiClient apiClient;

  /// Creates a new [LoginRepo] instance.
  ///
  /// Requires an [ApiClient] instance to communicate with the backend.
  LoginRepo({required this.apiClient});

  /// Logs in a user with the given [email] and [password].
  ///
  /// - [email]: The user's email or username.
  /// - [password]: The user's password.
  /// - Returns a [ResponseModel] with the login response.
  Future<ResponseModel> loginUser(String email, String password) async {
    Map<String, String> map = {'username': email, 'password': password};
    String url = '${UrlContainer.baseUrl}${UrlContainer.loginEndPoint}';

    ResponseModel model = await apiClient.request(
      url,
      Method.postMethod,
      map,
      passHeader: false,
    );

    return model;
  }

  /// Initiates the password reset process for the user.
  ///
  /// - [type]: The type of value provided (e.g., 'email').
  /// - [value]: The user's email address.
  /// - Returns the user's email if the request is successful, otherwise an empty string.
  Future<String> forgetPassword(String type, String value) async {
    final map = modelToMap(value, type);
    String url =
        '${UrlContainer.baseUrl}${UrlContainer.forgetPasswordEndPoint}';
    final response = await apiClient.request(
      url,
      Method.postMethod,
      map,
      isOnlyAcceptType: true,
      passHeader: true,
    );

    EmailVerificationModel model = EmailVerificationModel.fromJson(
      jsonDecode(response.responseJson),
    );

    if (model.status.toLowerCase() == "success") {
      apiClient.sharedPreferences.setString(
        SharedPreferenceHelper.userEmailKey,
        model.data?.email ?? '',
      );
      CustomSnackBar.success(
        successList: [
          '${MyStrings.passwordResetEmailSentTo} ${model.data?.email ?? MyStrings.yourEmail}',
        ],
      );
      return model.data?.email ?? '';
    } else {
      CustomSnackBar.error(
        errorList: model.message!.error ?? [MyStrings.requestFail],
      );
      return '';
    }
  }

  /// Creates a map from a given [value] and [type].
  ///
  /// - [value]: The value to include in the map.
  /// - [type]: The type of the value.
  /// - Returns a map with 'type' and 'value' keys.
  Map<String, String> modelToMap(String value, String type) {
    Map<String, String> map = {'type': type, 'value': value};
    return map;
  }

  /// Verifies the password reset code.
  ///
  /// - [code]: The verification code sent to the user's email.
  /// - Returns an [EmailVerificationModel] with the verification status.
  Future<EmailVerificationModel> verifyForgetPassCode(String code) async {
    String? email =
        apiClient.sharedPreferences.getString(
          SharedPreferenceHelper.userEmailKey,
        ) ??
        '';
    Map<String, String> map = {'code': code, 'email': email};

    String url =
        '${UrlContainer.baseUrl}${UrlContainer.passwordVerifyEndPoint}';

    final response = await apiClient.request(
      url,
      Method.postMethod,
      map,
      passHeader: true,
      isOnlyAcceptType: true,
    );

    EmailVerificationModel model = EmailVerificationModel.fromJson(
      jsonDecode(response.responseJson),
    );
    if (model.status == 'success') {
      model.setCode(200);
      return model;
    } else {
      model.setCode(400);
      return model;
    }
  }

  /// Resets the user's password.
  ///
  /// - [email]: The user's email address.
  /// - [password]: The new password.
  /// - [code]: The verification code.
  /// - Returns an [EmailVerificationModel] with the reset status.
  Future<EmailVerificationModel> resetPassword(
    String email,
    String password,
    String code,
  ) async {
    Map<String, String> map = {
      'token': code,
      'email': email,
      'password': password,
      'password_confirmation': password,
    };

    Uri url = Uri.parse(
      '${UrlContainer.baseUrl}${UrlContainer.resetPasswordEndPoint}',
    );

    final response = await http.post(
      url,
      body: map,
      headers: {"Accept": "application/json"},
    );
    EmailVerificationModel model = EmailVerificationModel.fromJson(
      jsonDecode(response.body),
    );

    if (model.status == 'success') {
      CustomSnackBar.success(
        successList: [model.message?.success.toString() ?? ''],
      );
      model.setCode(200);
      return model;
    } else {
      CustomSnackBar.error(errorList: model.message!.error ?? []);
      model.setCode(400);
      return model;
    }
  }

  /// Sends the user's FCM device token to the backend server.
  ///
  /// This method is also present in the `PushNotificationService` and should be
  /// centralized to avoid duplication.
  ///
  /// - Returns `true` if the token was sent successfully, otherwise `false`.
  Future<bool> sendUserToken() async {
    String deviceToken;
    if (apiClient.sharedPreferences.containsKey(
      SharedPreferenceHelper.fcmDeviceKey,
    )) {
      deviceToken =
          apiClient.sharedPreferences.getString(
            SharedPreferenceHelper.fcmDeviceKey,
          ) ??
          '';
    } else {
      deviceToken = '';
    }

    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    bool success = false;

    if (deviceToken.isEmpty) {
      firebaseMessaging.getToken().then((fcmDeviceToken) async {
        success = await sendUpdatedToken(fcmDeviceToken ?? '');
      });
    } else {
      firebaseMessaging.onTokenRefresh.listen((fcmDeviceToken) async {
        if (deviceToken == fcmDeviceToken) {
          success = true;
        } else {
          apiClient.sharedPreferences.setString(
            SharedPreferenceHelper.fcmDeviceKey,
            fcmDeviceToken,
          );
          success = await sendUpdatedToken(fcmDeviceToken);
        }
      });
    }
    return success;
  }

  /// Sends the updated FCM device token to the backend server.
  ///
  /// - [deviceToken]: The new FCM device token.
  /// - Returns `true` if the token was sent successfully.
  Future<bool> sendUpdatedToken(String deviceToken) async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.deviceTokenEndPoint}';
    Map<String, String> map = deviceTokenMap(deviceToken);
    await apiClient.request(url, Method.postMethod, map, passHeader: true);
    return true;
  }

  /// Creates a map containing the device token.
  ///
  /// - [deviceToken]: The FCM device token.
  /// - Returns a map with the 'token' key.
  Map<String, String> deviceTokenMap(String deviceToken) {
    Map<String, String> map = {'token': deviceToken.toString()};
    return map;
  }

  /// Logs in a user using a social media provider.
  ///
  /// - [accessToken]: The access token from the social media provider.
  /// - [provider]: The name of the social media provider (e.g., 'google', 'linkedin').
  /// - Returns a [ResponseModel] with the login response.
  Future<ResponseModel> socialLoginUser({
    String accessToken = '',
    String? provider,
  }) async {
    Map<String, String>? map;

    if (provider == 'google') {
      map = {'token': accessToken, 'provider': "google"};
    }
    if (provider == 'linkedin') {
      map = {'token': accessToken, 'provider': "linkedin"};
    }

    String url = '${UrlContainer.baseUrl}${UrlContainer.socialLoginEndPoint}';

    ResponseModel model = await apiClient.request(
      url,
      Method.postMethod,
      map,
      passHeader: false,
    );

    return model;
  }
}
