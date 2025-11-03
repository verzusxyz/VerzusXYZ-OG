import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:verzusxyz/core/helper/string_format_helper.dart';
import 'package:verzusxyz/core/utils/my_audio.dart';
import 'package:verzusxyz/core/utils/my_images.dart';
import 'package:verzusxyz/core/utils/my_strings.dart';
import 'package:verzusxyz/data/model/dice_rolling_result/dice_rolling_result_model.dart';
import 'package:verzusxyz/data/model/global/response_model/response_model.dart';
import 'package:verzusxyz/data/model/pool_number/pool_number_data.dart';
import 'package:verzusxyz/data/model/pool_number_submit_ans/pool_number_submit_ans.dart';
import 'package:verzusxyz/data/repo/all-games/pool_number/pool_number_repo.dart';
import 'package:verzusxyz/view/components/alert-dialog/custom_alert_dialog.dart';
import 'package:verzusxyz/view/components/snack_bar/show_custom_snackbar.dart';
import 'package:verzusxyz/view/screens/all-games/roulette/widget/lose_dialog.dart';
import 'package:verzusxyz/view/screens/all-games/widgets/winner_dialogue.dart';
import 'package:get/get.dart';

class PoolNumberController extends GetxController {
  PoolNumberRepo poolNumberRepo;
  PoolNumberController({required this.poolNumberRepo});
  TextEditingController amountController = TextEditingController();

  var amountFocusNode = FocusNode();

  int adminNumber = 6;
  int selectedDiceIndex = -1;
  bool isLoading = false;
  bool isSubmitted = false;

  String availAbleBalance = "0.00";
  String minimumAoumnnt = "0.00";
  String maxAoumnnt = "0.00";
  String gameName = "";
  String instruction = "";
  String winningPercentage = "0";
  String defaultCurrencySymbol = "0";
  String defaultCurrency = "0";
  bool showResult = false;

  Random random = Random();
  int currentImageIndex = 0;
  int counter = 1;
  var desiredNumber;
  int? d = 0;
  double rotationAngle = 1;

  late AudioPlayer audioController;

  @override
  void onInit() {
    super.onInit();
    audioController = AudioPlayer();
  }

  final List<String> myOptionsImage = [
    MyImages.pool1,
    MyImages.pool2,
    MyImages.pool3,
    MyImages.pool4,
    MyImages.pool5,
    MyImages.pool6,
    MyImages.pool7,
    MyImages.pool8,
  ];

  void loadGameInfo() async {
    isLoading = true;
    loadData();
    update();
    ResponseModel model = await poolNumberRepo.loadData();
    if (model.statusCode == 200) {
      PoolNumberDataModel responseModel = PoolNumberDataModel.fromJson(
        jsonDecode(model.responseJson),
      );
      availAbleBalance = responseModel.data?.userBalance.toString() ?? "0";
      if (responseModel.status?.toLowerCase() ==
          MyStrings.success.toLowerCase()) {
        audioController.play(AssetSource(MyAudio.poolNumberAudio));
        minimumAoumnnt = responseModel.data?.game?.minLimit.toString() ?? "0";
        maxAoumnnt = responseModel.data?.game?.maxLimit.toString() ?? "0";
        gameName = responseModel.data?.game?.name.toString() ?? "0";
        instruction = responseModel.data?.game?.instruction.toString() ?? "0";
        // we have to add 100 if investback are enable
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

  submitInvestmentRequest() async {
    isSubmitted = true;
    amountFocusNode.unfocus();

    update();

    ResponseModel model = await poolNumberRepo.submitAnswer(
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
          : selectedDiceIndex == 6
          ? 7
          : selectedDiceIndex == 7
          ? 8
          : -1,
    );

    if (model.statusCode == 200) {
      PoolNumbeSubmitAnsModel submitAnswer = PoolNumbeSubmitAnsModel.fromJson(
        jsonDecode(model.responseJson),
      );

      if (submitAnswer.status?.toLowerCase() ==
          MyStrings.success.toLowerCase()) {
        availAbleBalance = Converter.formatNumber(
          submitAnswer.data?.balance ?? "",
        );
        gameId = submitAnswer.data?.gameLog?.id.toString() ?? "0";
        audioController.play(AssetSource(MyAudio.poolNumberAudio));
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
    isSubmitted = false;
    update();
  }

  endTheGame() async {
    ResponseModel model = await poolNumberRepo.getAnswer(gameId);

    if (model.statusCode == 200) {
      DiceRollingResultModel diceRollingResultModel =
          DiceRollingResultModel.fromJson(jsonDecode(model.responseJson));

      if (diceRollingResultModel.status?.toLowerCase() ==
          MyStrings.success.toLowerCase()) {
        update();
        Timer(const Duration(seconds: 2), () {
          d = int.tryParse(
            diceRollingResultModel.data?.result.toString() ?? "0",
          );
          audioController.stop();
          showResult = true;
          isSubmitted = false;

          update();
        });
        Timer(const Duration(seconds: 5), () {
          if (diceRollingResultModel.data != null &&
              diceRollingResultModel.data!.type != MyStrings.danger) {
            CustomAlertDialog(
              child: WinnerDialog(
                result: diceRollingResultModel.data?.result.toString() ?? "0",
              ),
            ).customAlertDialog(Get.context!);
          } else {
            CustomAlertDialog(
              child: LoseDialog(
                isShowResult: true,
                result: diceRollingResultModel.data?.result.toString() ?? "0",
              ),
            ).customAlertDialog(Get.context!);
          }

          resetAll();
          availAbleBalance = diceRollingResultModel.data?.bal.toString() ?? "";
          update();
        });
      }
    } else {
      CustomSnackBar.error(errorList: [model.message]);
    }
  }

  Future<void> loadData() async {
    defaultCurrency = poolNumberRepo.apiClient.getCurrencyOrUsername();
    defaultCurrencySymbol = poolNumberRepo.apiClient.getCurrencyOrUsername(
      isSymbol: true,
    );
  }

  resetAll() {
    amountController.text = "";
    showResult = false;
    selectedDiceIndex = -1;
  }

  void updateSelectedIndex(int index) {
    selectedDiceIndex = index;
    update();
  }

  @override
  void onClose() {
    audioController.stop();
    super.onClose();
  }

  @override
  void dispose() {
    audioController.stop();

    super.dispose();
  }
}
