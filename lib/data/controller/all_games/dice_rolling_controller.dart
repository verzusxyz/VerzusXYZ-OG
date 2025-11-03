import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:verzusxyz/core/helper/string_format_helper.dart';
import 'package:verzusxyz/core/utils/my_audio.dart';
import 'package:verzusxyz/core/utils/my_images.dart';
import 'package:verzusxyz/core/utils/my_strings.dart';
import 'package:verzusxyz/data/model/dice_rolling_data/dice_rolling_data_model.dart';
import 'package:verzusxyz/data/model/dice_rolling_result/dice_rolling_result_model.dart';
import 'package:verzusxyz/data/model/dice_rollinng_submit_ans/dice_rolling_submit_ans_repo.dart';
import 'package:verzusxyz/data/model/global/response_model/response_model.dart';
import 'package:verzusxyz/data/repo/all-games/dice_rolling/dice_rolling_repo.dart';
import 'package:verzusxyz/view/components/alert-dialog/custom_alert_dialog.dart';
import 'package:verzusxyz/view/components/snack_bar/show_custom_snackbar.dart';
import 'package:verzusxyz/view/screens/all-games/roulette/widget/lose_dialog.dart';
import 'package:verzusxyz/view/screens/all-games/widgets/winner_dialogue.dart';
import 'package:get/get.dart';

class DiceRollingController extends GetxController {
  DiceRollingRepo diceRollingRepo;
  DiceRollingController({required this.diceRollingRepo});
  TextEditingController amountController = TextEditingController();
  var amountFocusNode = FocusNode();

  int selectedDiceIndex = -1;
  bool isLoading = false;
  bool isSubmitted = false;
  String gameId = "";
  String selectedColor = "";
  late Timer dicetimer = Timer(Duration.zero, () {});

  String availAbleBalance = "0";
  String minimumAoumnnt = "0";
  String maxAoumnnt = "0";
  String gameName = "";
  String instruction = "";
  String defaultCurrencySymbol = "0";
  String defaultCurrency = "0";
  String winningPercentage = "0";
  late AudioPlayer audioController;

  Random random = Random();

  int currentImageIndex = 0;
  int counter = 1;
  int? desiredNumber;
  int d = 0;
  double rotationAngle = 1;
  double rotationAngleDiceAngle = 0;

  final List<String> myOptionsImage = [
    MyImages.dice1,
    MyImages.dice2,
    MyImages.dice3,
    MyImages.dice4,
    MyImages.dice5,
    MyImages.dice6,
  ];

  @override
  void onInit() {
    super.onInit();
    audioController = AudioPlayer();
  }

  @override
  void dispose() {
    dicetimer.cancel();
    audioController.stop();
    super.dispose();
  }

  @override
  void onClose() {
    audioController.stop();
    super.onClose();
  }

  void loadGameInfo() async {
    isLoading = true;
    defaultCurrency = diceRollingRepo.apiClient.getCurrencyOrUsername();
    defaultCurrencySymbol = diceRollingRepo.apiClient.getCurrencyOrUsername(
      isSymbol: true,
    );
    update();
    ResponseModel model = await diceRollingRepo.loadData();
    if (model.statusCode == 200) {
      DiceRollingDataModel responseModel = DiceRollingDataModel.fromJson(
        jsonDecode(model.responseJson),
      );

      availAbleBalance = responseModel.data?.userBalance.toString() ?? "";
      if (responseModel.status?.toLowerCase() ==
          MyStrings.success.toLowerCase()) {
        minimumAoumnnt = responseModel.data?.game?.minLimit.toString() ?? "";
        maxAoumnnt = responseModel.data?.game?.maxLimit.toString() ?? "";
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

  submitInvestmentRequest() async {
    isSubmitted = true;
    amountFocusNode.unfocus();
    update();

    ResponseModel model = await diceRollingRepo.submitAnswer(
      amountController.text,
      selectedDiceIndex == 0
          ? 1
          : selectedDiceIndex == 1
          ? 2
          : selectedDiceIndex == 2
          ? 3
          : selectedDiceIndex == 3
          ? 4
          : selectedDiceIndex == 4
          ? 5
          : selectedDiceIndex == 5
          ? 6
          : -1,
    );

    if (model.statusCode == 200) {
      DiceRollingSubmitAnsModel submitAnswer =
          DiceRollingSubmitAnsModel.fromJson(jsonDecode(model.responseJson));

      if (submitAnswer.status?.toLowerCase() ==
          MyStrings.success.toLowerCase()) {
        gameId = submitAnswer.data?.gameLog?.id.toString() ?? "0";
        desiredNumber = int.tryParse(
          submitAnswer.data?.gameLog?.result.toString() ?? "0",
        )!;
        availAbleBalance = Converter.formatNumber(
          submitAnswer.data?.balance ?? "",
        );
        rollDice();
        endTheGame();
      } else {
        CustomSnackBar.error(
          errorList:
              submitAnswer.message?.error ?? [MyStrings.somethingWentWrong.tr],
        );
        isSubmitted = false;
      }
    } else {
      CustomSnackBar.error(errorList: [model.message]);
      isSubmitted = false;
    }

    update();
  }

  endTheGame() async {
    ResponseModel model = await diceRollingRepo.getAnswer(gameId);

    if (model.statusCode == 200) {
      DiceRollingResultModel rouletteAnswerModel =
          DiceRollingResultModel.fromJson(jsonDecode(model.responseJson));

      if (rouletteAnswerModel.status?.toLowerCase() ==
          MyStrings.success.toLowerCase()) {
        update();

        Timer(const Duration(seconds: 8), () {
          isSubmitted = false;
          Timer(const Duration(seconds: 4), () {
            if (rouletteAnswerModel.data?.type != MyStrings.danger) {
              CustomAlertDialog(
                child: WinnerDialog(
                  result: rouletteAnswerModel.data?.result.toString() ?? "0",
                ),
              ).customAlertDialog(Get.context!);
            } else {
              CustomAlertDialog(
                child: LoseDialog(
                  isShowResult: true,
                  result: rouletteAnswerModel.data?.result.toString() ?? "0",
                ),
              ).customAlertDialog(Get.context!);
            }

            availAbleBalance = rouletteAnswerModel.data?.bal.toString() ?? "0";
            resetAll();
            update();
          });
        });
      } else {
        CustomSnackBar.error(errorList: [model.message]);
      }
    }
  }

  resetAll() {
    amountController.text = "";
    selectedDiceIndex = -1;
    update();
    dicetimer.cancel();
  }

  rollDice() {
    audioController.play(AssetSource(MyAudio.diceRollingAudio));
    dicetimer = Timer.periodic(const Duration(milliseconds: 80), (timer) {
      counter++;

      currentImageIndex = random.nextInt(6);

      Timer(const Duration(seconds: 8), () {
        currentImageIndex = desiredNumber! - 1;
        audioController.stop();
      });

      update();

      if (currentImageIndex == desiredNumber! - 1 && !isSubmitted) {
        timer.cancel();
      }
    });
    update();
  }

  void updateIndex(int index) {
    selectedDiceIndex = index;
    dicetimer.cancel();
    update();
  }
}
