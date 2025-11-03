import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:verzusxyz/core/utils/my_audio.dart';
import 'package:verzusxyz/core/utils/my_images.dart';
import 'package:verzusxyz/core/utils/my_strings.dart';
import 'package:verzusxyz/data/model/global/response_model/response_model.dart';
import 'package:verzusxyz/data/model/mines_cashout/mines_cashout_model.dart';
import 'package:verzusxyz/data/model/mines_end/mines_end_model.dart';
import 'package:verzusxyz/data/model/mines_game_info_model/mines_game_info_model.dart';
import 'package:verzusxyz/data/model/mines_invest/mines_invest_model.dart';
import 'package:verzusxyz/data/model/mines_model/mines_model.dart';
import 'package:verzusxyz/data/repo/all-games/mines/mines_repo.dart';
import 'package:verzusxyz/view/components/alert-dialog/custom_alert_dialog.dart';
import 'package:verzusxyz/view/components/snack_bar/show_custom_snackbar.dart';
import 'package:verzusxyz/view/screens/all-games/roulette/widget/lose_dialog.dart';
import 'package:verzusxyz/view/screens/all-games/widgets/winner_dialogue.dart';
import 'package:get/get.dart';

class MinesScreenController extends GetxController {
  MinesRepo minesRepo;
  MinesScreenController({required this.minesRepo});

  TextEditingController amountController = TextEditingController();
  TextEditingController minesController = TextEditingController();

  var amountFocusNode = FocusNode();
  var minesFocusNode = FocusNode();
  final AudioPlayer audioPlayer = AudioPlayer();
  String selectedNumber = '';

  List<String> name = [];
  String currencySym = "";
  String defaultCurrency = "";
  bool isLoading = false;
  bool isSubmitted = false;
  bool startMine = false;
  bool cashOutAvailable = false;

  int availableMines = 0;

  int totalTaps = 0;

  List<MinesModel> mines = List.generate(
    25,
    (index) => MinesModel(
      imagePath: MyImages.treasureBoxOff,
      isBombed: false,
      isJewel: false,
      isLocked: true,
      tapped: false,
      tapCounter: 0,
    ),
  );

  // void activateMines(int numberOfMinesToActivate) {
  //   for (int i = 0; i < mines.length; i++) {
  //     mines[i] = MinesModel(isBombed: false, isJewel: true, imagePath: MyImages.treasure, tapped: false, isLocked: false, tapCounter: 0);
  //   }

  //   List<int> randomIndices = [];
  //   Random random = Random();
  //   while (randomIndices.length < numberOfMinesToActivate) {
  //     int randomIndex = random.nextInt(mines.length);
  //     if (!randomIndices.contains(randomIndex)) {
  //       randomIndices.add(randomIndex);
  //     }
  //   }

  //   for (int i = 0; i < mines.length; i++) {
  //     if (randomIndices.contains(i)) {
  //       mines[i].isBombed = true;
  //       mines[i].isJewel = false;
  //       mines[i].imagePath = MyImages.bomb;

  //       cashOutAvailable = false;
  //     }
  //   }
  // }

  void checkAndReveal(int index) {
    if (mines[index].isBombed) {
      for (int i = 0; i < mines.length; i++) {
        mines[i].isLocked = false;
        if (mines[i].isBombed) {
          mines[i].imagePath = MyImages.bomb;
        }
      }
      cashOutAvailable = false;
      update();
    } else {}
  }

  void revealAllImages() {
    int userBombCount = int.tryParse(minesController.text) ?? 0;
    // Create a list of untapped image indices\
    List<int> untappedIndices = [];
    for (int i = 0; i < mines.length; i++) {
      if (!mines[i].tapped) {
        untappedIndices.add(i);
      }
    }

    // Shuffle the indices to randomize their order
    untappedIndices.shuffle(Random());

    // Determine how many should be bombed
    int bombCount = (userBombCount - 1); // Round to nearest half

    // Mark the first half as bombed and the rest as treasure
    for (int i = 0; i < untappedIndices.length; i++) {
      int index = untappedIndices[i];
      mines[index].isLocked = false; // Unlock the mine
      mines[index].tapped = true; // Mark as tapped

      if (i < bombCount) {
        mines[index].isBombed = true; // Make this a bomb
        mines[index].imagePath = MyImages.bomb; // Set the bomb image
      } else {
        mines[index].isBombed = false; // Make this a treasure
        mines[index].imagePath = MyImages.treasure; // Set the treasure image
      }
    }

    cashOutAvailable = false;
    update();
  }

  void resetAllImages() {
    for (int i = 0; i < mines.length; i++) {
      mines[i].isLocked = true;
      mines[i].tapped = false;

      mines[i].imagePath = MyImages.treasureBoxOff;
    }

    update();
  }

  void resetAllSelection() {
    totalTaps = 0;
    resetAllImages();
    for (var kenoNumber in mines) {
      kenoNumber.isBombed = false;
    }
    amountController.text = "";
    minesController.text = "";
    cashOutAvailable = false;
    startMine = false;
    update();
  }

  String availAbleBalance = "0.00";
  String minimumAoumnnt = "0.00";
  String maxAoumnnt = "0.00";
  String gameName = "";
  String instruction = "";

  void loadGameInfo() async {
    defaultCurrency = minesRepo.apiClient.getCurrencyOrUsername();
    currencySym = minesRepo.apiClient.getCurrencyOrUsername(isSymbol: true);
    isLoading = true;
    update();

    ResponseModel model = await minesRepo.loadData();
    if (model.statusCode == 200) {
      MinesGameInfoModel responseModel = MinesGameInfoModel.fromJson(
        jsonDecode(model.responseJson),
      );
      if (responseModel.status?.toLowerCase() ==
          MyStrings.success.toLowerCase()) {
        gameName = responseModel.data?.game?.name.toString() ?? "";
        availAbleBalance = responseModel.data?.userBalance.toString() ?? "";
        minimumAoumnnt = responseModel.data?.game?.minLimit.toString() ?? "";
        maxAoumnnt = responseModel.data?.game?.maxLimit.toString() ?? "";
        instruction = responseModel.data?.game?.instruction.toString() ?? "";
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
    minesFocusNode.unfocus();
    update();

    ResponseModel model = await minesRepo.invest(
      amountController.text,
      minesController.text,
    );

    if (model.statusCode == 200) {
      MinesInvestModel submitAnswer = MinesInvestModel.fromJson(
        jsonDecode(model.responseJson),
      );

      if (submitAnswer.status?.toLowerCase() ==
          MyStrings.success.toLowerCase()) {
        gameId = submitAnswer.data?.gameLogId.toString() ?? "";
        availableMines =
            int.tryParse(submitAnswer.data?.availableMine.toString() ?? "0") ??
            0;
        availAbleBalance = submitAnswer.data?.balance.toString() ?? "0";
        //  activateMines(int.tryParse(minesController.text) ?? 0);
        cashOutAvailable = true;
        startMine = true;
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

  cashOut() async {
    isSubmitted = true;
    update();

    ResponseModel model = await minesRepo.cashOut(gameId);

    if (model.statusCode == 200) {
      MinesCashOutModel cashOutModel = MinesCashOutModel.fromJson(
        jsonDecode(model.responseJson),
      );
      if (cashOutModel.status?.toLowerCase() ==
          MyStrings.success.toLowerCase()) {
        availAbleBalance = cashOutModel.data?.balance.toString() ?? "0";
        CustomAlertDialog(
          child: const WinnerDialog(result: ""),
        ).customAlertDialog(Get.context!);
        resetAllSelection();
        CustomSnackBar.success(
          successList: [cashOutModel.data?.success.toString() ?? ""],
        );
      } else {
        availAbleBalance = cashOutModel.data?.balance.toString() ?? "0";
        CustomAlertDialog(
          child: const LoseDialog(),
        ).customAlertDialog(Get.context!);
        resetAllSelection();
        CustomSnackBar.error(
          errorList:
              cashOutModel.message?.error ?? [MyStrings.somethingWentWrong.tr],
        );
        update();
      }
    } else {
      CustomSnackBar.error(errorList: [model.message]);
    }
    isSubmitted = false;
    update();
  }

  gameEnd() async {
    ResponseModel model = await minesRepo.minesEnd(gameId);

    if (model.statusCode == 200) {
      MinesEndModel minesEndModel = MinesEndModel.fromJson(
        jsonDecode(model.responseJson),
      );

      if (minesEndModel.status?.toLowerCase() ==
          MyStrings.success.toLowerCase()) {
        availAbleBalance = minesEndModel.data?.balance ?? "";
        update();
      }
    } else {
      CustomSnackBar.error(errorList: [model.message]);
    }
  }

  tapBox(int index) {
    if (totalTaps < availableMines) {
      mines[index].tapped = true;
      mines[index].imagePath = MyImages.treasure;
      totalTaps++;
      audioPlayer.play(AssetSource(MyAudio.treasureBoxOpenAudio));
      gameEnd();
    } else {
      if (!mines[index].tapped) {
        mines[index].tapped = true;
        mines[index].isBombed = true;
        totalTaps++;
        revealAllImages();
        gameEnd();

        if (mines[index].isBombed) {
          for (int i = 0; i < mines.length; i++) {
            mines[i].isLocked = false;
            if (mines[i].isBombed) {
              mines[i].imagePath = MyImages.bomb;
              cashOutAvailable = false;
              audioPlayer.play(AssetSource(MyAudio.bombedAudio));
            }
          }
          gameEnd();
          Timer(const Duration(seconds: 3), () {
            CustomAlertDialog(
              child: const LoseDialog(),
            ).customAlertDialog(Get.context!);
            Timer(const Duration(seconds: 3), () {
              resetAllSelection();
            });
          });
        } else {
          mines[index].imagePath = MyImages.treasure;
        }
      }
    }
    update();
  }
}
