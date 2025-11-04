import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:verzusxyz/core/utils/my_strings.dart';
import 'package:verzusxyz/data/repo/all-games/roulete/roulette_repo.dart';
import 'package:verzusxyz/view/components/snack_bar/show_custom_snackbar.dart';

class RouletteController extends GetxController {
  final RouletteRepo rouletteRepo;
  final String walletType;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  RouletteController({required this.rouletteRepo, required this.walletType});

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

  List<int> selectedNumbers = [];
  int? adminSelectedNum;

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
      name = "Roulette";
      instruction = "Bet on a number, color, or group of numbers.";
      minimum = "1";
      maximum = "100";
      winningPercentage = "3500"; // For a single number bet
    } catch (e) {
      CustomSnackBar.error(errorList: ['Failed to load game info.']);
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> submitInvestmentRequest() async {
    if (selectedNumbers.isEmpty) {
      CustomSnackBar.error(errorList: ['Please select a number to bet on.']);
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

      gameId = await rouletteRepo.createNewGame(
        investAmount: amount,
        walletType: walletType,
        userChoice: selectedNumbers.join(','),
      );

      if (gameId != null) {
        // Mocking the game result
        adminSelectedNum = Random().nextInt(37);
        final bool userWon = selectedNumbers.contains(adminSelectedNum);
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
    final double winnings = userWon ? (amount * (36 / selectedNumbers.length)) - amount : -amount;
    await rouletteRepo.endGame(gameId!, userWon, winnings, walletType);
    await loadGameInfo(); // Refresh balance
    // Show a dialog or snackbar for win/loss
    Get.defaultDialog(
      title: userWon ? "You Won!" : "You Lost!",
      middleText:
          "The winning number was $adminSelectedNum.\nYour new balance is $availableBalance",
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
    selectedNumbers.clear();
    adminSelectedNum = null;
    update();
  }

  void selectNumber(int number) {
    if (selectedNumbers.contains(number)) {
      selectedNumbers.remove(number);
    } else {
      selectedNumbers.add(number);
    }
    update();
  }
}
