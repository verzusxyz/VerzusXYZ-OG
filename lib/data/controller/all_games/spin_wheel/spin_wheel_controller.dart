import 'dart:async';
import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:verzusxyz/core/helper/string_format_helper.dart';
import 'package:verzusxyz/core/utils/my_audio.dart';
import 'package:verzusxyz/core/utils/my_strings.dart';
import 'package:verzusxyz/data/model/global/response_model/response_model.dart';
import 'package:verzusxyz/data/model/spin_wheel/spin_wheel_data_model.dart';
import 'package:verzusxyz/data/model/spin_wheel_result/spin_wheel_result_model.dart';
import 'package:verzusxyz/data/model/spin_wheel_submit_ans/spin_wheel_submit_ans_model.dart';
import 'package:verzusxyz/data/repo/all-games/spin_wheel/spin_wheel_repo.dart';
import 'package:verzusxyz/view/components/alert-dialog/custom_alert_dialog.dart';
import 'package:verzusxyz/view/components/snack_bar/show_custom_snackbar.dart';
import 'package:verzusxyz/view/screens/all-games/roulette/widget/lose_dialog.dart';
import 'package:verzusxyz/view/screens/all-games/widgets/winner_dialogue.dart';
import 'package:get/get.dart';

class SpinWheelControllers extends GetxController {
  SpinWheelRepo spinWheelRepo;
  SpinWheelControllers({required this.spinWheelRepo});

  final StreamController<int> fortuneWheelNotifier = StreamController<int>();

  TextEditingController amountController = TextEditingController();
  var amountFocusNode = FocusNode();

  List<String> name = [];
  String currencySym = "";
  int rotationCount = 100;
  int roatationDuration = 0;
  bool isLoading = false;
  bool isSubmitted = false;
  bool isBlue = false;
  bool isRed = false;
  String availAbleBalance = "0.00";
  String minimumAoumnnt = "0.00";
  String maxAoumnnt = "0.00";
  String gameName = "";
  String instruction = "";
  String defaultCurrencySymbol = "0";
  String defaultCurrency = "0";
  String winningPercentage = "0";
  bool isSpinningValue = false;

  bool limitOver = false;
  late AudioPlayer audioController;

  @override
  void onInit() {
    super.onInit();
    audioController = AudioPlayer();
  }

  bool changeSelection() {
    isBlue = !isBlue;
    update();
    return isBlue;
  }

  String? adminSelectedColor = "";

  int adminSelectedIndex = 0;
  int spinResult = 0;

  void initData() async {
    isLoading = true;
    update();
    getSpinData();
    await loadGameInfo();

    isLoading = false;
    update();
  }

  Future<void> getSpinData() async {
    name.clear();
    name.addAll([
      "red",
      "blue",
      "red",
      "blue",
      "red",
      "blue",
      "red",
      "blue",
      "red",
      "blue",
      "red",
      "blue",
      "red",
      "blue",
      "red",
      "blue",
    ]);
  }

  void setIsSpinning(bool isSpinning) {
    isSpinningValue = isSpinning;
    update();
  }

  Future<void> loadGameInfo() async {
    defaultCurrency = spinWheelRepo.apiClient.getCurrencyOrUsername();
    defaultCurrencySymbol = spinWheelRepo.apiClient.getCurrencyOrUsername(
      isSymbol: true,
    );
    update();
    ResponseModel model = await spinWheelRepo.loadData();
    if (model.statusCode == 200) {
      SpinWheelDataModel responseModel = SpinWheelDataModel.fromJson(
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
      isSubmitted = false;
    }
    update();
  }

  String gameId = "";

  String spinWheelResult = "";
  String selectedColor = "";

  submitInvestmentRequest() async {
    isSubmitted = true;
    amountFocusNode.unfocus();
    update();

    ResponseModel model = await spinWheelRepo.submitAnswer(
      amountController.text,
      isBlue ? "blue" : "red",
    );

    if (model.statusCode == 200) {
      SpinWheelSubmitAnsModel submitAnswer = SpinWheelSubmitAnsModel.fromJson(
        jsonDecode(model.responseJson),
      );
      if (submitAnswer.status?.toLowerCase() ==
          MyStrings.success.toLowerCase()) {
        gameId = submitAnswer.data?.gameLog?.id.toString() ?? "";
        spinWheelResult = submitAnswer.data?.result ?? "";
        availAbleBalance = Converter.formatNumber(
          submitAnswer.data?.balance ?? "",
        );
        update();
        endTheGame();
        play();
        update();
      } else {
        CustomSnackBar.error(
          errorList:
              submitAnswer.message?.error ?? [MyStrings.somethingWentWrong.tr],
        );
      }
    } else {
      CustomSnackBar.error(errorList: [model.message]);
    }
  }

  endTheGame() async {
    ResponseModel model = await spinWheelRepo.getAnswer(gameId);

    if (model.statusCode == 200) {
      SpinWheelResultModel rouletteAnswerModel = SpinWheelResultModel.fromJson(
        jsonDecode(model.responseJson),
      );

      if (rouletteAnswerModel.status?.toLowerCase() ==
          MyStrings.success.toLowerCase()) {
        Timer(Duration(seconds: roatationDuration), () {
          if (rouletteAnswerModel.data!.type != MyStrings.danger) {
            CustomAlertDialog(
              child: WinnerDialog(
                result: rouletteAnswerModel.data?.result.toString() ?? "",
              ),
            ).customAlertDialog(Get.context!);
          } else {
            CustomAlertDialog(
              child: LoseDialog(
                isShowResult: true,
                result: rouletteAnswerModel.data?.result.toString() ?? "",
              ),
            ).customAlertDialog(Get.context!);
          }
          isSubmitted = false;
          availAbleBalance = rouletteAnswerModel.data?.bal.toString() ?? "";
          resetAll();
          update();
        });

        isSubmitted = false;
        update();
      }
    } else {
      CustomSnackBar.error(errorList: [model.message]);
    }
  }

  play() {
    roatationDuration = 10;
    fortuneWheelNotifier.add(spinWheelResult == "red" ? 0 : 1);
    audioController.play(AssetSource(MyAudio.spinWheelAudio));
    Timer(Duration(seconds: roatationDuration), () {
      setIsSpinning(false);
      audioController.stop();
    });
    update();
  }

  resetAll() {
    amountController.text = "";
    isBlue = false;
    isRed = false;
  }

  @override
  void dispose() {
    fortuneWheelNotifier.close();
    audioController.stop();
    super.dispose();
  }

  @override
  void onClose() {
    audioController.stop();
    super.onClose();
  }
}
