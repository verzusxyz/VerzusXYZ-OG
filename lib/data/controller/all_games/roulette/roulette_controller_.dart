import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:verzusxyz/core/helper/string_format_helper.dart';
import 'package:verzusxyz/core/utils/my_audio.dart';
import 'package:verzusxyz/core/utils/my_color.dart';
import 'package:verzusxyz/core/utils/my_strings.dart';
import 'package:verzusxyz/data/model/global/response_model/response_model.dart';
import 'package:verzusxyz/data/model/roulette/roulete_number_model.dart';
import 'package:verzusxyz/data/model/roulette/roulette_data.dart';
import 'package:verzusxyz/data/model/roulette_submit_ans/submit_answer_model.dart';
import 'package:verzusxyz/data/model/rouletter_ans/roulette_ans_model.dart';
import 'package:verzusxyz/data/repo/all-games/roulete/roulette_repo.dart';
import 'package:verzusxyz/view/components/alert-dialog/custom_alert_dialog.dart';
import 'package:verzusxyz/view/components/snack_bar/show_custom_snackbar.dart';
import 'package:verzusxyz/view/screens/all-games/roulette/widget/lose_dialog.dart';
import 'package:verzusxyz/view/screens/all-games/widgets/winner_dialogue.dart';
import 'package:get/get.dart';

class RouletteControllers extends GetxController {
  RouletteRepo rouletteRepo;
  RouletteControllers({required this.rouletteRepo});
  List<int> selectedNumbers = [];

  bool zeroModelIsZeroSelected = false;
  StreamController<int> fortuneWheelNotifier = StreamController<int>();

  bool limitOver = false;
  bool isSubmitted = false;

  TextEditingController amountController = TextEditingController();

  var amountFocusNode = FocusNode();

  String selectedNumber = '';
  late AnimationController animationController;

  List<String> name = [];
  String gameName = "";
  String instruction = "";
  String currencySym = "";
  String defaultCurrency = "";
  int rotationCount = 100;
  int roatationDuration = 0;
  bool isLoading = false;
  bool isWinner = false;
  String spinLogId = "-1";
  String winningPercentage = "";
  int selectedIndex = -1;
  bool isSpinningValue = false;
  bool isBetValueSelected = false;

  var bets = [];
  var gameStatus = "none";
  double winningAmount = 0.0;
  double betAmount = 0.0;
  int totalBets = 0;

  late AudioPlayer audioController;

  @override
  void onInit() {
    super.onInit();
    audioController = AudioPlayer();
    // Ensure only one listener per StreamController
    // if (fortuneWheelNotifier.isClosed) {
    //   fortuneWheelNotifier = StreamController<int>.broadcast();
    // }
  }

  countWinningAmount() {
    totalBets = 0;
    winningAmount = 0;
    update();
    int totalNumberSelected = selectedNumbers.length;

    betAmount = 36 / totalNumberSelected;
    double formattedInvestAmount =
        double.tryParse(amountController.text) ?? 0.0;
    winningAmount = formattedInvestAmount * betAmount;
  }

  var adminSelectedNum;

  int adminSelectedIndex = 0;
  int spinResult = 0;

  Future<void> getSpinData() async {
    name.clear();
    isLoading = true;
    update();
    name.addAll([
      "0",
      "32",
      "15",
      '19',
      ' 4',
      '21',
      '2',
      '25',
      '17',
      ' 34',
      '6',
      ' 27',
      '13',
      '36',
      '11',
      '30',
      '8',
      ' 23',
      '10',
      '5',
      '24',
      '16',
      '33',
      ' 1',
      '20',
      ' 14',
      '31',
      ' 9',
      '22',
      '18',
      '29',
      ' 7',
      ' 28',
      '12',
      ' 35',
      '3',
      '26',
    ]);

    isLoading = false;
    update();
  }

  void setIsSpinning(bool isSpinning) {
    isSpinningValue = isSpinning;

    update();
  }

  List<RouletteNumberModel> rouleteNumberList = [
    RouletteNumberModel(
      number: 3,
      isBlack: false,
      isEven: true,
      isSelected: false,
      rowNumber: 1,
    ),
    RouletteNumberModel(
      number: 6,
      isBlack: true,
      isEven: false,
      isSelected: false,
      rowNumber: 1,
    ),
    RouletteNumberModel(
      number: 9,
      isBlack: false,
      isEven: true,
      isSelected: false,
      rowNumber: 1,
    ),
    RouletteNumberModel(
      number: 12,
      isBlack: false,
      isEven: false,
      isSelected: false,
      rowNumber: 1,
    ),
    RouletteNumberModel(
      number: 15,
      isBlack: true,
      isEven: true,
      isSelected: false,
      rowNumber: 1,
    ),
    RouletteNumberModel(
      number: 18,
      isBlack: false,
      isEven: false,
      isSelected: false,
      rowNumber: 1,
    ),
    RouletteNumberModel(
      number: 21,
      isBlack: false,
      isEven: true,
      isSelected: false,
      rowNumber: 1,
    ),
    RouletteNumberModel(
      number: 24,
      isBlack: true,
      isEven: false,
      isSelected: false,
      rowNumber: 1,
    ),
    RouletteNumberModel(
      number: 27,
      isBlack: false,
      isEven: true,
      isSelected: false,
      rowNumber: 1,
    ),
    RouletteNumberModel(
      number: 30,
      isBlack: false,
      isEven: false,
      isSelected: false,
      rowNumber: 1,
    ),
    RouletteNumberModel(
      number: 33,
      isBlack: true,
      isEven: true,
      isSelected: false,
      rowNumber: 1,
    ),
    RouletteNumberModel(
      number: 36,
      isBlack: false,
      isEven: false,
      isSelected: false,
      rowNumber: 1,
    ),
    RouletteNumberModel(
      number: 00,
      isBlack: false,
      isEven: false,
      isSelected: false,
      rowNumber: 1,
      isTwoRationOne: true,
    ),

    // RouletteNumberModel(number: -1, isBlack: false, isEven: false, isSelected: false, rowNumber: 1),
    RouletteNumberModel(
      number: 2,
      isBlack: true,
      isEven: false,
      isSelected: false,
      rowNumber: 2,
    ),
    RouletteNumberModel(
      number: 5,
      isBlack: false,
      isEven: true,
      isSelected: false,
      rowNumber: 2,
    ),
    RouletteNumberModel(
      number: 8,
      isBlack: true,
      isEven: false,
      isSelected: false,
      rowNumber: 2,
    ),
    RouletteNumberModel(
      number: 11,
      isBlack: true,
      isEven: true,
      isSelected: false,
      rowNumber: 2,
    ),
    RouletteNumberModel(
      number: 14,
      isBlack: false,
      isEven: false,
      isSelected: false,
      rowNumber: 2,
    ),
    RouletteNumberModel(
      number: 17,
      isBlack: true,
      isEven: true,
      isSelected: false,
      rowNumber: 2,
    ),
    RouletteNumberModel(
      number: 20,
      isBlack: true,
      isEven: false,
      isSelected: false,
      rowNumber: 2,
    ),
    RouletteNumberModel(
      number: 23,
      isBlack: false,
      isEven: true,
      isSelected: false,
      rowNumber: 2,
    ),
    RouletteNumberModel(
      number: 26,
      isBlack: true,
      isEven: false,
      isSelected: false,
      rowNumber: 2,
    ),
    RouletteNumberModel(
      number: 29,
      isBlack: true,
      isEven: true,
      isSelected: false,
      rowNumber: 2,
    ),
    RouletteNumberModel(
      number: 32,
      isBlack: false,
      isEven: false,
      isSelected: false,
      rowNumber: 2,
    ),
    RouletteNumberModel(
      number: 35,
      isBlack: true,
      isEven: true,
      isSelected: false,
      rowNumber: 2,
    ),
    RouletteNumberModel(
      number: 00,
      isBlack: false,
      isEven: false,
      isSelected: false,
      rowNumber: 2,
      isTwoRationOne: true,
    ),

    RouletteNumberModel(
      number: 1,
      isBlack: false,
      isEven: true,
      isSelected: false,
      rowNumber: 3,
    ),
    RouletteNumberModel(
      number: 4,
      isBlack: true,
      isEven: false,
      isSelected: false,
      rowNumber: 3,
    ),
    RouletteNumberModel(
      number: 7,
      isBlack: false,
      isEven: true,
      isSelected: false,
      rowNumber: 3,
    ),
    RouletteNumberModel(
      number: 10,
      isBlack: true,
      isEven: false,
      isSelected: false,
      rowNumber: 3,
    ),
    RouletteNumberModel(
      number: 13,
      isBlack: true,
      isEven: true,
      isSelected: false,
      rowNumber: 3,
    ),
    RouletteNumberModel(
      number: 16,
      isBlack: false,
      isEven: false,
      isSelected: false,
      rowNumber: 3,
    ),
    RouletteNumberModel(
      number: 19,
      isBlack: false,
      isEven: true,
      isSelected: false,
      rowNumber: 3,
    ),
    RouletteNumberModel(
      number: 22,
      isBlack: true,
      isEven: false,
      isSelected: false,
      rowNumber: 3,
    ),
    RouletteNumberModel(
      number: 25,
      isBlack: false,
      isEven: true,
      isSelected: false,
      rowNumber: 3,
    ),
    RouletteNumberModel(
      number: 28,
      isBlack: true,
      isEven: false,
      isSelected: false,
      rowNumber: 3,
    ),
    RouletteNumberModel(
      number: 31,
      isBlack: true,
      isEven: true,
      isSelected: false,
      rowNumber: 3,
    ),
    RouletteNumberModel(
      number: 34,
      isBlack: false,
      isEven: false,
      isSelected: false,
      rowNumber: 3,
    ),
    RouletteNumberModel(
      number: 00,
      isBlack: false,
      isEven: false,
      isSelected: false,
      rowNumber: 3,
      isTwoRationOne: true,
    ),
  ];

  void selectBet({
    int index = 0,
    bool isZeroSelected = false,
    bool is2RatioOne = false,
    isEven = false,
    bool isOdd = false,
    bool isRed = false,
    bool isBlack = false,
    bool is1To18 = false,
    bool is19To36 = false,
    bool is1To12 = false,
    bool is13To24 = false,
    bool is25To36 = false,
  }) {
    amountFocusNode.unfocus();
    selectedNumbers.clear();
    update();
    if (isZeroSelected) {
      zeroModelIsZeroSelected = isZeroSelected;
      selectedNumbers.add(0);
      for (int i = 0; i < rouleteNumberList.length; i++) {
        rouleteNumberList[i].isSelected = false;
      }
      return;
    } else {
      zeroModelIsZeroSelected = false;
    }

    if (is2RatioOne) {
      int rowNumber = rouleteNumberList[index].rowNumber;
      for (int i = 0; i < rouleteNumberList.length; i++) {
        if (rouleteNumberList[i].rowNumber == rowNumber) {
          rouleteNumberList[i].isSelected = true;
        } else {
          rouleteNumberList[i].isSelected = false;
        }
      }
    } else if (isEven) {
      for (int i = 0; i < rouleteNumberList.length; i++) {
        if (rouleteNumberList[i].isEven) {
          rouleteNumberList[i].isSelected = true;
        } else {
          rouleteNumberList[i].isSelected = false;
        }
      }
    } else if (isOdd) {
      for (int i = 0; i < rouleteNumberList.length; i++) {
        if (!rouleteNumberList[i].isEven) {
          rouleteNumberList[i].isSelected = true;
        } else {
          rouleteNumberList[i].isSelected = false;
        }
      }
    } else if (isRed) {
      for (int i = 0; i < rouleteNumberList.length; i++) {
        if (!rouleteNumberList[i].isBlack) {
          rouleteNumberList[i].isSelected = true;
        } else {
          rouleteNumberList[i].isSelected = false;
        }
      }
    } else if (isBlack) {
      for (int i = 0; i < rouleteNumberList.length; i++) {
        if (rouleteNumberList[i].isBlack) {
          rouleteNumberList[i].isSelected = true;
        } else {
          rouleteNumberList[i].isSelected = false;
        }
      }
    } else if (is1To18) {
      for (int i = 0; i < rouleteNumberList.length; i++) {
        int number = rouleteNumberList[i].number;
        if (number > 0 && number <= 18) {
          rouleteNumberList[i].isSelected = true;
        } else {
          rouleteNumberList[i].isSelected = false;
        }
      }
    } else if (is19To36) {
      for (int i = 0; i < rouleteNumberList.length; i++) {
        int number = rouleteNumberList[i].number;
        if (number >= 19 && number <= 36) {
          rouleteNumberList[i].isSelected = true;
        } else {
          rouleteNumberList[i].isSelected = false;
        }
      }
    } else if (is1To12) {
      for (int i = 0; i < rouleteNumberList.length; i++) {
        int number = rouleteNumberList[i].number;
        if (number > 0 && number <= 12) {
          rouleteNumberList[i].isSelected = true;
        } else {
          rouleteNumberList[i].isSelected = false;
        }
      }
    } else if (is13To24) {
      for (int i = 0; i < rouleteNumberList.length; i++) {
        int number = rouleteNumberList[i].number;
        if (number > 12 && number <= 24) {
          rouleteNumberList[i].isSelected = true;
        } else {
          rouleteNumberList[i].isSelected = false;
        }
      }
    } else if (is25To36) {
      for (int i = 0; i < rouleteNumberList.length; i++) {
        int number = rouleteNumberList[i].number;
        if (number >= 25 && number <= 36) {
          rouleteNumberList[i].isSelected = true;
        } else {
          rouleteNumberList[i].isSelected = false;
        }
      }
    } else {
      for (int i = 0; i < rouleteNumberList.length; i++) {
        if (i == index) {
          rouleteNumberList[i].isSelected = true;
        } else {
          rouleteNumberList[i].isSelected = false;
        }
      }
    }

    if (is2RatioOne) {
      for (int i = 0; i < rouleteNumberList.length; i++) {
        if (rouleteNumberList[i].isSelected &&
            !rouleteNumberList[i].isTwoRationOne) {
          selectedNumbers.add(rouleteNumberList[i].number);
        }
      }
    } else {
      for (int i = 0; i < rouleteNumberList.length; i++) {
        if (rouleteNumberList[i].isSelected &&
            !rouleteNumberList[i].isTwoRationOne) {
          selectedNumbers.add(rouleteNumberList[i].number);
        }
      }
    }

    update();
  }

  getBgColor({int index = -1, bool is2Ratio1 = false, bool isZero = false}) {
    late Color myColor;
    if (isZero) {
      myColor = zeroModelIsZeroSelected
          ? MyColor.colorSelected
          : MyColor.colorBgCard;
    } else {
      myColor = is2Ratio1
          ? MyColor.colorBgCard
          : rouleteNumberList[index].isSelected ||
                (isZero && zeroModelIsZeroSelected)
          ? MyColor.colorSelected
          : isZero
          ? MyColor.colorBgCard
          : rouleteNumberList[index].isBlack
          ? MyColor.colorDarkBlack
          : MyColor.colorDarkRed;
    }
    return myColor;
  }

  bool is1to12 = false;

  String availAbleBalance = "0";
  String minimumAoumnnt = "0";
  String maxAoumnnt = "0";
  void loadGameInfo() async {
    defaultCurrency = rouletteRepo.apiClient.getCurrencyOrUsername();
    currencySym = rouletteRepo.apiClient.getCurrencyOrUsername(isSymbol: true);
    ResponseModel model = await rouletteRepo.loadData();
    if (model.statusCode == 200) {
      RouletteDataModel responseModel = RouletteDataModel.fromJson(
        jsonDecode(model.responseJson),
      );
      if (responseModel.status?.toLowerCase() ==
          MyStrings.success.toLowerCase()) {
        availAbleBalance = responseModel.data?.userBalance.toString() ?? "";
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
    update();
  }

  String gameId = "";

  submitInvestmentRequest() async {
    isSubmitted = true;
    amountFocusNode.unfocus();
    update();

    ResponseModel model = await rouletteRepo.submitAnswer(
      amountController.text,
      selectedNumbers.toString(),
    );

    if (model.statusCode == 200) {
      SubmitAnswerModel submitAnswer = SubmitAnswerModel.fromJson(
        jsonDecode(model.responseJson),
      );

      if (submitAnswer.status?.toLowerCase() ==
          MyStrings.success.toLowerCase()) {
        gameId = submitAnswer.data!.gameLog!.id.toString();
        availAbleBalance = Converter.formatNumber(
          submitAnswer.data?.balance ?? "",
        );
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
    ResponseModel model = await rouletteRepo.getAnswer(gameId);

    if (model.statusCode == 200) {
      RouletteAnswerModel rouletteAnswerModel = RouletteAnswerModel.fromJson(
        jsonDecode(model.responseJson),
      );

      if (rouletteAnswerModel.status?.toLowerCase() ==
          MyStrings.success.toLowerCase()) {
        adminSelectedNum = rouletteAnswerModel.data?.result;

        int index = name.indexOf(adminSelectedNum.toString());

        if (index != -1) {
          adminSelectedIndex = index;
          play();

          Timer(const Duration(seconds: 13), () {
            if (rouletteAnswerModel.data!.type != MyStrings.danger) {
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
            isSubmitted = false;
            availAbleBalance = rouletteAnswerModel.data?.balance ?? "";
            resetAll();
            update();
          });
        }

        isLoading = false;
        update();
      }
    } else {
      CustomSnackBar.error(errorList: [model.message]);
    }
  }

  void resetSelection(List<RouletteNumberModel> list) {
    zeroModelIsZeroSelected = false;
    for (var item in list) {
      item.isSelected = false;
    }
  }

  play() {
    roatationDuration = 10;
    audioController.play(AssetSource(MyAudio.spinWheelAudio));
    Random().nextInt(name.length);

    fortuneWheelNotifier.add(adminSelectedIndex);
    Timer(Duration(seconds: roatationDuration), () {
      audioController.stop();
    });
    update();
  }

  resetAll() {
    isBetValueSelected = false;
    amountController.text = "";
    resetSelection(rouleteNumberList);
    countWinningAmount();
    update();
  }

  @override
  void onClose() {
    // fortuneWheelNotifier.close();
    // // amountController.dispose();
    // // amountFocusNode.dispose();
    // animationController.dispose();

    audioController.stop();
    super.onClose();
    isBetValueSelected = false;
  }

  @override
  void dispose() {
    super.dispose();
    audioController.stop();
    fortuneWheelNotifier.close();
    isBetValueSelected = false;
  }
}
