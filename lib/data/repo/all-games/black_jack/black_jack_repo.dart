import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// A repository class for handling Blackjack game logic with Firebase.
class BlackJackRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Creates a new Blackjack game document in Firestore.
  ///
  /// - [investAmount]: The amount the user is betting.
  /// - [walletType]: The wallet to use ('live' or 'demo').
  /// - Returns the ID of the new game document.
  Future<String?> createNewGame({
    required double investAmount,
    required String walletType,
  }) async {
    try {
      final User? user = _auth.currentUser;
      if (user != null) {
        // Deduct the amount from the user's balance
        final userRef = _firestore.collection('users').doc(user.uid);
        await _firestore.runTransaction((transaction) async {
          final userDoc = await transaction.get(userRef);
          final balanceField =
              walletType == 'live' ? 'liveBalance' : 'demoBalance';
          final currentBalance = userDoc[balanceField] ?? 0;
          transaction
              .update(userRef, {balanceField: currentBalance - investAmount});
        });

        final docRef = await _firestore.collection('gameLogs').add({
          'userId': user.uid,
          'gameType': 'blackjack',
          'investAmount': investAmount,
          'walletType': walletType,
          'status': 'in-progress',
          'createdAt': FieldValue.serverTimestamp(),
        });
        return docRef.id;
      }
      return null;
    } catch (e) {
      print('Error creating new game: $e');
      return null;
    }
  }

  /// Ends the game and updates the user's balance.
  ///
  /// - [gameId]: The ID of the game log document.
  /// - [userWon]: Whether the user won the game.
  /// - [winnings]: The amount the user won or lost.
  /// - [walletType]: The wallet to update.
  Future<void> endGame(
    String gameId,
    bool userWon,
    double winnings,
    String walletType,
  ) async {
    try {
      final User? user = _auth.currentUser;
      if (user != null) {
        final userRef = _firestore.collection('users').doc(user.uid);
        final gameLogRef = _firestore.collection('gameLogs').doc(gameId);

        await _firestore.runTransaction((transaction) async {
          final userDoc = await transaction.get(userRef);
          final balanceField =
              walletType == 'live' ? 'liveBalance' : 'demoBalance';
          final currentBalance = userDoc[balanceField] ?? 0;

          transaction
              .update(userRef, {balanceField: currentBalance + winnings});
          transaction.update(gameLogRef, {
            'status': 'completed',
            'winStatus': userWon ? 'win' : 'lose',
            'winnings': winnings,
          });
        });
      }
    } catch (e) {
      print('Error ending game: $e');
    }
  }
}
