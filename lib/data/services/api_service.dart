import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:verzusxyz/core/helper/shared_preference_helper.dart';
import 'package:verzusxyz/core/route/route.dart';
import 'package:verzusxyz/core/utils/method.dart';
import 'package:verzusxyz/core/utils/my_strings.dart';
import 'package:verzusxyz/data/model/authorization/authorization_response_model.dart';
import 'package:verzusxyz/data/model/general_setting/general_setting_response_model.dart';
import 'package:verzusxyz/data/model/global/response_model/response_model.dart';

/// A service class for handling API requests.
class ApiClient extends GetxService {
  /// The shared preferences instance for storing and retrieving data.
  SharedPreferences sharedPreferences;

  /// Creates a new [ApiClient] instance.
  ///
  /// - [sharedPreferences]: The shared preferences instance.
  ApiClient({required this.sharedPreferences});

  /// Sends an API request.
  ///
  /// - [uri]: The request URI.
  /// - [method]: The HTTP method (e.g., 'GET', 'POST').
  /// - [params]: The request parameters.
  /// - [passHeader]: Whether to include the authorization header.
  /// - [isOnlyAcceptType]: Whether to only include the 'Accept' header.
  /// - Returns a [ResponseModel] with the API response.
  Future<ResponseModel> request(
    String uri,
    String method,
    Map<String, dynamic>? params, {
    bool passHeader = false,
    bool isOnlyAcceptType = false,
  }) async {
    Uri url = Uri.parse(uri);
    http.Response response;

    try {
      if (method == Method.postMethod) {
        if (passHeader) {
          initToken();
          if (isOnlyAcceptType) {
            response = await http.post(
              url,
              body: params,
              headers: {"Accept": "application/json"},
            );
          } else {
            response = await http.post(
              url,
              body: params,
              headers: {
                "Accept": "application/json",
                "Authorization": "$tokenType $token",
              },
            );
          }
        } else {
          response = await http.post(url, body: params);
        }
      } else if (method == Method.postMethod) {
        if (passHeader) {
          initToken();
          response = await http.post(
            url,
            body: params,
            headers: {
              "Accept": "application/json",
              "Authorization": "$tokenType $token",
            },
          );
        } else {
          response = await http.post(url, body: params);
        }
      } else if (method == Method.deleteMethod) {
        response = await http.delete(url);
      } else if (method == Method.updateMethod) {
        response = await http.patch(url);
      } else {
        if (passHeader) {
          initToken();
          response = await http.get(
            url,
            headers: {
              "Accept": "application/json",
              "Authorization": "$tokenType $token",
            },
          );
        } else {
          response = await http.get(url);
        }
      }

      print('url--------------${uri.toString()}');
      print('params-----------${params.toString()}');
      print('status-----------${response.statusCode}');
      print('body-------------${response.body.toString()}');
      print('token------------$token');

      if (response.statusCode == 200) {
        try {
          AuthorizationResponseModel model =
              AuthorizationResponseModel.fromJson(jsonDecode(response.body));
          if (model.remark == 'profile_incomplete') {
            Get.toNamed(RouteHelper.profileCompleteScreen);
          } else if (model.remark == 'kyc_verification') {
            Get.offAndToNamed(RouteHelper.kycScreen);
          } else if (model.remark == 'unauthenticated') {
            sharedPreferences.setBool(
              SharedPreferenceHelper.rememberMeKey,
              false,
            );
            sharedPreferences.remove(SharedPreferenceHelper.token);
            Get.offAllNamed(RouteHelper.loginScreen);
          }
        } catch (e) {
          e.toString();
        }

        return ResponseModel(true, 'Success', 200, response.body);
      } else if (response.statusCode == 401) {
        sharedPreferences.setBool(SharedPreferenceHelper.rememberMeKey, false);
        Get.offAllNamed(RouteHelper.loginScreen);
        return ResponseModel(
          false,
          MyStrings.unAuthorized.tr,
          401,
          response.body,
        );
      } else if (response.statusCode == 500) {
        return ResponseModel(
          false,
          MyStrings.serverError.tr,
          500,
          response.body,
        );
      } else {
        return ResponseModel(
          false,
          MyStrings.somethingWentWrong.tr,
          499,
          response.body,
        );
      }
    } on SocketException {
      return ResponseModel(false, MyStrings.noInternet.tr, 503, '');
    } on FormatException {
      return ResponseModel(false, MyStrings.badResponseMsg.tr, 400, '');
    } catch (e) {
      return ResponseModel(false, MyStrings.somethingWentWrong.tr, 499, '');
    }
  }

  /// The authentication token.
  String token = '';

  /// The authentication token type.
  String tokenType = '';

  /// Initializes the authentication token from shared preferences.
  initToken() {
    if (sharedPreferences.containsKey(SharedPreferenceHelper.accessTokenKey)) {
      String? t = sharedPreferences.getString(
        SharedPreferenceHelper.accessTokenKey,
      );
      String? tType = sharedPreferences.getString(
        SharedPreferenceHelper.accessTokenType,
      );
      token = t ?? '';
      tokenType = tType ?? 'Bearer';
    } else {
      token = '';
      tokenType = 'Bearer';
    }
  }

  /// Stores the general settings in shared preferences.
  ///
  /// - [model]: The general settings response model.
  storeGeneralSetting(GeneralSettingResponseModel model) {
    String json = jsonEncode(model.toJson());
    sharedPreferences.setString(SharedPreferenceHelper.generalSettingKey, json);
    getGSData();
  }

  /// Retrieves the general settings from shared preferences.
  ///
  /// - Returns a [GeneralSettingResponseModel] with the general settings.
  GeneralSettingResponseModel getGSData() {
    String pre =
        sharedPreferences.getString(SharedPreferenceHelper.generalSettingKey) ??
            '';
    GeneralSettingResponseModel model =
        GeneralSettingResponseModel.fromJson(jsonDecode(pre));
    return model;
  }

  /// Retrieves the currency or username from shared preferences.
  ///
  /// - [isCurrency]: Whether to retrieve the currency.
  /// - [isSymbol]: Whether to retrieve the currency symbol.
  /// - Returns the currency or username as a string.
  String getCurrencyOrUsername({
    bool isCurrency = true,
    bool isSymbol = false,
  }) {
    if (isCurrency) {
      String pre =
          sharedPreferences.getString(
            SharedPreferenceHelper.generalSettingKey,
          ) ??
          '';
      GeneralSettingResponseModel model =
          GeneralSettingResponseModel.fromJson(jsonDecode(pre));
      String currency = isSymbol
          ? model.data?.generalSetting?.curSym ?? ''
          : model.data?.generalSetting?.curText ?? '';
      return currency;
    } else {
      String username =
          sharedPreferences.getString(SharedPreferenceHelper.userNameKey) ?? '';
      return username;
    }
  }

  /// Retrieves the social credentials redirect URL from shared preferences.
  ///
  /// - Returns the redirect URL as a string.
  String getSocialCredentialsRedirectUrl() {
    String pre =
        sharedPreferences.getString(SharedPreferenceHelper.generalSettingKey) ??
            '';
    GeneralSettingResponseModel model =
        GeneralSettingResponseModel.fromJson(jsonDecode(pre));
    String redirect = model.data?.socialLoginRedirect ?? "";
    return redirect;
  }

  /// Retrieves the social credentials configuration data from shared preferences.
  ///
  /// - Returns a [SocialiteCredentials] object with the social credentials.
  SocialiteCredentials getSocialCredentialsConfigData() {
    String pre =
        sharedPreferences.getString(SharedPreferenceHelper.generalSettingKey) ??
            '';
    GeneralSettingResponseModel model =
        GeneralSettingResponseModel.fromJson(jsonDecode(pre));
    SocialiteCredentials social =
        model.data?.generalSetting?.socialiteCredentials ??
            SocialiteCredentials();
    print("this is social${model.data?.generalSetting?.socialiteCredentials}");
    return social;
  }

  /// Checks if all social credentials are enabled.
  ///
  /// - Returns `true` if all social credentials are enabled, otherwise `false`.
  bool getSocialCredentialsEnabledAll() {
    return getSocialCredentialsConfigData().google?.status == '1' &&
        getSocialCredentialsConfigData().linkedin?.status == '1' &&
        getSocialCredentialsConfigData().facebook?.status == '1';
  }

  /// Retrieves the user's email from shared preferences.
  ///
  /// - Returns the user's email as a string.
  String getUserEmail() {
    String email =
        sharedPreferences.getString(SharedPreferenceHelper.userEmailKey) ?? '';
    return email;
  }

  /// Checks if the password strength check is enabled.
  ///
  /// - Returns `true` if the password strength check is enabled, otherwise `false`.
  bool getPasswordStrengthStatus() {
    String pre =
        sharedPreferences.getString(SharedPreferenceHelper.generalSettingKey) ??
            '';
    GeneralSettingResponseModel model =
        GeneralSettingResponseModel.fromJson(jsonDecode(pre));
    bool checkPasswordStrength =
        model.data?.generalSetting?.securePassword.toString() == '0'
            ? false
            : true;
    return checkPasswordStrength;
  }

  /// Retrieves the name of the active template.
  ///
  /// - Returns the template name as a string.
  String getTemplateName() {
    String pre =
        sharedPreferences.getString(SharedPreferenceHelper.generalSettingKey) ??
            '';
    GeneralSettingResponseModel model =
        GeneralSettingResponseModel.fromJson(jsonDecode(pre));
    String templateName = model.data?.generalSetting?.activeTemplate ?? '';
    return templateName;
  }
}
