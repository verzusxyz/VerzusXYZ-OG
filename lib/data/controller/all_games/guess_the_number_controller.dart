import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:verzusxyz/core/helper/shared_preference_helper.dart';
import 'package:verzusxyz/core/helper/string_format_helper.dart';
import 'package:verzusxyz/core/utils/my_strings.dart';
import 'package:verzusxyz/data/model/global/response_model/response_model.dart';
import 'package:verzusxyz/data/model/guess_the_number_data/guess_the_number_model.dart';
import 'package:verzusxyz/data/model/guess_the_number_result/guess_the_number_result.dart';
import 'package:verzusxyz/data/model/guess_the_number_submit_ans/guess_the_number_submit_ans.dart';
import 'package:verzusxyz/data/repo/all-games/guess_the_number/guess_the_number_repo.dart';
import 'package:verzusxyz/view/components/alert-dialog/custom_alert_dialog.dart';
import 'package:verzusxyz/view/components/snack_bar/show_custom_snackbar.dart';
import 'package:verzusxyz/view/screens/all-games/roulette/widget/lose_dialog.dart';
import 'package:verzusxyz/view/screens/all-games/widgets/winner_dialogue.dart';
import 'package:get/get.dart';

class GuessTheNumberController extends GetxController {
  GuessTheNumberRepo guessTheNumberRepo;
  GuessTheNumberController({required this.guessTheNumberRepo});
  TextEditingController amountController = TextEditingController();
  TextEditingController guessNumberController = TextEditingController();
  var amountFocusNode = FocusNode();
  var guessTheNumberFocusNode = FocusNode();

  int adminNumber = 6;
  bool isLoading = false;
  bool isSubmitted = false;
  String screenmsg = "";
  String type = "";
  int countGuessingTime = 0;

  String availAbleBalance = "0";
  String minimumAoumnnt = "0";
  String maxAoumnnt = "0";
  String gameName = "";
  String instruction = "";
  String chances = "0";
  String defaultCurrencySymbol = "0";
  String defaultCurrency = "0";
  String winningPercentage = "0.00";

  int checkCounter = 0;
  bool isButtonEnable = true;
  bool hideAmountField = false;

  List<String> winningPercentages = [];

  void updateWinningPercentage() {
    if (checkCounter < winningPercentages.length) {
      winningPercentage = winningPercentages[checkCounter];
    } else {
      winningPercentage = "";
    }
    update();
  }

  void loadGameInfo() async {
    isLoading = true;
    defaultCurrency = guessTheNumberRepo.apiClient.getCurrencyOrUsername();
    defaultCurrencySymbol = guessTheNumberRepo.apiClient.getCurrencyOrUsername(
      isSymbol: true,
    );
    update();
    ResponseModel model = await guessTheNumberRepo.loadData();
    if (model.statusCode == 200) {
      GuessDataModel responseModel = GuessDataModel.fromJson(
        jsonDecode(model.responseJson),
      );
      availAbleBalance = responseModel.data?.userBalance.toString() ?? "0";
      if (responseModel.status?.toLowerCase() ==
          MyStrings.success.toLowerCase()) {
        minimumAoumnnt = responseModel.data?.game?.minLimit.toString() ?? "0";
        maxAoumnnt = responseModel.data?.game?.maxLimit.toString() ?? "0";
        gameName = responseModel.data?.game?.name.toString() ?? "0";
        instruction = responseModel.data?.game?.instruction.toString() ?? "0";
        chances = responseModel.data?.winChance.toString() ?? "0";
        winningPercentages.addAll(responseModel.data?.winPercent ?? []);
        screenmsg = "You wiill get $chances chances per invest";
        guessTheNumberRepo.apiClient.sharedPreferences.setString(
          SharedPreferenceHelper.savedScreenMsgKey,
          screenmsg,
        );
        updateWinningPercentage();
      }
    } else {
      CustomSnackBar.error(errorList: [model.message]);
    }
    isLoading = false;
    update();
  }

  String gameId = "";
  String selectedColor = "";

  submitInvestmentRequest() async {
    amountFocusNode.unfocus();
    guessTheNumberFocusNode.unfocus();
    isSubmitted = true;

    update();
    int.tryParse(chances);

    ResponseModel model = await guessTheNumberRepo.submitAnswer(
      amountController.text,
      guessNumberController.text,
    );
    if (model.statusCode == 200) {
      GuessTheNumberSubmitAnsModel submitAnswer =
          GuessTheNumberSubmitAnsModel.fromJson(jsonDecode(model.responseJson));

      if (submitAnswer.status?.toLowerCase() ==
          MyStrings.success.toLowerCase()) {
        availAbleBalance = Converter.formatNumber(
          submitAnswer.data?.balance ?? "",
        );
        gameId = submitAnswer.data?.gameLog?.id.toString() ?? "";
        endTheGame();
        hideAmountField = true;
        checkCounter++;
      } else {
        CustomSnackBar.error(
          errorList:
              submitAnswer.message?.error ?? [MyStrings.somethingWentWrong.tr],
        );
        isSubmitted = false;
        update();
      }
    } else {
      CustomSnackBar.error(errorList: [model.message]);
    }

    isSubmitted = false;
    update();
  }

  String extractNumber(String input) {
    final regExp = RegExp(r'\d+');

    final matches = regExp.allMatches(input);

    if (matches.isNotEmpty) {
      return matches.first.group(0) ?? '';
    }

    return '';
  }

  endTheGame() async {
    isSubmitted = true;
    update();
    var chance = int.tryParse(chances);

    ResponseModel model = await guessTheNumberRepo.getAnswer(
      gameId,
      guessNumberController.text,
    );

    if (model.statusCode == 200) {
      GuessTheNumberResultModel guessTheNumberResultModel =
          GuessTheNumberResultModel.fromJson(jsonDecode(model.responseJson));

      updateWinningPercentage();

      if (guessTheNumberResultModel.status?.toLowerCase() ==
          MyStrings.success.toLowerCase()) {
        screenmsg = guessTheNumberResultModel.data!.message.toString();

        type = guessTheNumberResultModel.data?.type.toString() ?? "";
        if (checkCounter > int.tryParse(chances)! ||
            guessTheNumberResultModel.data!.winStatus == "1") {
          if (guessTheNumberResultModel.data!.winStatus == "1") {
            CustomAlertDialog(
              child: WinnerDialog(
                result: guessTheNumberResultModel.data!.winNumber.toString(),
              ),
            ).customAlertDialog(Get.context!);
            resetAll();
          }
          availAbleBalance = guessTheNumberResultModel.data?.bal ?? "";
        }
        if (guessTheNumberResultModel.data!.winStatus == "0") {
          String number = extractNumber(screenmsg);
          Timer(const Duration(seconds: 3), () {
            CustomAlertDialog(
              child: LoseDialog(isShowResult: true, result: number.toString()),
            ).customAlertDialog(Get.context!);
            resetAll();
          });
          availAbleBalance = guessTheNumberResultModel.data?.bal ?? "";
        }
      } else {
        isButtonEnable = true;
        hideAmountField = false;
        update();
      }
      if (checkCounter > chance!) {
        screenmsg = "You will get $chances chances per invest";
        resetAll();
      }
    } else {
      CustomSnackBar.error(errorList: [model.message]);
    }
    isSubmitted = false;
    update();
  }

  resetAll() {
    checkCounter = 0;
    type = "";
    amountController.text = "";
    guessNumberController.text = "";
    hideAmountField = false;
    updateWinningPercentage();
    countGuessingTime = 0;
    screenmsg =
        guessTheNumberRepo.apiClient.sharedPreferences.getString(
          SharedPreferenceHelper.savedScreenMsgKey,
        ) ??
        "";
    update();
  }
}
