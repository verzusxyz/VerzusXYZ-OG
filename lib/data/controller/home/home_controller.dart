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

/// A controller for managing the home screen's state and data.
class HomeController extends GetxController {
  /// The repository for fetching home screen data.
  HomeRepo homeRepo;

  /// Creates a new [HomeController] instance.
  ///
  /// - [homeRepo]: The repository for home screen data.
  HomeController({required this.homeRepo});

  /// The KYC verification status of the user.
  String isKycVerified = '1';

  /// The user's total balance.
  String totalBalance = "0.00";

  /// The user's name.
  String name = "";

  /// The number of trending games.
  int trendingGamesLength = 0;

  /// The user's email address.
  String email = "";

  /// A flag indicating whether the screen is currently loading data.
  bool isLoading = true;

  /// The user's username.
  String username = "";

  /// The user's first name.
  String firstName = "";

  /// The name of the site.
  String siteName = "";

  /// The path to the user's image.
  String imagePath = "";

  /// The default currency.
  String defaultCurrency = "";

  /// The current index of the slider banner.
  int currentIndex = 0;

  /// The default currency symbol.
  String defaultCurrencySymbol = "";

  /// The general settings of the application.
  GeneralSettingResponseModel generalSettingResponseModel =
      GeneralSettingResponseModel();

  /// A list of all game images.
  List<String> allGamesImages = [];

  /// A list of all games.
  List<Game> gamesList = [];

  /// A list of trending games.
  List<Games> trendingGamesList = [];

  /// A list of featured games.
  List<Games> featuredGamesList = [];

  /// A list of slider banner images.
  List<SliderImageName> sliderBannerList = [];

  /// Initializes the home screen data.
  ///
  /// - [shouldLoad]: Whether to show the loading indicator.
  Future<void> initialData({bool shouldLoad = true}) async {
    allGamesInfo();
    await loadData();
  }

  /// Loads essential data from shared preferences and the API client.
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

  /// Fetches all game information from the server.
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

  /// Changes the current index of the slider banner.
  ///
  /// - [index]: The new index for the slider banner.
  void changeCurrentSliderIndex(int index) {
    currentIndex = index;

    update();
  }
}
