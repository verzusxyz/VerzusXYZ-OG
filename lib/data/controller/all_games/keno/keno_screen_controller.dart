import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:verzusxyz/core/helper/string_format_helper.dart';
import 'package:verzusxyz/core/utils/my_audio.dart';
import 'package:verzusxyz/core/utils/my_strings.dart';
import 'package:verzusxyz/data/model/global/response_model/response_model.dart';
import 'package:verzusxyz/data/model/keno_data/keno_data_model.dart';
import 'package:verzusxyz/data/model/keno_data/keno_number_model.dart';
import 'package:verzusxyz/data/model/keno_result/keno_result_model.dart';
import 'package:verzusxyz/data/model/keno_submit_ans/keno_submit_ans_model.dart';
import 'package:verzusxyz/data/repo/all-games/keno/keno_repo.dart';
import 'package:verzusxyz/view/components/alert-dialog/custom_alert_dialog.dart';
import 'package:verzusxyz/view/components/snack_bar/show_custom_snackbar.dart';
import 'package:verzusxyz/view/screens/all-games/roulette/widget/lose_dialog.dart';
import 'package:verzusxyz/view/screens/all-games/widgets/winner_dialogue.dart';
import 'package:get/get.dart';

class KenoScreenController extends GetxController {
  KenoRepo kenoRepo;
  KenoScreenController({required this.kenoRepo});
  List<int> selectedNumbers = [];

  bool zeroModelIsZeroSelected = false;
  final StreamController<int> fortuneWheelNotifier = StreamController<int>();

  bool limitOver = false;

  TextEditingController amountController = TextEditingController();

  var amountFocusNode = FocusNode();

  String selectedNumber = '';
  late AnimationController animationController;

  List<String> name = [];
  String currencySym = "";
  bool isLoading = false;
  bool isSubmitted = false;
  bool isWinner = false;
  String spinLogId = "-1";
  int selectedIndex = -1;
  bool isSpinningValue = false;
  late AudioPlayer audioController;
  var bets = [];
  var gameStatus = "none";
  double winningAmount = 0.0;
  double betAmount = 0.0;
  int totalBets = 0;
  var adminSelectedNum;

  int adminSelectedIndex = 0;
  int spinResult = 0;

  @override
  void onInit() {
    super.onInit();
    audioController = AudioPlayer();
  }

  void setIsSpinning(bool isSpinning) {
    isSpinningValue = isSpinning;

    update();
  }

  List<int> adminSelectedNumbers = [];
  List<int> matchedNumbers = [];

  List<KenoNumberModel> kenoNumbers = List.generate(
    80,
    (index) => KenoNumberModel(
      number: index + 1,
      isSelected: false,
      isFromAdmin: false,
    ),
  );

  int get selectedCount {
    return kenoNumbers.where((number) => number.isSelected).length;
  }

  void printSelectedNumbers() {
    selectedNumbers.clear();

    for (int i = 0; i < kenoNumbers.length; i++) {
      if (kenoNumbers[i].isSelected) {
        selectedNumbers.add(kenoNumbers[i].number);
      }
    }
  }

  void selectRandomNumbers() {
    final random = Random();

    // Clear selectedNumbers list
    selectedNumbers.clear();

    // Clear isSelected flag for all kenoNumbers
    for (int i = 0; i < kenoNumbers.length; i++) {
      kenoNumbers[i].isSelected = false;
    }

    // Select 10 random numbers
    while (selectedNumbers.length < 10) {
      final randomNumber = random.nextInt(80) + 1;
      if (!selectedNumbers.contains(randomNumber)) {
        selectedNumbers.add(randomNumber);
      }
    }

    // Mark isSelected as true for the randomly selected numbers
    for (final number in selectedNumbers) {
      final index = number - 1; // Adjust index as numbers start from 1
      kenoNumbers[index].isSelected = true;
    }

    amountFocusNode.unfocus();
    update();
  }

  void resetAllSelection() {
    for (var kenoNumber in kenoNumbers) {
      kenoNumber.isSelected = false;
      kenoNumber.isFromAdmin = false;
    }
    selectedNumbers.clear();

    update();
  }

  String availAbleBalance = "0.00";
  String minimumAoumnnt = "0.00";
  String maxAoumnnt = "0.00";
  String gameName = "";
  String instruction = "";
  String defaultCurrency = "";

  List<LevelElement> gameLavels = [];

  void loadGameInfo() async {
    isLoading = true;
    defaultCurrency = kenoRepo.apiClient.getCurrencyOrUsername();
    currencySym = kenoRepo.apiClient.getCurrencyOrUsername(isSymbol: true);
    update();
    ResponseModel model = await kenoRepo.loadData();
    if (model.statusCode == 200) {
      KenoDataModel responseModel = KenoDataModel.fromJson(
        jsonDecode(model.responseJson),
      );
      if (responseModel.status?.toLowerCase() ==
          MyStrings.success.toLowerCase()) {
        gameName = responseModel.data?.game?.name.toString() ?? "";
        availAbleBalance = responseModel.data?.userBalance.toString() ?? "";
        minimumAoumnnt = responseModel.data?.game?.minLimit.toString() ?? "";
        maxAoumnnt = responseModel.data?.game?.maxLimit.toString() ?? "";
        instruction = responseModel.data?.game?.instruction.toString() ?? "";
        gameLavels.addAll(responseModel.data?.game?.level?.levels ?? []);
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
    amountFocusNode.unfocus();
    update();

    List<String> selectedNumbersAsString = selectedNumbers
        .map((number) => "$number")
        .toList();
    ResponseModel model = await kenoRepo.submitAnswer(
      amountController.text,
      selectedNumbersAsString,
    );

    if (model.statusCode == 200) {
      KenoSubmitAnsModel submitAnswer = KenoSubmitAnsModel.fromJson(
        jsonDecode(model.responseJson),
      );
      audioController.play(AssetSource(MyAudio.kenoAudio));
      if (submitAnswer.status?.toLowerCase() ==
          MyStrings.success.toLowerCase()) {
        availAbleBalance = submitAnswer.data?.balance ?? "";
        gameId = submitAnswer.data?.gameLog?.id.toString() ?? "";
        endTheGame();
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

  endTheGame() async {
    matchedNumbers.clear();
    isSubmitted = true;
    adminSelectedNumbers.clear();
    update();

    ResponseModel model = await kenoRepo.getAnswer(gameId);

    if (model.statusCode == 200) {
      KenoResultModel kenoResultModel = KenoResultModel.fromJson(
        jsonDecode(model.responseJson),
      );

      if (kenoResultModel.status?.toLowerCase() ==
          MyStrings.success.toLowerCase()) {
        adminSelectedNum = kenoResultModel.data!.result;

        adminSelectedNumbers.addAll(
          kenoResultModel.data!.result!.map(
            (stringNumber) => int.parse(stringNumber),
          ),
        );

        checkMatchAndSetFlags();

        Timer(const Duration(seconds: 3), () {
          availAbleBalance = kenoResultModel.data?.balance.toString() ?? "0";
          audioController.stop();
          if (kenoResultModel.data!.win == "1") {
            CustomAlertDialog(
              child: WinnerDialog(
                result: adminSelectedNumbers.toString(),
                adminSelectedNumber: matchedNumbers.length.toString(),
                iskenoResult: true,
              ),
            ).customAlertDialog(Get.context!);

            update();
          } else {
            CustomAlertDialog(
              child: LoseDialog(
                isShowResult: true,
                result: adminSelectedNumbers.toString(),
                adminSelectedNumber: matchedNumbers.length.toString(),
                iskenoResult: true,
              ),
            ).customAlertDialog(Get.context!);
            isWinner == false;
            update();
          }
          resetAll();
        });
      } else {
        CustomSnackBar.error(
          errorList:
              kenoResultModel.message?.success ??
              [MyStrings.somethingWentWrong.tr],
        );
      }
    } else {
      CustomSnackBar.error(errorList: [model.message]);
    }

    isSubmitted = false;
    update();
  }

  resetAll() {
    resetAllSelection();
    amountController.text = "";
  }

  void checkMatchAndSetFlags() {
    for (var i = 0; i < 80; i++) {
      var numberModel = kenoNumbers[i];
      if (selectedNumbers.contains(numberModel.number) &&
          adminSelectedNumbers.contains(numberModel.number)) {
        numberModel.isFromAdmin = true;
        numberModel.isSelected = false;
        matchedNumbers.add(numberModel.number);
      }
    }

    update();
  }

  @override
  void onClose() {
    audioController.stop();
    super.onClose();
  }
}
