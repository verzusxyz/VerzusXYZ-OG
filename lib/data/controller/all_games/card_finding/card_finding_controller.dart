import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:verzusxyz/core/helper/string_format_helper.dart';
import 'package:verzusxyz/core/utils/my_audio.dart';
import 'package:verzusxyz/core/utils/my_images.dart';
import 'package:verzusxyz/core/utils/my_strings.dart';
import 'package:verzusxyz/data/model/card_finding_result/card_finding_result.dart';
import 'package:verzusxyz/data/model/card_finding_submit_ans/card_finding_submit_ans_model.dart';
import 'package:verzusxyz/data/model/dice_rolling_data/dice_rolling_data_model.dart';
import 'package:verzusxyz/data/model/global/response_model/response_model.dart';
import 'package:verzusxyz/data/repo/all-games/card_finding/card_finding_repo.dart';
import 'package:verzusxyz/view/components/alert-dialog/custom_alert_dialog.dart';
import 'package:verzusxyz/view/components/snack_bar/show_custom_snackbar.dart';
import 'package:verzusxyz/view/screens/all-games/roulette/widget/lose_dialog.dart';
import 'package:verzusxyz/view/screens/all-games/widgets/winner_dialogue.dart';
import 'package:get/get.dart';

class CardFindingController extends GetxController {
  CardFindingRepo cardFindingRepo;
  CardFindingController({required this.cardFindingRepo});
  TextEditingController amountController = TextEditingController();

  var amountFocusNode = FocusNode();

  bool isLoading = false;
  bool isSubmitted = false;
  bool showDesiredColor = false;

  bool isFront1 = true;
  bool isShuffleIngCards = false;
  late AudioPlayer audioController;

  String availAbleBalance = "0.00";
  String minimumAoumnnt = "0.00";
  String maxAoumnnt = "0.00";
  String gameName = "";
  String instruction = "";
  String defaultCurrencySymbol = "0";
  String defaultCurrency = "0";
  String desiredColor = "red";
  String winningPercentage = "";

  late Timer timer;

  int selectedCardIndex = -1;
  final List<String> myOptionsImage = [MyImages.blackace, MyImages.redAce];
  List<String>? cards;
  List<String> displayCards = [];

  @override
  void onInit() {
    super.onInit();
    audioController = AudioPlayer();
  }

  void loadGameInfo() async {
    isLoading = true;
    loadCurrency();
    update();
    ResponseModel model = await cardFindingRepo.loadData();
    if (model.statusCode == 200) {
      DiceRollingDataModel responseModel = DiceRollingDataModel.fromJson(
        jsonDecode(model.responseJson),
      );

      availAbleBalance = responseModel.data?.userBalance.toString() ?? "0";
      if (responseModel.status?.toLowerCase() ==
          MyStrings.success.toLowerCase()) {
        minimumAoumnnt = responseModel.data?.game?.minLimit.toString() ?? "0";
        maxAoumnnt = responseModel.data?.game?.maxLimit.toString() ?? "0";
        gameName = responseModel.data?.game?.name.toString() ?? "0";
        instruction = responseModel.data?.game?.instruction.toString() ?? "0";
        displayCards = responseModel.data?.cardFindingImgName ?? [];
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
    amountFocusNode.unfocus();
    isSubmitted = true;
    update();

    ResponseModel model = await cardFindingRepo.submitAnswer(
      amountController.text,
      selectedCardIndex == 0
          ? "black"
          : selectedCardIndex == 1
          ? "red"
          : "",
    );

    if (model.statusCode == 200) {
      CardFindingSubmitAnsModel submitAnswer =
          CardFindingSubmitAnsModel.fromJson(jsonDecode(model.responseJson));
      if (submitAnswer.status?.toLowerCase() ==
          MyStrings.success.toLowerCase()) {
        isShuffleIngCards = true;
        audioController.play(AssetSource(MyAudio.cardShuffleAudio));
        availAbleBalance = Converter.formatNumber(
          submitAnswer.data?.balance ?? "",
        );
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
    ResponseModel model = await cardFindingRepo.getAnswer(gameId);

    if (model.statusCode == 200) {
      CardFindingResultModel cardFindingResultModel =
          CardFindingResultModel.fromJson(jsonDecode(model.responseJson));

      if (cardFindingResultModel.status?.toLowerCase() ==
          MyStrings.success.toLowerCase()) {
        desiredColor = cardFindingResultModel.data?.result.toString() ?? "";

        update();
        Timer(const Duration(seconds: 10), () {
          if (cardFindingResultModel.data?.type != MyStrings.danger) {
            CustomAlertDialog(
              child: WinnerDialog(
                result: cardFindingResultModel.data?.result.toString() ?? "",
              ),
            ).customAlertDialog(Get.context!);
          } else {
            CustomAlertDialog(
              child: LoseDialog(
                isShowResult: true,
                result: cardFindingResultModel.data?.result.toString() ?? "",
              ),
            ).customAlertDialog(Get.context!);
          }
          availAbleBalance = cardFindingResultModel.data?.bal.toString() ?? "";
          resetAll();
          update();
        });
        Timer(const Duration(seconds: 5), () {
          showDesiredColor = true;

          isShuffleIngCards = false;
          audioController.stop();
          update();
        });

        isLoading = false;
        update();
      }
    } else {
      CustomSnackBar.error(errorList: [model.message]);
    }
  }

  resetAll() {
    showDesiredColor = false;
    amountController.text = "";
    selectedCardIndex = -1;
  }

  Future<void> loadCurrency() async {
    defaultCurrency = cardFindingRepo.apiClient.getCurrencyOrUsername();

    defaultCurrencySymbol = cardFindingRepo.apiClient.getCurrencyOrUsername(
      isSymbol: true,
    );
  }

  final List<String> redCards = [
    MyImages.redAce,
    MyImages.red1,
    MyImages.red2,
    MyImages.red3,
    MyImages.red4,
  ];

  final List<String> blackCards = [
    MyImages.black1,
    MyImages.black2,
    MyImages.black3,
    MyImages.black4,
    MyImages.black5,
  ];

  Widget buildCardImage(String color) {
    String imagePath = getRandomCardImagePath(color);
    return Image.asset(imagePath, width: 150, height: 250);
  }

  String getRandomCardImagePath(String color) {
    if (color == 'red') {
      cards = redCards;
    } else if (color == 'black') {
      cards = blackCards;
    }
    return cards![Random().nextInt(cards!.length)];
  }

  void updateIndex(int index) {
    selectedCardIndex = index;

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
