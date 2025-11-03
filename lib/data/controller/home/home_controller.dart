import 'dart:async';
import 'dart:convert';
import 'package:verzusxyz/core/helper/shared_preference_helper.dart';
import 'package:verzusxyz/core/utils/my_strings.dart';
import 'package:verzusxyz/data/model/general_setting/general_setting_response_model.dart';
import 'package:verzusxyz/data/model/global/response_model/response_model.dart';
import 'package:verzusxyz/data/model/home_screen/home_screen_model.dart';
import 'package:verzusxyz/data/repo/home/home_repo.dart';
import 'package:verzusxyz/view/components/snack_bar/show_custom_snackbar.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  HomeRepo homeRepo;
  HomeController({required this.homeRepo});

  String isKycVerified = '1';

  String totalBalance = "0.00";
  String name = "";

  int trendingGamesLength = 0;

  String email = "";
  bool isLoading = true;
  String username = "";
  String firstName = "";
  String siteName = "";
  String imagePath = "";
  String defaultCurrency = "";
  int currentIndex = 0;

  String defaultCurrencySymbol = "";
  GeneralSettingResponseModel generalSettingResponseModel =
      GeneralSettingResponseModel();

  List<String> allGamesImages = [];
  List<Game> gamesList = [];
  List<Games> trendingGamesList = [];
  List<Games> featuredGamesList = [];
  List<SliderImageName> sliderBannerList = [];

  Future<void> initialData({bool shouldLoad = true}) async {
    allGamesInfo();
    await loadData();
  }

  Future<void> loadData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    defaultCurrency = homeRepo.apiClient.getCurrencyOrUsername();
    username = homeRepo.apiClient.getCurrencyOrUsername(isCurrency: false);
    email = homeRepo.apiClient.getUserEmail();
    defaultCurrencySymbol = homeRepo.apiClient.getCurrencyOrUsername(
      isSymbol: true,
    );
    generalSettingResponseModel = homeRepo.apiClient.getGSData();
    siteName = generalSettingResponseModel.data?.generalSetting?.siteName ?? "";
    firstName =
        sharedPreferences.getString(SharedPreferenceHelper.fullNameKey) ?? "";
    homeRepo.apiClient.sharedPreferences.setString(
      SharedPreferenceHelper.defaultCurrencyKey,
      defaultCurrencySymbol,
    );
  }

  void allGamesInfo() async {
    isLoading = true;
    allGamesImages.clear();
    gamesList.clear();
    featuredGamesList.clear();
    trendingGamesList.clear();
    sliderBannerList.clear();
    name = "";
    update();
    ResponseModel model = await homeRepo.getData();
    if (model.statusCode == 200) {
      HomeScreenModel responseModel = HomeScreenModel.fromJson(
        jsonDecode(model.responseJson),
      );
      if (responseModel.status?.toLowerCase() ==
          MyStrings.success.toLowerCase()) {
        if (responseModel.data?.games != null) {
          gamesList.addAll(responseModel.data?.games ?? []);
        }
        if (responseModel.data?.gamesTrending != null) {
          trendingGamesList.addAll(responseModel.data?.gamesTrending ?? []);
        }
        if (responseModel.data?.gamesTrending != null) {
          featuredGamesList.addAll(responseModel.data?.gamesFeatured ?? []);
        }
        if (responseModel.data?.sliderImageNames != null) {
          sliderBannerList.addAll(responseModel.data?.sliderImageNames ?? []);
        }

        name = responseModel.data?.widget?.name.toString() ?? "";
        totalBalance =
            responseModel.data?.widget?.totalBalance.toString() ?? "0.00";
      }
      isKycVerified = responseModel.data?.user?.kv ?? "";
    } else {
      CustomSnackBar.error(errorList: [model.message]);
    }
    isLoading = false;
    update();
  }

  void changeCurrentSliderIndex(int index) {
    currentIndex = index;

    update();
  }
}
