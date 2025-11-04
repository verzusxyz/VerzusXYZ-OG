import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:verzusxyz/core/utils/my_strings.dart';
import 'package:verzusxyz/data/repo/all-games/card_finding/card_finding_repo.dart';
import 'package:verzusxyz/view/components/snack_bar/show_custom_snackbar.dart';

class CardFindingController extends GetxController {
  final CardFindingRepo cardFindingRepo;
  final String walletType;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  CardFindingController({required this.cardFindingRepo, required this.walletType});

  TextEditingController amountController = TextEditingController();
  var amountFocusNode = FocusNode();

  bool isLoading = false;
  bool isSubmitted = false;
  String? gameId;

  String name = "";
  String availableBalance = "0.00";
  String instruction = "";
  String minimum = "0.00";
  String maximum = "0.00";
  String winningPercentage = "";

  String? userChoice; // "red" or "black"
  String? winningColor;

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
      name = "Card Finding";
      instruction = "Guess the color of the card.";
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
    if (userChoice == null) {
      CustomSnackBar.error(errorList: ['Please select a color.']);
      return;
    }

    isSubmitted = true;
    update();
    try {
      final double amount = double.parse(amountController.text);
      if (amount > double.parse(availableBalance)) {
        CustomSnackBar.error(errorList: [MyStrings.insufficientBalance]);
        return;
      }

      gameId = await cardFindingRepo.createNewGame(
        investAmount: amount,
        walletType: walletType,
        userChoice: userChoice!,
      );

      if (gameId != null) {
        winningColor = Random().nextBool() ? 'red' : 'black';
        final bool userWon = userChoice == winningColor;
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
    await cardFindingRepo.endGame(gameId!, userWon, winnings, walletType);
    await loadGameInfo(); // Refresh balance
    Get.defaultDialog(
      title: userWon ? "You Won!" : "You Lost!",
      middleText:
          "The winning color was $winningColor.\nYour new balance is $availableBalance",
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
    userChoice = null;
    winningColor = null;
    update();
  }

  void setUserChoice(String color) {
    userChoice = color;
    update();
  }
}
