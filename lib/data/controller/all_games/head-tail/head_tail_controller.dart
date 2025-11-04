import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:verzusxyz/core/utils/my_strings.dart';
import 'package:verzusxyz/data/repo/all-games/head-tail/head_tail_repo.dart';
import 'package:verzusxyz/view/components/snack_bar/show_custom_snackbar.dart';

class HeadTailController extends GetxController {
  final HeadTailRepo headTailRepo;
  final String walletType;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  HeadTailController({required this.headTailRepo, required this.walletType});

  TextEditingController amountController = TextEditingController();
  var amountFocusNode = FocusNode();

  bool isUserChoiceIsHead = false;
  bool isAnimationShouldRunning = false;
  bool isLoading = false;
  bool isSubmitted = false;
  String? gameId;

  String name = "";
  String availableBalance = "0.00";
  String instruction = "";
  String minimum = "0.00";
  String maximum = "0.00";
  String winningPercentage = "";

  @override
  void onInit() {
    super.onInit();
    loadGameInfo();
  }

  Future<void> loadGameInfo() async {
    isLoading = true;
    update();
    try {
      final User? user = _auth.currentUser;
      if (user != null) {
        final DocumentSnapshot userDoc =
            await _firestore.collection('users').doc(user.uid).get();
        if (walletType == 'live') {
          availableBalance = (userDoc['liveBalance'] ?? 0).toStringAsFixed(2);
        } else {
          availableBalance = (userDoc['demoBalance'] ?? 0).toStringAsFixed(2);
        }
      }
      name = "Head & Tail";
      instruction = "Choose a side and flip the coin.";
      minimum = "1";
      maximum = "100";
      winningPercentage = "100";
    } catch (e) {
      CustomSnackBar.error(errorList: ['Failed to load game info.']);
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> submitInvestmentRequest() async {
    isSubmitted = true;
    update();
    try {
      final double amount = double.parse(amountController.text);
      if (amount > double.parse(availableBalance)) {
        CustomSnackBar.error(errorList: [MyStrings.insufficientBalance]);
        return;
      }

      gameId = await headTailRepo.createNewGame(
        investAmount: amount,
        walletType: walletType,
        userChoice: isUserChoiceIsHead ? 'head' : 'tail',
      );

      if (gameId != null) {
        // Mocking the game result
        final bool userWon = Random().nextBool();
        await endTheGame(userWon);
      } else {
        CustomSnackBar.error(errorList: ['Failed to start the game.']);
      }
    } catch (e) {
      CustomSnackBar.error(errorList: ['Invalid amount.']);
    } finally {
      isSubmitted = false;
      update();
    }
  }

  Future<void> endTheGame(bool userWon) async {
    final double amount = double.parse(amountController.text);
    final double winnings = userWon ? amount : -amount;
    await headTailRepo.endGame(gameId!, userWon, winnings, walletType);
    await loadGameInfo(); // Refresh balance
    // Show a dialog or snackbar for win/loss
    Get.defaultDialog(
      title: userWon ? "You Won!" : "You Lost!",
      middleText: "Your new balance is $availableBalance",
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
            resetGame();
          },
          child: Text("Play Again"),
        ),
      ],
    );
  }

  void resetGame() {
    amountController.clear();
    gameId = null;
    update();
  }

  void setUserChoice(bool isHead) {
    isUserChoiceIsHead = isHead;
    update();
  }
}
