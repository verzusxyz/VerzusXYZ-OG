import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:verzusxyz/core/utils/my_strings.dart';
import 'package:verzusxyz/data/repo/all-games/black_jack/black_jack_repo.dart';
import 'package:verzusxyz/view/components/snack_bar/show_custom_snackbar.dart';

class BlackJackController extends GetxController {
  final BlackJackRepo blackJackRepo;
  final String walletType;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  BlackJackController({required this.blackJackRepo, required this.walletType});

  TextEditingController amountController = TextEditingController();
  var amountFocusNode = FocusNode();

  bool isLoading = false;
  bool isSubmitted = false;
  bool playNow = false;
  String? gameId;

  String name = "";
  String availableBalance = "0.00";
  String instruction = "";
  String shortDescription = "";
  String minimum = "0.00";
  String maximum = "0.00";
  String winningPercentage = "0.00";

  // Game state
  List<String> userCards = [];
  List<String> dealerCards = [];
  int userScore = 0;
  int dealerScore = 0;

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
      name = "Blackjack";
      instruction = "Get as close to 21 as possible without going over.";
      shortDescription =
          "Beat the dealer's hand without exceeding 21. Kings, Queens, and Jacks are worth 10. Aces can be 1 or 11.";
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

      gameId = await blackJackRepo.createNewGame(
        investAmount: amount,
        walletType: walletType,
      );

      if (gameId != null) {
        // Mocking initial card deal
        userCards = ['AC', '10S'];
        dealerCards = ['7H', 'KD'];
        _calculateScores();
        playNow = true;
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

  Future<void> hit() async {
    // Mocking a new card
    userCards.add('5D');
    _calculateScores();
    if (userScore > 21) {
      // Bust
      await _endGame(false);
    }
    update();
  }

  Future<void> stay() async {
    // Mocking dealer's turn
    while (dealerScore < 17) {
      dealerCards.add('3C');
      _calculateScores();
    }
    bool userWon = (dealerScore > 21 || userScore > dealerScore);
    await _endGame(userWon);
    update();
  }

  Future<void> _endGame(bool userWon) async {
    final double amount = double.parse(amountController.text);
    final double winnings = userWon ? amount : -amount;
    await blackJackRepo.endGame(gameId!, userWon, winnings, walletType);
    await loadGameInfo(); // Refresh balance
    playNow = false;
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
    userCards.clear();
    dealerCards.clear();
    userScore = 0;
    dealerScore = 0;
    gameId = null;
    update();
  }

  void _calculateScores() {
    userScore = _calculateScore(userCards);
    dealerScore = _calculateScore(dealerCards);
  }

  int _calculateScore(List<String> cards) {
    int score = 0;
    int aceCount = 0;
    for (String card in cards) {
      if (card.startsWith('A')) {
        aceCount++;
        score += 11;
      } else if (card.startsWith('K') ||
          card.startsWith('Q') ||
          card.startsWith('J') ||
          card.startsWith('10')) {
        score += 10;
      } else {
        score += int.parse(card.substring(0, 1));
      }
    }
    while (score > 21 && aceCount > 0) {
      score -= 10;
      aceCount--;
    }
    return score;
  }
}
