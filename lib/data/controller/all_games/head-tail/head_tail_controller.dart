import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:verzusxyz/core/helper/string_format_helper.dart';
import 'package:verzusxyz/core/utils/my_audio.dart';
import 'package:verzusxyz/core/utils/my_images.dart';
import 'package:verzusxyz/core/utils/my_strings.dart';
import 'package:verzusxyz/data/model/global/response_model/response_model.dart';
import 'package:verzusxyz/data/model/head-tail/head_tail_model.dart';
import 'package:verzusxyz/data/model/head_tail_ans/head_tail_ans_model.dart';
import 'package:verzusxyz/data/model/head_tail_submit_ans/head_tail_submit_ans_model.dart';
import 'package:verzusxyz/data/repo/all-games/head-tail/head_tail_repo.dart';
import 'package:verzusxyz/view/components/alert-dialog/custom_alert_dialog.dart';
import 'package:verzusxyz/view/components/snack_bar/show_custom_snackbar.dart';
import 'package:verzusxyz/view/screens/all-games/roulette/widget/lose_dialog.dart';
import 'package:verzusxyz/view/screens/all-games/widgets/winner_dialogue.dart';
import 'package:get/get.dart';

class HeadTailController extends GetxController {
  HeadTailRepo headTailRepo;
  HeadTailController({required this.headTailRepo});

  TextEditingController amountController = TextEditingController();
  var amountFocusNode = FocusNode();
  bool isAdminSelectHead = false;

  bool? isUserChoiseIsHead = false;
  bool? isUserChoiseIsTail = false;
  bool isAnimationShouldRunning = false;
  late Animation<double> animation;
  late AnimationController animationController;
  late AudioPlayer audioController;
  late Timer timeoutTimer;
  bool isLoading = false;
  bool isSubmitted = false;
  String gameId = "";

  String name = "";
  String availableBalance = "0.00";
  String alias = "";
  String instruction = "";
  String defaultCurrency = "";
  String defaultCurrencySymbol = "";
  String minimum = "0.00";
  String maximum = "0.00";
  String winningPercentage = "";

  final List<String> myOptionsImage = [MyImages.head, MyImages.tails];
  late Timer timer;

  @override
  void onInit() {
    super.onInit();
    audioController = AudioPlayer();
  }

  void loadData() async {
    isLoading = true;
    defaultCurrency = headTailRepo.apiClient.getCurrencyOrUsername();
    defaultCurrencySymbol = headTailRepo.apiClient.getCurrencyOrUsername(
      isSymbol: true,
    );
    flipController = FlipCardController();
    update();
    await loadGameInfo();
    isLoading = false;
    update();
  }

  Future<void> loadGameInfo() async {
    ResponseModel model = await headTailRepo.loadGameInformation();
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
        minimum = responseModel.data?.game?.minLimit.toString() ?? "";
        maximum = responseModel.data?.game?.maxLimit.toString() ?? "";
        if (responseModel.data?.game?.investBack == "1") {
          double? winningAmount =
              double.tryParse(responseModel.data?.game?.win.toString() ?? "") ??
              0.0;
          winningAmount = winningAmount + 100.0;

          winningPercentage = winningAmount.toString();
        } else {
          winningPercentage = responseModel.data?.game?.win.toString() ?? "";
        }
      }
    } else {
      CustomSnackBar.error(errorList: [model.message]);
    }
  }

  late FlipCardController flipController;

  submitInvestmentRequest() async {
    isAnimationShouldRunning = true;
    amountFocusNode.unfocus();
    isSubmitted = true;

    update();
    ResponseModel model = await headTailRepo.submitAnswer(
      amountController.text,
      isUserChoiseIsHead! ? "head" : "tail",
    );

    if (model.statusCode == 200) {
      HeadTailInvestmentResponseModel submitAnswer =
          HeadTailInvestmentResponseModel.fromJson(
            jsonDecode(model.responseJson),
          );

      if (submitAnswer.status?.toLowerCase() ==
          MyStrings.success.toLowerCase()) {
        gameId = submitAnswer.data?.gameLog?.id.toString() ?? "";
        availableBalance = Converter.formatNumber(
          submitAnswer.data?.balance ?? "0",
        );

        isAdminSelectHead = submitAnswer.data!.gameLog?.result == "head"
            ? true
            : false;
        startGame();
        update();
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
      isSubmitted = false;
      update();
    }
  }

  endTheGame() async {
    if (flipStopped) {
      if (timer.isActive) {
        timer.cancel();
        audioController.stop();
      }
    }
    audioController.stop();
    update();
    ResponseModel model = await headTailRepo.getAnswer(gameId);

    if (model.statusCode == 200) {
      HeadTailAnsModel headTailAnsModel = HeadTailAnsModel.fromJson(
        jsonDecode(model.responseJson),
      );

      if (headTailAnsModel.status?.toLowerCase() ==
          MyStrings.success.toLowerCase()) {
        isAdminSelectHead = headTailAnsModel.data!.result == "head"
            ? true
            : false;

        stopFlip();

        Timer(const Duration(seconds: 3), () {
          if (headTailAnsModel.data != null &&
              headTailAnsModel.data!.type != MyStrings.danger) {
            CustomAlertDialog(
              child: WinnerDialog(
                result: headTailAnsModel.data?.result.toString() ?? "",
              ),
            ).customAlertDialog(Get.context!);

            resetAll();
          } else {
            CustomAlertDialog(
              child: LoseDialog(
                isShowResult: true,
                result: headTailAnsModel.data?.result.toString() ?? "",
              ),
            ).customAlertDialog(Get.context!);
            resetAll();
          }
          isSubmitted = false;
          availableBalance = headTailAnsModel.data?.bal.toString() ?? "";
          update();
        });
      }
    } else {
      CustomSnackBar.error(errorList: [model.message]);
    }
  }

  void stopFlip() {
    if (timer.isActive) {
      timer.cancel();
    }
    flipStopped = true;
    audioController.stop();
  }

  resetAll() {
    amountController.text = "";
    isUserChoiseIsHead = false;
    isUserChoiseIsTail = false;
    update();
  }

  closeAll() {
    resetAll();
    timer.cancel();
    update();
  }

  int totalRotate = 0;
  int maxRotate = Random().nextInt(30) + 70;
  int baseInterval = 100;
  bool isHeadSelected = false;
  bool flipStopped = false;

  void startGame() {
    audioController.play(AssetSource(MyAudio.coinFlipAudio));
    totalRotate = 0;
    flipStopped = false;

    int flipInterval = baseInterval;

    timer = Timer.periodic(Duration(milliseconds: flipInterval), (timer) {
      if (flipStopped) {
        timer.cancel();
      } else {
        totalRotate++;
        flipController.toggleCard();

        if (totalRotate > maxRotate / 2) {
          flipInterval += 20;
          timer.cancel();

          timer = Timer.periodic(Duration(milliseconds: flipInterval), (t) {
            if (!flipStopped) {
              if (isAdminSelectHead != flipController.state!.isFront) {
                flipController.toggleCard();
              }
            }
          });
        }

        if (totalRotate >= maxRotate) {
          flipStopped = true;
          endTheGame();
        }
      }
    });

    timeoutTimer = Timer(const Duration(seconds: 10), () {
      if (!flipStopped) {
        if (isAdminSelectHead != flipController.state!.isFront) {
          flipController.toggleCard();
        }
        stopFlip();
        endTheGame();
      }
    });
  }

  @override
  void dispose() {
    audioController.stop();
    super.dispose();
  }

  @override
  void onClose() {
    audioController.stop();
    super.onClose();
  }
}
