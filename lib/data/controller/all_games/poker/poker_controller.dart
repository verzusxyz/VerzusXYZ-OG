import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:verzusxyz/core/helper/string_format_helper.dart';
import 'package:verzusxyz/core/utils/my_images.dart';
import 'package:verzusxyz/core/utils/my_strings.dart';
import 'package:verzusxyz/data/controller/all_games/rock_paper_scissors_controller.dart';
import 'package:verzusxyz/data/model/global/response_model/response_model.dart';
import 'package:verzusxyz/data/model/poker/poker_invest_model.dart';
import 'package:verzusxyz/data/model/poker_call/poker_call_model.dart';
import 'package:verzusxyz/data/model/poker_cards/poker_cards.dart';
import 'package:verzusxyz/data/model/poker_data/poker_data_model.dart';
import 'package:verzusxyz/data/model/poker_deal/poker_deal.dart';
import 'package:verzusxyz/data/model/poker_fold/poker_fold_model.dart';
import 'package:verzusxyz/data/repo/all-games/poker/poker_repo.dart';
import 'package:verzusxyz/view/components/alert-dialog/custom_alert_dialog.dart';
import 'package:verzusxyz/view/components/snack_bar/show_custom_snackbar.dart';
import 'package:verzusxyz/view/screens/all-games/roulette/widget/lose_dialog.dart';
import 'package:verzusxyz/view/screens/all-games/widgets/winner_dialogue.dart';
import 'package:get/get.dart';

class PokerController extends GetxController {
  PokerRepo pokerRepo;
  PokerController({required this.pokerRepo});
  TextEditingController amountController = TextEditingController();

  var amiountFocusNode = FocusNode();

  Choice? userChoice;

  List<String> gesBon = [];
  List<String> pokerImg = [];

  bool isLoading = false;
  bool isSubmitted = false;
  bool isInvested = false;
  bool isDeal = false;
  bool isCallAndFoldShow = false;

  String name = "";
  String availableBalance = "0.00";
  String alias = "";
  String instruction = "";
  String defaultCurrency = "";
  String defaultCurrencySymbol = "";
  String minimum = "0.00";
  String maximum = "0.00";
  String winningPercentage = "";

  List<PokerCardModel> pokerBackCards = [
    PokerCardModel(imagePath: MyImages.back, isNetworkImage: false),
    PokerCardModel(imagePath: MyImages.back, isNetworkImage: false),
    PokerCardModel(imagePath: MyImages.back, isNetworkImage: false),
    PokerCardModel(imagePath: MyImages.back, isNetworkImage: false),
    PokerCardModel(imagePath: MyImages.back, isNetworkImage: false),
  ];

  Future<void> loadCurrency() async {
    defaultCurrency = pokerRepo.apiClient.getCurrencyOrUsername();

    defaultCurrencySymbol = pokerRepo.apiClient.getCurrencyOrUsername(
      isSymbol: true,
    );
  }

  void loadGameInfo() async {
    isLoading = true;
    gesBon.clear();
    pokerImg.clear();
    loadCurrency();
    update();
    ResponseModel model = await pokerRepo.loadDataRepo();
    if (model.statusCode == 200) {
      PokerDataModel responseModel = PokerDataModel.fromJson(
        jsonDecode(model.responseJson),
      );
      if (responseModel.status?.toLowerCase() ==
          MyStrings.success.toLowerCase()) {
        name = responseModel.data?.game?.name.toString() ?? "";
        alias = responseModel.data?.game?.alias.toString() ?? "";
        availableBalance = responseModel.data?.userBalance.toString() ?? "0.00";
        instruction = responseModel.data?.game?.instruction.toString() ?? "";
        minimum = responseModel.data?.game?.minLimit.toString() ?? "0.00";
        maximum = responseModel.data?.game?.maxLimit.toString() ?? "0.00";

        if (responseModel.data?.gesBon != null) {
          gesBon.addAll(responseModel.data?.gesBon ?? []);
        }
        if (responseModel.data?.pokerImg != null) {
          pokerImg.addAll(responseModel.data?.pokerImg ?? []);
        }
      }
    } else {
      CustomSnackBar.error(errorList: [model.message]);
    }
    isLoading = false;
    update();
  }

  String gameId = "";

  submitInvestmentRequest() async {
    isSubmitted = true;
    amiountFocusNode.unfocus();
    update();

    ResponseModel model = await pokerRepo.investRepo(amountController.text);

    if (model.statusCode == 200) {
      PokerInvestModel submitAnswer = PokerInvestModel.fromJson(
        jsonDecode(model.responseJson),
      );

      if (submitAnswer.status?.toLowerCase() ==
          MyStrings.success.toLowerCase()) {
        gameId = submitAnswer.data?.gameLogId.toString() ?? "";
        availableBalance = submitAnswer.data?.balance.toString() ?? "";
        isInvested = true;
        isDeal = true;
      } else {
        CustomSnackBar.error(
          errorList:
              submitAnswer.message?.error ?? [MyStrings.somethingWentWrong.tr],
        );
      }
    } else {
      CustomSnackBar.error(errorList: [model.message]);
    }
    isSubmitted = false;
    update();
  }

  bool isDealLoading = false;

  deal() async {
    isDealLoading = true;
    update();

    ResponseModel model = await pokerRepo.dealRepo(gameId);

    if (model.statusCode == 200) {
      PokerDealModel pokerDealModel = PokerDealModel.fromJson(
        jsonDecode(model.responseJson),
      );

      if (pokerDealModel.status?.toLowerCase() ==
          MyStrings.success.toLowerCase()) {
        List<String> result = pokerDealModel.data?.result ?? [];
        for (int i = 0; i < result.length; i++) {
          if (i < pokerBackCards.length) {
            pokerBackCards[i].imagePath = result[i];
            pokerBackCards[i].isNetworkImage = true;
          } else {
            break;
          }
        }
        isDeal = false;
        isCallAndFoldShow = true;
        isSubmitted = false;

        update();
      }
    } else {
      CustomSnackBar.error(errorList: [model.message]);
    }
    isDealLoading = false;
    update();
  }

  bool isCalled = false;

  call() async {
    isCalled = true;
    update();

    ResponseModel model = await pokerRepo.callRepo(gameId);

    if (model.statusCode == 200) {
      PokerCallModel pokerCallModel = PokerCallModel.fromJson(
        jsonDecode(model.responseJson),
      );

      if (pokerCallModel.status?.toLowerCase() ==
          MyStrings.success.toLowerCase()) {
        List<String> result = pokerCallModel.data?.result ?? [];

        if (result.length >= 2) {
          pokerBackCards[3].imagePath = result[0];
          pokerBackCards[3].isNetworkImage = true;

          pokerBackCards[4].imagePath = result[1];
          pokerBackCards[4].isNetworkImage = true;
          update();
        }

        Timer(const Duration(seconds: 3), () {
          if (pokerCallModel.data != null &&
              pokerCallModel.data!.type != MyStrings.danger) {
            availableBalance = pokerCallModel.data?.balance ?? "";
            CustomAlertDialog(
              child: WinnerDialog(
                result: pokerCallModel.data!.result.toString(),
              ),
            ).customAlertDialog(Get.context!);

            resetAll();
            update();
          } else {
            CustomAlertDialog(
              child: LoseDialog(
                result: pokerCallModel.data?.rank.toString() ?? "",
                isShowResult: true,
              ),
            ).customAlertDialog(Get.context!);
            resetAll();
            update();
          }
        });

        isDeal = false;
        isCallAndFoldShow = true;
        isSubmitted = false;
        update();
      }
    } else {
      CustomSnackBar.error(errorList: [model.message]);
    }

    isCalled = false;
    update();
  }

  bool isFold = false;
  fold() async {
    isFold = true;
    update();
    ResponseModel model = await pokerRepo.foldRepo(gameId);

    if (model.statusCode == 200) {
      PokerFoldModel pokerFoldModel = PokerFoldModel.fromJson(
        jsonDecode(model.responseJson),
      );

      if (pokerFoldModel.status?.toLowerCase() ==
          MyStrings.success.toLowerCase()) {
        Timer(const Duration(seconds: 3), () {
          if (pokerFoldModel.data != null &&
              pokerFoldModel.data!.type != MyStrings.danger) {
            availableBalance = Converter.formatNumber(
              pokerFoldModel.data?.balance ?? "",
            );

            CustomAlertDialog(
              child: WinnerDialog(
                result: pokerFoldModel.data?.result.toString() ?? "",
              ),
            ).customAlertDialog(Get.context!);

            resetAll();
            update();
          } else {
            CustomAlertDialog(
              child: LoseDialog(
                result: pokerFoldModel.data?.rank.toString() ?? "",
                isShowResult: true,
              ),
            ).customAlertDialog(Get.context!);
            resetAll();
            update();
          }
        });

        isDeal = false;
        isCallAndFoldShow = true;
        isSubmitted = false;
        update();
      }
    } else {
      CustomSnackBar.error(errorList: [model.message]);
    }
    isFold = false;
    update();
  }

  resetAll() {
    amountController.text = "";
    isCallAndFoldShow = false;
    isInvested = false;
    isDeal = false;
    for (int i = 0; i < pokerBackCards.length; i++) {
      pokerBackCards[i] = PokerCardModel(
        imagePath: MyImages.back,
        isNetworkImage: false,
      );
    }
    update();
  }
}
