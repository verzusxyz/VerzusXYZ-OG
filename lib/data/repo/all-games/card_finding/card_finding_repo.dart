import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CardFindingRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String?> createNewGame({
    required double investAmount,
    required String walletType,
    required String userChoice,
  }) async {
    try {
      final User? user = _auth.currentUser;
      if (user != null) {
        final docRef = await _firestore.collection('gameLogs').add({
          'userId': user.uid,
          'gameType': 'card_finding',
          'investAmount': investAmount,
          'walletType': walletType,
          'userChoice': userChoice,
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
