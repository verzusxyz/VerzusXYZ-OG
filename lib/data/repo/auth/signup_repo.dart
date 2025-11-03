import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:verzusxyz/core/helper/shared_preference_helper.dart';
import 'package:verzusxyz/core/utils/method.dart';
import 'package:verzusxyz/core/utils/url_container.dart';
import 'package:verzusxyz/data/model/auth/sign_up_model/registration_response_model.dart';
import 'package:verzusxyz/data/model/auth/sign_up_model/sign_up_model.dart';
import 'package:verzusxyz/data/model/global/response_model/response_model.dart';
import 'package:verzusxyz/data/services/api_service.dart';

/// A repository class for handling user registration.
///
/// This class interacts with the backend API to register new users and retrieve
/// a list of countries for the registration form.
class RegistrationRepo {
  /// The API client for making HTTP requests.
  final ApiClient apiClient;

  /// Creates a new [RegistrationRepo] instance.
  ///
  /// Requires an [ApiClient] instance to communicate with the backend.
  RegistrationRepo({required this.apiClient});

  /// Registers a new user with the provided [SignUpModel].
  ///
  /// - [model]: The user's registration data.
  /// - Returns a [ResponseModel] with the registration response.
  Future<ResponseModel> registerUser(SignUpModel model) async {
    final map = model.toMap();
    String url = '${UrlContainer.baseUrl}${UrlContainer.registrationEndPoint}';
    ResponseModel responseModel = await apiClient.request(
      url,
      Method.postMethod,
      map,
      passHeader: true,
      isOnlyAcceptType: true,
    );
    return responseModel;
  }

  /// Retrieves a list of countries from the backend.
  ///
  /// - Returns a [ResponseModel] containing the list of countries.
  Future<dynamic> getCountryList() async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.countryEndPoint}';
    ResponseModel model = await apiClient.request(url, Method.getMethod, null);
    return model;
  }

  /// Sends the user's FCM device token to the backend server.
  ///
  /// This method is duplicated in other repositories and should be centralized.
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
  /// This method is also present in the `LoginRepo` and should be centralized.
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
