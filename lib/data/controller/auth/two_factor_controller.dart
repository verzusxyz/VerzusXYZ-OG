import 'dart:convert';
import 'package:verzusxyz/data/model/two_factor/two_factor_data_model.dart';
import 'package:get/get.dart';
import 'package:verzusxyz/core/route/route.dart';
import 'package:verzusxyz/core/utils/my_strings.dart';
import 'package:verzusxyz/data/model/authorization/authorization_response_model.dart';
import 'package:verzusxyz/data/model/global/response_model/response_model.dart';
import 'package:verzusxyz/data/repo/auth/two_factor_repo.dart';
import 'package:verzusxyz/view/components/snack_bar/show_custom_snackbar.dart';

class TwoFactorController extends GetxController {
  TwoFactorRepo repo;
  TwoFactorController({required this.repo});

  bool submitLoading = false;
  String currentText = '';

  void verify2FACode(String currentText) async {
    if (currentText.isEmpty) {
      CustomSnackBar.error(errorList: [MyStrings.otpFieldEmptyMsg]);
      return;
    }

    submitLoading = true;
    update();

    ResponseModel responseModel = await repo.verify(currentText);

    if (responseModel.statusCode == 200) {
      AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(
        jsonDecode(responseModel.responseJson),
      );

      if (model.status == MyStrings.success) {
        Get.offAndToNamed(RouteHelper.bottomNavBar);
        CustomSnackBar.success(
          successList: model.message?.success ?? [MyStrings.requestSuccess],
        );
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

  void enable2fa(String key, String code) async {
    if (code.isEmpty) {
      CustomSnackBar.error(errorList: [MyStrings.otpFieldEmptyMsg]);
      return;
    }

    submitLoading = true;
    update();

    ResponseModel responseModel = await repo.enable2fa(key, code);

    if (responseModel.statusCode == 200) {
      AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(
        jsonDecode(responseModel.responseJson),
      );
      if (model.status.toString() ==
          MyStrings.success.toString().toLowerCase()) {
        CustomSnackBar.success(
          successList: model.message?.success ?? [MyStrings.requestSuccess],
        );
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

  void disable2fa(String code) async {
    if (code.isEmpty) {
      CustomSnackBar.error(errorList: [MyStrings.otpFieldEmptyMsg]);
      return;
    }

    submitLoading = true;
    update();

    ResponseModel responseModel = await repo.disable2fa(code);

    if (responseModel.statusCode == 200) {
      AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(
        jsonDecode(responseModel.responseJson),
      );

      if (model.status.toString() ==
          MyStrings.success.toString().toLowerCase()) {
        CustomSnackBar.success(
          successList: model.message?.success ?? [MyStrings.requestSuccess],
        );
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

  bool isLoading = false;
  TwoFactorCodeModel twoFactorCodeModel = TwoFactorCodeModel();

  void get2FaCode() async {
    isLoading = true;
    update();

    ResponseModel responseModel = await repo.get2FaData();

    if (responseModel.statusCode == 200) {
      TwoFactorCodeModel model = twoFactorCodeModelFromJson(
        responseModel.responseJson,
      );

      if (model.status.toString() ==
          MyStrings.success.toString().toLowerCase()) {
        twoFactorCodeModel = model;
        isLoading = false;
        update();
      } else {
        CustomSnackBar.error(
          errorList: model.message?.error ?? [MyStrings.requestFail],
        );
      }
    } else {
      CustomSnackBar.error(errorList: [responseModel.message]);
    }
    isLoading = false;
    update();
  }
}
