import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:verzusxyz/core/helper/string_format_helper.dart';
import 'package:verzusxyz/core/utils/my_audio.dart';
import 'package:verzusxyz/core/utils/my_color.dart';
import 'package:verzusxyz/core/utils/my_strings.dart';
import 'package:verzusxyz/core/utils/style.dart';
import 'package:verzusxyz/data/model/global/response_model/response_model.dart';
import 'package:verzusxyz/data/model/number_slot_result/number_slot_result_model.dart';
import 'package:verzusxyz/data/model/number_slot_submit_ans/number_slot_submit_ans_model.dart';
import 'package:verzusxyz/data/model/slot_number/slot_number_model.dart';
import 'package:verzusxyz/data/repo/all-games/play_number_slot/play_number_slot_repo.dart';
import 'package:verzusxyz/view/components/alert-dialog/custom_alert_dialog.dart';
import 'package:verzusxyz/view/components/snack_bar/show_custom_snackbar.dart';
import 'package:verzusxyz/view/screens/all-games/roulette/widget/lose_dialog.dart';
import 'package:verzusxyz/view/screens/all-games/widgets/winner_dialogue.dart';
import 'package:get/get.dart';
import 'package:roller_list/roller_list.dart';

class PlayNumberSlotController extends GetxController {
  PlayNumberSlotRepo playNumberSlot;
  PlayNumberSlotController({required this.playNumberSlot});
  TextEditingController amountController = TextEditingController();
  TextEditingController enterNumberController = TextEditingController();

  var amountFocusNode = FocusNode();
  var enterNumberFocusNode = FocusNode();

  bool isLoading = false;
  bool isSubmitted = false;

  String availAbleBalance = "0";
  String minimumAoumnnt = "0.00";
  String maxAoumnnt = "0.00";
  String gameName = "";
  String instruction = "";
  String defaultCurrencySymbol = "0";
  String defaultCurrency = "0";
  List<String> levels = [];
  List<int> stoppedNumbers = [];

  late Timer timer;

  int selectedDiceIndex = -1;

  int? first, second, third;
  final leftRoller = GlobalKey<RollerListState>();
  final centerRoller = GlobalKey<RollerListState>();
  final rightRoller = GlobalKey<RollerListState>();

  List<String> stopIndex = [];
  Timer? rotator;
  String winMessage = '';
  static const Duration _ROTATION_DURATION = Duration(milliseconds: 200);
  static const Duration _STOP_DURATION = Duration(seconds: 5);
  static final Random _random = Random();

  late AudioPlayer audioController;

  @override
  void onInit() {
    super.onInit();
    audioController = AudioPlayer();
  }

  void loadGameInfo() async {
    isLoading = true;
    loadCurrency();
    update();
    ResponseModel model = await playNumberSlot.loadData();
    if (model.statusCode == 200) {
      SlotNumberDataModel responseModel = SlotNumberDataModel.fromJson(
        jsonDecode(model.responseJson),
      );

      if (responseModel.status?.toLowerCase() ==
          MyStrings.success.toLowerCase()) {
        minimumAoumnnt =
            responseModel.data?.game?.minLimit.toString() ?? "0.00";
        maxAoumnnt = responseModel.data?.game?.maxLimit.toString() ?? "0.00";
        gameName = responseModel.data?.game?.name.toString() ?? "";
        instruction = responseModel.data?.game?.instruction.toString() ?? "";
        availAbleBalance = responseModel.data?.userBalance.toString() ?? "";
        levels.addAll(responseModel.data?.game?.level ?? []);
      }
    } else {
      CustomSnackBar.error(errorList: [model.message]);
    }
    isLoading = false;
    update();
  }

  String gameId = "";

  List<SlotNumberSubmitAnsModel> fullModel = [];
  submitInvestmentRequest() async {
    stopIndex.clear();
    isSubmitted = true;
    amountFocusNode.unfocus();
    enterNumberFocusNode.unfocus();

    update();

    ResponseModel model = await playNumberSlot.submitAnswer(
      amountController.text,
      enterNumberController.text,
    );

    if (model.statusCode == 200) {
      SlotNumberSubmitAnsModel slotNumberSubmitAnsModel =
          SlotNumberSubmitAnsModel.fromJson(jsonDecode(model.responseJson));

      if (slotNumberSubmitAnsModel.status?.toLowerCase() ==
          MyStrings.success.toLowerCase()) {
        availAbleBalance = Converter.formatNumber(
          slotNumberSubmitAnsModel.data?.balance ?? "",
        );
        gameId = slotNumberSubmitAnsModel.data?.gameLog?.id.toString() ?? "0";
        startRotating();
        stopIndex =
            slotNumberSubmitAnsModel.data?.number
                ?.map((e) => e.toString())
                .toList()
                .cast<String>() ??
            [];
        endTheGame();
      } else {
        CustomSnackBar.error(
          errorList:
              slotNumberSubmitAnsModel.message?.error ??
              [MyStrings.somethingWentWrong],
        );
      }
    } else {
      CustomSnackBar.error(errorList: [model.message]);
    }
    isSubmitted = false;

    update();
  }

  endTheGame() async {
    ResponseModel model = await playNumberSlot.getAnswer(gameId);

    if (model.statusCode == 200) {
      SlotNumberResultModel cardFindingResultModel =
          SlotNumberResultModel.fromJson(jsonDecode(model.responseJson));

      if (cardFindingResultModel.status?.toLowerCase() ==
          MyStrings.success.toLowerCase()) {
        update();
        Timer(const Duration(seconds: 7), () {
          if (cardFindingResultModel.data!.type != MyStrings.danger) {
            int? winCount = int.tryParse(
              RegExp(r'\d+')
                      .firstMatch(
                        cardFindingResultModel.data?.message.toString() ?? "0",
                      )
                      ?.group(0) ??
                  '',
            );

            if (winCount == 1) {
              winMessage = 'Single';
            } else if (winCount == 2) {
              winMessage = 'Double';
            } else if (winCount == 3) {
              winMessage = 'Triple';
            }
            CustomAlertDialog(
              child: WinnerDialog(result: stoppedNumbers.toString()),
            ).customAlertDialog(Get.context!);
          } else {
            CustomAlertDialog(
              child: LoseDialog(
                isShowResult: true,
                result: stoppedNumbers.toString(),
              ),
            ).customAlertDialog(Get.context!);
          }
          availAbleBalance = cardFindingResultModel.data?.bal.toString() ?? "";
          resetAll();
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
    amountController.text = "";
    enterNumberController.text = "";
  }

  Future<void> loadCurrency() async {
    defaultCurrency = playNumberSlot.apiClient.getCurrencyOrUsername();

    defaultCurrencySymbol = playNumberSlot.apiClient.getCurrencyOrUsername(
      isSymbol: true,
    );
  }

  List<Widget> buildItems() {
    return List.generate(11, (index) {
      return Container(
        decoration: BoxDecoration(border: Border.all()),
        child: Center(
          child: Text(
            index.toString(),
            style: semiBoldDefault.copyWith(
              color: MyColor.colorWhite,
              fontFamily: "Inter",
            ),
          ),
        ),
      );
    });
  }

  void startRotating() {
    rotator = Timer.periodic(_ROTATION_DURATION, _rotateRoller);
    audioController.play(AssetSource(MyAudio.numberSlotAudio));
    Timer(_STOP_DURATION, () {
      finishRotating();
      isSubmitted = false;
      _stopAtDesiredNumbers();
    });
  }

  void _rotateRoller(_) {
    final leftRotationTarget = _random.nextInt(11);
    final centerRotationTarget = _random.nextInt(11);
    final rightRotationTarget = _random.nextInt(11);

    leftRoller.currentState!.smoothScrollToIndex(
      leftRotationTarget,
      duration: _ROTATION_DURATION,
      curve: Curves.linear,
    );
    centerRoller.currentState!.smoothScrollToIndex(
      centerRotationTarget,
      duration: _ROTATION_DURATION,
      curve: Curves.linear,
    );
    rightRoller.currentState!.smoothScrollToIndex(
      rightRotationTarget,
      duration: _ROTATION_DURATION,
      curve: Curves.linear,
    );
  }

  void finishRotating() {
    audioController.stop();
    rotator?.cancel();
  }

  void _stopAtDesiredNumbers() {
    final leftRotationTarget = int.tryParse(stopIndex[0].toString());
    final centerRotationTarget = int.tryParse(stopIndex[1].toString());
    final rightRotationTarget = int.tryParse(stopIndex[2].toString());

    leftRoller.currentState!.smoothScrollToIndex(
      leftRotationTarget!,
      duration: _ROTATION_DURATION,
      curve: Curves.linear,
    );
    centerRoller.currentState!.smoothScrollToIndex(
      centerRotationTarget!,
      duration: _ROTATION_DURATION,
      curve: Curves.linear,
    );
    rightRoller.currentState!.smoothScrollToIndex(
      rightRotationTarget!,
      duration: _ROTATION_DURATION,
      curve: Curves.linear,
    );

    stoppedNumbers = [
      leftRotationTarget,
      centerRotationTarget,
      rightRotationTarget,
    ];
  }

  void firstSlotUpdate(int value) {
    first = value;
    update();
  }

  void secondSlotUpdate(int value) {
    second = value;
    update();
  }

  void thirdSlotUpdate(int value) {
    third = value;
    update();
  }

  @override
  void onClose() {
    audioController.stop();
    super.onClose();
  }
}
