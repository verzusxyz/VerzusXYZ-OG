import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:verzusxyz/core/utils/my_strings.dart';
import 'package:verzusxyz/data/controller/all_games/rock_paper_scissors_controller.dart';
import 'package:verzusxyz/data/model/black_jack_ans/black_jack_ans_model.dart';
import 'package:verzusxyz/data/model/black_jack_hit/black_jack_hit_model.dart';
import 'package:verzusxyz/data/model/black_jack_invest/black_jack_invest_model.dart';
import 'package:verzusxyz/data/model/global/response_model/response_model.dart';
import 'package:verzusxyz/data/model/head-tail/head_tail_model.dart';
import 'package:verzusxyz/data/repo/all-games/black_jack/black_jack_repo.dart';
import 'package:verzusxyz/view/components/alert-dialog/custom_alert_dialog.dart';
import 'package:verzusxyz/view/components/snack_bar/show_custom_snackbar.dart';
import 'package:verzusxyz/view/screens/all-games/roulette/widget/lose_dialog.dart';
import 'package:verzusxyz/view/screens/all-games/widgets/winner_dialogue.dart';
import 'package:get/get.dart';

class BlackJackController extends GetxController {
  BlackJackRepo blackJackRepo;
  BlackJackController({required this.blackJackRepo});
  TextEditingController amountController = TextEditingController();

  var amountFocusNode = FocusNode();

  Choice? userChoice;

  bool isLoading = false;
  bool isSubmitted = false;
  bool playNow = false;
  bool isBackShow = false;

  String name = "";
  String hitStatus = "";
  String availableBalance = "0.00";
  String alias = "";
  String instruction = "";
  String shortDescription = "";
  String defaultCurrency = "";
  String defaultCurrencySymbol = "";
  String minimum = "0.00";
  String maximum = "0.00";
  String winningPercentage = "0.00";

  Future<void> loadCurrency() async {
    defaultCurrency = blackJackRepo.apiClient.getCurrencyOrUsername();

    defaultCurrencySymbol = blackJackRepo.apiClient.getCurrencyOrUsername(
      isSymbol: true,
    );
  }

  void loadGameInfo() async {
    isLoading = true;
    myScrenCards.clear();
    dealearCards.clear();

    delearSum = "";
    userSum = "";
    delearAceCount = "";
    loadCurrency();
    update();
    ResponseModel model = await blackJackRepo.loadData();
    if (model.statusCode == 200) {
      HeadTailModel responseModel = HeadTailModel.fromJson(
        jsonDecode(model.responseJson),
      );
      if (responseModel.status?.toLowerCase() ==
          MyStrings.success.toLowerCase()) {
        name = responseModel.data?.game?.name.toString() ?? "";
        alias = responseModel.data?.game?.alias.toString() ?? "";
        availableBalance = responseModel.data?.userBalance.toString() ?? "";
        instruction = responseModel.data?.game?.instruction.toString() ?? "";
        shortDescription = responseModel.data?.game?.shortDesc.toString() ?? "";
        minimum = responseModel.data?.game?.minLimit.toString() ?? "";
        maximum = responseModel.data?.game?.maxLimit.toString() ?? "";
        if (responseModel.data?.game?.investBack == "1") {
          double? winningAmount =
              double.tryParse(responseModel.data?.game?.win.toString() ?? "") ??
              0.0;
          winningAmount += 100.0;

          winningPercentage = winningAmount.toString();
        } else {
          winningPercentage = responseModel.data?.game?.win.toString() ?? "";
        }
      }
    } else {
      CustomSnackBar.error(errorList: [model.message]);
    }
    isLoading = false;
    update();
  }

  String gameId = "";

  List<String> myScrenCards = [];
  List<String> dealearCards = [];

  String delearSum = '';
  String delearAceCount = '';
  String userSum = '';

  bool showResult = false;

  submitInvestmentRequest() async {
    myScrenCards.clear();
    dealearCards.clear();
    hitStatus = "";
    delearSum = "";
    userSum = "";
    delearAceCount = "";
    isBackShow = false;
    isSubmitted = true;
    amountFocusNode.unfocus();
    update();

    ResponseModel model = await blackJackRepo.blackJackInvest(
      amountController.text,
    );

    if (model.statusCode == 200) {
      BlackJackInvestModel blackJackInvestModel = BlackJackInvestModel.fromJson(
        jsonDecode(model.responseJson),
      );

      if (blackJackInvestModel.status?.toLowerCase() ==
          MyStrings.success.toLowerCase()) {
        availableBalance = blackJackInvestModel.data?.balance.toString() ?? "";
        gameId = blackJackInvestModel.data?.gameLog?.id.toString() ?? "";
        delearSum = blackJackInvestModel.data?.dealerSum.toString() ?? "";
        delearAceCount =
            blackJackInvestModel.data?.dealerAceCount.toString() ?? "";
        userSum = blackJackInvestModel.data?.userSum.toString() ?? "";

        myScrenCards.addAll(blackJackInvestModel.data?.cardImg ?? []);

        dealearCards.addAll(blackJackInvestModel.data?.dealerCardImg ?? []);

        playNow = true;
      } else {
        CustomSnackBar.error(
          errorList:
              blackJackInvestModel.message?.error ??
              [MyStrings.somethingWentWrong.tr],
        );
      }
    } else {
      CustomSnackBar.error(errorList: [model.message]);
    }
    isSubmitted = false;
    update();
  }

  bool isHitted = false;

  hit() async {
    isHitted = true;
    hitStatus = '';
    update();
    ResponseModel model = await blackJackRepo.blackJackhitRepo(gameId);

    if (model.statusCode == 200) {
      BlackJackHitModel blackJackHitModel = BlackJackHitModel.fromJson(
        jsonDecode(model.responseJson),
      );
      hitStatus = blackJackHitModel.status?.toString() ?? "";
      if (blackJackHitModel.status?.toLowerCase() ==
          MyStrings.success.toLowerCase()) {
        userSum = blackJackHitModel.data?.userSum.toString() ?? "";

        List<String> userNewCard = blackJackHitModel.data?.cardImg ?? [];

        for (String cardImage in userNewCard) {
          String cleanedCardImage = cardImage.replaceAll(
            RegExp(r'[^a-zA-Z0-9-]'),
            '',
          );

          myScrenCards.add(cleanedCardImage);
        }

        update();
        playNow = true;
      } else {
        CustomSnackBar.error(
          errorList:
              blackJackHitModel.message?.error ??
              [MyStrings.somethingWentWrong.tr],
        );
      }
    } else {
      CustomSnackBar.error(errorList: [model.message]);
    }
    isHitted = false;
    update();
  }

  bool isStaying = false;

  stay() async {
    isStaying = true;
    update();
    ResponseModel model = await blackJackRepo.stay(gameId);

    if (model.statusCode == 200) {
      BlackJackAnswerModel blackJackAnswerModel = BlackJackAnswerModel.fromJson(
        jsonDecode(model.responseJson),
      );

      if (blackJackAnswerModel.status?.toLowerCase() ==
          MyStrings.success.toLowerCase()) {
        Timer(const Duration(seconds: 3), () {
          availableBalance = blackJackAnswerModel.data?.balance ?? "";
          if (blackJackAnswerModel.data?.winStatus == 1) {
            CustomAlertDialog(
              child: WinnerDialog(result: userSum.toString()),
            ).customAlertDialog(Get.context!);
          } else {
            CustomAlertDialog(
              child: LoseDialog(isShowResult: true, result: userSum.toString()),
            ).customAlertDialog(Get.context!);
          }

          update();
          // availableBalance = blackJackAnswerModel.data!..toString();
        });
        dealearCards.insert(
          0,
          blackJackAnswerModel.data!.hiddenImage.toString(),
        );
        isBackShow = true;
        showResult = true;
        isSubmitted = false;
        update();
      }
    } else {
      CustomSnackBar.error(errorList: [model.message]);
    }
    isStaying = false;
    update();
  }

  playAgain() {
    showResult = false;
    submitInvestmentRequest();
    update();
  }

  back() {
    playNow = false;
    showResult = false;
    amountController.text = "";
    update();
  }
}
