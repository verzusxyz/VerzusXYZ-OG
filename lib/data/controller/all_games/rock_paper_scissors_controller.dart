// RockPaperScissorsController.dart
import 'dart:async';
import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:verzusxyz/core/utils/my_audio.dart';
import 'package:verzusxyz/core/utils/my_images.dart';
import 'package:verzusxyz/core/utils/my_strings.dart';
import 'package:verzusxyz/data/model/global/response_model/response_model.dart';
import 'package:verzusxyz/data/model/rock_paper_scissors/rock_paper_scissors_model.dart';
import 'package:verzusxyz/data/model/rock_paper_scissors_ans/rock_paper_answer_model.dart';
import 'package:verzusxyz/data/model/rock_paper_scissors_submit_ans/rock_paper_scissors_submit_answer_model.dart';
import 'package:verzusxyz/data/repo/all-games/rock_paper_scissors/rock_paper_scissors_repo.dart';
import 'package:verzusxyz/view/components/alert-dialog/custom_alert_dialog.dart';
import 'package:verzusxyz/view/components/snack_bar/show_custom_snackbar.dart';
import 'package:verzusxyz/view/screens/all-games/roulette/widget/lose_dialog.dart';
import 'package:verzusxyz/view/screens/all-games/widgets/winner_dialogue.dart';
import 'package:get/get.dart';

enum Choice { rock, paper, scissors }

class RockPaperScissorsController extends GetxController {
  RockPaperScissorsRepo rockPaperScissorsRepo;

  RockPaperScissorsController({required this.rockPaperScissorsRepo});

  Choice? userChoice;
  late AudioPlayer audioController;
  bool isSubmitting = false;

  String defaultCurrencySymbol = "";
  Choice? computerChoice;
  final TextEditingController amountController = TextEditingController();
  int stopImageIndex = 0;
  final List<String> rockScissorPaperImages = [
    MyImages.rock,
    MyImages.bigPaper,
    MyImages.bigScissors,
  ];
  String currentImage = MyImages.rock;
  String stoppedImage = "";
  Timer? timer;
  int currentIndex = 0;

  var amountFocusNode = FocusNode();

  String name = "";
  String availableBalance = "0.00";
  String instruction = "";
  String minimum = "0.00";
  String winningPercentage = "0";
  String maximum = "0.00";
  bool isLoading = false;

  String email = "";
  String username = "";
  String siteName = "";
  String imagePath = "";
  String defaultCurrency = "";

  var myFocusNode = FocusNode();

  bool showResult = false;
  int timerDuration = 500;

  @override
  void onInit() {
    super.onInit();
    audioController = AudioPlayer();
  }

  void changeRockScissorsPapersImages() {
    currentImage = rockScissorPaperImages[currentIndex];
    currentIndex =
        (currentIndex + 1) % rockScissorPaperImages.length; // 1 % 3 = 1
    update();
  }

  void startUpdatingImage() {
    timer = Timer.periodic(Duration(milliseconds: timerDuration), (timer) {
      changeRockScissorsPapersImages();
    });
  }

  void initData() async {
    isLoading = true;
    defaultCurrency = rockPaperScissorsRepo.apiClient.getCurrencyOrUsername();
    defaultCurrencySymbol = rockPaperScissorsRepo.apiClient
        .getCurrencyOrUsername(isSymbol: true);
    update();

    await loadGameInfo();

    isLoading = false;
    update();
  }

  Future<void> loadGameInfo() async {
    ResponseModel model = await rockPaperScissorsRepo.loadGameInformation();
    if (model.statusCode == 200) {
      RockpaperScissorsDataModel responseModel =
          RockpaperScissorsDataModel.fromJson(jsonDecode(model.responseJson));
      if (responseModel.status?.toLowerCase() ==
          MyStrings.success.toLowerCase()) {
        if (responseModel.data != null) {
          audioController.play(AssetSource(MyAudio.rockPaperAudio));
          name = responseModel.data?.game?.name.toString() ?? "0";
          availableBalance = responseModel.data?.userBalance.toString() ?? "0";
          instruction = responseModel.data?.game?.instruction.toString() ?? "0";
          minimum = responseModel.data?.game?.minLimit.toString() ?? "0";
          maximum = responseModel.data?.game?.maxLimit.toString() ?? "0";

          // we have to add 100 if investback are enable
          if (responseModel.data?.game?.investBack == "1") {
            double? winningAmount =
                double.tryParse(
                  responseModel.data?.game?.win.toString() ?? "",
                ) ??
                0.0;
            winningAmount += 100.0;
            winningPercentage = winningAmount.toString();
          } else {
            winningPercentage = responseModel.data?.game?.win.toString() ?? "";
          }
        }
      }
    } else {
      CustomSnackBar.error(errorList: [model.message]);
    }
  }

  String gameId = "";
  increaseTimerSpeed() {
    timerDuration = timerDuration ~/ 7;
  }

  submitInvestmentRequest() async {
    isSubmitting = true;

    amountFocusNode.unfocus();

    update();

    String choice = userChoice == Choice.rock
        ? "rock"
        : userChoice == Choice.paper
        ? "paper"
        : userChoice == Choice.scissors
        ? "scissors"
        : "";

    ResponseModel model = await rockPaperScissorsRepo.submitAnswer(
      amountController.text,
      choice,
    );

    if (model.statusCode == 200) {
      RockpaperScissorsSubmitAnswerModel submitAnswer =
          RockpaperScissorsSubmitAnswerModel.fromJson(
            jsonDecode(model.responseJson),
          );
      if (submitAnswer.status?.toLowerCase() ==
          MyStrings.success.toLowerCase()) {
        gameId = submitAnswer.data?.gameLog?.id.toString() ?? "0";
        availableBalance = submitAnswer.data?.balance.toString() ?? "0";
        increaseTimerSpeed();

        if (timer != null && timer!.isActive) {
          timer!.cancel();
        }

        startUpdatingImage();
        await endTheGame();
      } else {
        CustomSnackBar.error(
          errorList:
              submitAnswer.message?.error ?? [MyStrings.somethingWentWrong.tr],
        );
        isSubmitting = false;
        update();
      }
    } else {
      CustomSnackBar.error(errorList: [model.message.tr]);
      isSubmitting = false;
      update();
    }
  }

  endTheGame() async {
    ResponseModel model = await rockPaperScissorsRepo.getAnswer(gameId);

    if (model.statusCode == 200) {
      RockpaperScissorsAnswerModel headTailAnsModel =
          RockpaperScissorsAnswerModel.fromJson(jsonDecode(model.responseJson));

      if (headTailAnsModel.status?.toLowerCase() ==
          MyStrings.success.toLowerCase()) {
        stopImageIndex = headTailAnsModel.data!.result == "scissors"
            ? 2
            : headTailAnsModel.data!.result == "rock"
            ? 0
            : headTailAnsModel.data!.result == "paper"
            ? 1
            : 0;

        stopUpdatingImage(stopImageIndex);
        showResult = true;
        Timer(const Duration(seconds: 8), () {
          availableBalance = headTailAnsModel.data?.bal ?? "";
          if (headTailAnsModel.data?.type != MyStrings.danger) {
            CustomAlertDialog(
              child: WinnerDialog(
                result: headTailAnsModel.data?.result.toString() ?? "0",
              ),
            ).customAlertDialog(Get.context!);

            update();
          } else {
            CustomAlertDialog(
              child: LoseDialog(
                isShowResult: true,
                result: headTailAnsModel.data?.result.toString() ?? '',
              ),
            ).customAlertDialog(Get.context!);
          }

          isSubmitting = false;
          resetChoices();
        });

        update();
      }
    } else {
      CustomSnackBar.error(errorList: [model.message.tr]);
    }
  }

  void setUserChoice(Choice choice) {
    userChoice = choice;
    update();
  }

  void stopUpdatingImage(int stopIndex) {
    Future.delayed(const Duration(seconds: 4), () {
      if (timer != null && timer!.isActive) {
        timer!.cancel();
        timerDuration = 500;
        if (stopIndex >= 0 && stopIndex < rockScissorPaperImages.length) {
          stoppedImage = rockScissorPaperImages[stopIndex];
          currentImage = stoppedImage;
        } else {
          stoppedImage = rockScissorPaperImages.last;
        }
        audioController.stop();
        update();
      }
    });
  }

  void resetChoices() {
    userChoice = null;
    computerChoice = null;
    showResult = false;

    stoppedImage = "";
    amountController.text = "";
    Timer(const Duration(seconds: 3), () {
      startUpdatingImage();
    });
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
