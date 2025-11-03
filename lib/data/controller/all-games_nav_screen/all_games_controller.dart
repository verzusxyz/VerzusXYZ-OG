import 'dart:convert';
import 'package:verzusxyz/data/model/game_screen/game_screen_model.dart';
import 'package:verzusxyz/data/model/global/response_model/response_model.dart';
import 'package:verzusxyz/data/repo/all-games/all_games_repo.dart';
import 'package:verzusxyz/view/components/snack_bar/show_custom_snackbar.dart';
import 'package:get/get.dart';

class AllGamesNavScreenController extends GetxController {
  AllGanmesRepo allGanmesRepo;
  AllGamesNavScreenController({required this.allGanmesRepo});

  String email = "";
  String totalBalance = "";
  String name = "";
  bool isLoading = true;
  String username = "";
  String siteName = "";
  String imagePath = "";
  String defaultCurrency = "";
  String alias = "";
  int currentIndex = 0;

  String defaultCurrencySymbol = "";

  List<Game> gamesList = [];
  List<Games> featuredGamesList = [];

  List<Game> filteredGames = [];

  void filterGames(String query) {
    if (query.isEmpty) {
      filteredGames.clear();
      update();
      return;
    }

    final List<Game> filteredList = gamesList.where((game) {
      return game.name!.toLowerCase().contains(query.toLowerCase());
    }).toList();

    filteredGames = filteredList;
    update();
  }

  allGamesInfo() async {
    isLoading = true;
    gamesList.clear();
    featuredGamesList.clear();
    update();
    ResponseModel model = await allGanmesRepo.loadData();
    if (model.statusCode == 200) {
      GameScreenModel responseModel = GameScreenModel.fromJson(
        jsonDecode(model.responseJson),
      );

      if (responseModel.data?.games != null) {
        gamesList.addAll(responseModel.data?.games ?? []);
        featuredGamesList.addAll(responseModel.data?.gamesFeatured ?? []);
        name = responseModel.data?.widget?.name.toString() ?? "";
        totalBalance =
            responseModel.data?.widget?.totalBalance.toString() ?? "";
      }
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
