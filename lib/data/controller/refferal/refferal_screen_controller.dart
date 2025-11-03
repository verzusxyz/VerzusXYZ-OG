import 'dart:convert';
import 'package:verzusxyz/core/helper/shared_preference_helper.dart';
import 'package:verzusxyz/data/model/global/response_model/response_model.dart';
import 'package:verzusxyz/data/model/refferal/refferalModel.dart';
import 'package:verzusxyz/data/repo/refferal/refferal_screen_repo.dart';
import 'package:verzusxyz/view/components/snack_bar/show_custom_snackbar.dart';
import 'package:get/get.dart';
import 'package:verzusxyz/data/model/profile/profile_response_model.dart';

class RefferalScreenController extends GetxController {
  RefferalScreenRepo refferalScreenRepo;
  ProfileResponseModel model = ProfileResponseModel();

  RefferalScreenController({required this.refferalScreenRepo});

  bool isLoading = false;
  String username = "";

  String savedUsername = "";
  getUsername() {
    savedUsername =
        refferalScreenRepo.apiClient.sharedPreferences.getString(
          SharedPreferenceHelper.userNameKey,
        ) ??
        "";
    update();
  }

  List<ReferralUsers> refferalData = [];

  void allGamesInfo() async {
    isLoading = true;
    refferalData.clear();
    getUsername();

    update();
    ResponseModel model = await refferalScreenRepo.refferalData();
    if (model.statusCode == 200) {
      RefferalDataModel refferalModel = RefferalDataModel.fromJson(
        jsonDecode(model.responseJson),
      );
      username = refferalModel.data?.referralUsers?.username ?? "";

      refferalData.addAll(
        refferalModel.data?.referralUsers?.allReferrals ?? [],
      );
      update();
    } else {
      CustomSnackBar.error(errorList: [model.message]);
    }
    isLoading = false;
    update();
  }
}
