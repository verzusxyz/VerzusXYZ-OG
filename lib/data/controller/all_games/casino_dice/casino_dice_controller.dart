import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:verzusxyz/core/helper/string_format_helper.dart';
import 'package:verzusxyz/core/utils/my_audio.dart';
import 'package:verzusxyz/core/utils/my_strings.dart';
import 'package:verzusxyz/data/model/casino_dice_data/casino_dice_data_model.dart';
import 'package:verzusxyz/data/model/casino_dice_result/casino_dice_result_model.dart';
import 'package:verzusxyz/data/model/casino_dice_submit_ans/casino_dice_submit_ans_model.dart';
import 'package:verzusxyz/data/model/global/response_model/response_model.dart';
import 'package:verzusxyz/data/repo/all-games/casino_dice/casino_dice_repo.dart';
import 'package:verzusxyz/view/components/alert-dialog/custom_alert_dialog.dart';
import 'package:verzusxyz/view/components/snack_bar/show_custom_snackbar.dart';
import 'package:verzusxyz/view/screens/all-games/roulette/widget/lose_dialog.dart';
import 'package:verzusxyz/view/screens/all-games/widgets/winner_dialogue.dart';
import 'package:get/get.dart';

class CasinoDiceController extends GetxController {
  CasinoDiceRepo casinoDiceRepo;
  CasinoDiceController({required this.casinoDiceRepo});
  TextEditingController amountController = TextEditingController();
  TextEditingController winChanceController = TextEditingController();
  TextEditingController bonusController = TextEditingController();

  var amountFocusNode = FocusNode();
  var winChanceFocusNode = FocusNode();
  var bonusFocusNode = FocusNode();

  int adminNumber = 6;
  int selectedDiceIndex = -1;
  bool isLoading = false;
  bool isSubmitted = false;

  String availAbleBalance = "0";
  String minimumAoumnnt = "0";
  String maxAmount = "0";
  String gameName = "";
  String instruction = "";
  String defaultCurrencySymbol = "0";
  String defaultCurrency = "0";

  List<int> numbers = List.filled(4, 0);
  bool isShuffling = false;

  Random random = Random();

  List<int> resultDigits = [];

  double sliderValue = 0;
  String? low = "0";
  String? high = "9999";
  String? winningPercentage = "";
  bool isHigh = false;

  AudioPlayer audioController = AudioPlayer();
  @override
  void onInit() {
    super.onInit();
    audioController = AudioPlayer();
  }

  void countBonus() {
    if (winChanceController.text.isEmpty || winChanceController.text == "0") {
      bonusController.text = "0";
      low = "0";
      high = "9999";
    } else {
      bonusController.text = (99 / double.tryParse(winChanceController.text)!)
          .toStringAsFixed(4);
      low = (100 * int.tryParse(winChanceController.text)!).toString();
      high = (9900 - (int.tryParse(winChanceController.text)! * 100) + 99)
          .toString();
    }

    update();
  }

  void updateWinChanceFromSlider(double value) {
    winChanceController.text = value.toStringAsFixed(0);
    sliderValue = value;
    countBonus();

    update();
  }

  void getCasinoDiceScreenData() async {
    isLoading = true;
    loadData();
    update();
    ResponseModel model = await casinoDiceRepo.loadData();
    if (model.statusCode == 200) {
      CasinoDiceDataModel responseModel = CasinoDiceDataModel.fromJson(
        jsonDecode(model.responseJson),
      );
      availAbleBalance = responseModel.data?.userBalance.toString() ?? "";
      if (responseModel.status?.toLowerCase() ==
          MyStrings.success.toLowerCase()) {
        minimumAoumnnt = responseModel.data?.game?.minLimit.toString() ?? "";
        maxAmount = responseModel.data?.game?.maxLimit.toString() ?? "";
        gameName = responseModel.data?.game?.name.toString() ?? "";
        instruction = responseModel.data?.game?.instruction.toString() ?? "";
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
  String selectedColor = "";

  bool enableBet = false;

  submitAnswer() async {
    amountFocusNode.unfocus();
    winChanceFocusNode.unfocus();
    bonusFocusNode.unfocus();
    isSubmitted = true;
    enableBet = true;
    update();
    ResponseModel model = await casinoDiceRepo.submitAnswer(
      winChanceController.text,
      amountController.text,
      isHigh ? "high" : "low",
    );
    if (model.statusCode == 200) {
      CasinoDiceSubmitAnsModel submitAnswer = CasinoDiceSubmitAnsModel.fromJson(
        jsonDecode(model.responseJson),
      );

      if (submitAnswer.status?.toLowerCase() ==
          MyStrings.success.toLowerCase()) {
        gameId = submitAnswer.data?.gameLogId.toString() ?? "";
        availAbleBalance = Converter.formatNumber(
          submitAnswer.data?.balance ?? "",
        );
        generateRandomNumbers();
        casinoDiceAnswer();
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

  String result = "0";
  casinoDiceAnswer() async {
    ResponseModel model = await casinoDiceRepo.getAnswer(gameId);

    if (model.statusCode == 200) {
      CasinoDiceResultModel casinoDiceAnswerModel =
          CasinoDiceResultModel.fromJson(jsonDecode(model.responseJson));

      if (casinoDiceAnswerModel.status?.toLowerCase() ==
          MyStrings.success.toLowerCase()) {
        result = casinoDiceAnswerModel.data!.result.toString();
        resultDigits = result.runes
            .map((rune) => int.parse(String.fromCharCode(rune)))
            .toList();

        update();

        Timer(const Duration(seconds: 12), () {
          if (casinoDiceAnswerModel.data!.win != "0") {
            CustomAlertDialog(
              child: WinnerDialog(
                result: casinoDiceAnswerModel.data?.result.toString() ?? "",
              ),
            ).customAlertDialog(Get.context!);
            isSubmitted = false;
            availAbleBalance =
                casinoDiceAnswerModel.data?.balance.toString() ?? "";
          } else {
            CustomAlertDialog(
              child: LoseDialog(
                isShowResult: true,
                result: casinoDiceAnswerModel.data?.result.toString() ?? "",
              ),
            ).customAlertDialog(Get.context!);
            isSubmitted = false;
          }
          availAbleBalance =
              casinoDiceAnswerModel.data?.balance.toString() ?? "";
          enableBet = false;
          resetAll();
          update();
        });

        for (int i = 0; i < 4; i++) {
          if (numbers[i] != resultDigits[i]) {
            generateRandomNumbers();
            break;
          }
        }

        isLoading = false;
        update();
      }
    } else {
      CustomSnackBar.error(errorList: [model.message]);
    }
  }

  Future<void> loadData() async {
    defaultCurrency = casinoDiceRepo.apiClient.getCurrencyOrUsername();
    defaultCurrencySymbol = casinoDiceRepo.apiClient.getCurrencyOrUsername(
      isSymbol: true,
    );
  }

  resetAll() {
    amountController.text = "";
    isSubmitted = false;
    winChanceController.text = "";
    bonusController.text = "";
    sliderValue = 0.0;
  }

  void generateRandomNumbers() {
    isShuffling = true;
    audioController.play(AssetSource(MyAudio.diceRollingAudio));
    update();

    int count = 0;
    Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (count >= 20) {
        timer.cancel();
        isShuffling = false;
        audioController.stop();
        update();
      } else {
        if (resultDigits.isEmpty) {
          for (int i = 0; i < 4; i++) {
            numbers[i] = random.nextInt(9) + 1;
          }
        } else {
          if (count == 19) {
            numbers = List.from(resultDigits);
            timer.cancel();
            isShuffling = false;
            audioController.stop();
            update();
          } else {
            for (int i = 0; i < 4; i++) {
              numbers[i] = random.nextInt(9) + 1;
            }
          }
        }
        update();
        count++;
      }
    });
  }

  @override
  void onClose() {
    audioController.stop();
    super.onClose();
  }
}
