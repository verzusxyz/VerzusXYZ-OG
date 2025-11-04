import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// A repository class for handling withdrawals with Firebase.
class WithdrawRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Retrieves the withdrawal history for the current user.
  ///
  /// - Returns a list of [QueryDocumentSnapshot]s representing the withdrawal history.
  Future<List<QueryDocumentSnapshot>> getWithdrawalHistory() async {
    try {
      final User? user = _auth.currentUser;
      if (user != null) {
        final QuerySnapshot querySnapshot = await _firestore
            .collection('withdrawals')
            .where('userId', isEqualTo: user.uid)
            .orderBy('createdAt', descending: true)
            .get();
        return querySnapshot.docs;
      }
      return [];
    } catch (e) {
      print('An unexpected error occurred while fetching withdrawal history: $e');
      rethrow;
    }
  }

  /// Adds a new withdrawal request to Firestore.
  ///
  /// - [methodId]: The ID of the selected withdrawal method.
  /// - [amount]: The amount to withdraw.
  /// - Returns `true` if the request is successful, otherwise `false`.
  Future<bool> addWithdrawalRequest({
    required String methodId,
    required double amount,
  }) async {
    try {
      final User? user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('withdrawals').add({
          'userId': user.uid,
          'methodId': methodId,
          'amount': amount,
          'status': 'pending',
          'createdAt': FieldValue.serverTimestamp(),
        });
        return true;
      }
      return false;
    } catch (e) {
      print('An unexpected error occurred while adding a withdrawal request: $e');
      return false;
    }
  }
}
