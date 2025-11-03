import 'dart:convert';
import 'package:verzusxyz/data/model/game_log/game_log_model.dart';
import 'package:verzusxyz/data/repo/gamelog/gamelog_repo.dart';
import 'package:get/get.dart';
import 'package:verzusxyz/core/utils/my_strings.dart';
import 'package:verzusxyz/data/model/global/response_model/response_model.dart';
import 'package:verzusxyz/view/components/snack_bar/show_custom_snackbar.dart';

class GameLogController extends GetxController {
  GameLogRepo gameLogRepo;
  GameLogController({required this.gameLogRepo});

  List<GameLog> gameLogList = [];
  String currencySym = "";
  bool isLoading = false;

  // void loadData() async {
  //   isLoading = true;
  //   update();

  //   await gameLogData();
  //         isLoading = false;

  // }

  gameLogData() async {
    isLoading = true;
    update();
    currencySym = gameLogRepo.apiClient.getCurrencyOrUsername(isSymbol: true);
    ResponseModel response = await gameLogRepo.gameLog();

    if (response.statusCode == 200) {
      GameLogModel model = GameLogModel.fromJson(
        jsonDecode(response.responseJson),
      );
      if (model.status?.toLowerCase() == MyStrings.success.toLowerCase()) {
        update();
        gameLogList.addAll(model.data?.gameLogs ?? []);
      } else {
        List<String> message = [MyStrings.somethingWentWrong];
        CustomSnackBar.error(errorList: model.message?.error ?? message);
      }
    } else {
      CustomSnackBar.error(errorList: [response.message]);
    }
    isLoading = false;
    update();
  }

  int expandedIndex = -1;

  bool showExpandedSection = false;

  void changeShowDetails() {
    showExpandedSection = !showExpandedSection;
    update();
  }

  void updateExpandedIndex(int index) {
    if (expandedIndex == index) {
      expandedIndex = -1;
    } else {
      expandedIndex = index;
    }
    update();
  }
}
