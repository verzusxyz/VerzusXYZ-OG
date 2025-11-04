import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// A repository class for handling wallet-related data with Firebase.
class WalletScreenRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Retrieves the current user's wallet data.
  ///
  /// - Returns a [DocumentSnapshot] containing the user's wallet data.
  Future<DocumentSnapshot?> loadData() async {
    try {
      final User? user = _auth.currentUser;
      if (user != null) {
        return await _firestore.collection('users').doc(user.uid).get();
      }
      return null;
    } catch (e) {
      print('An unexpected error occurred while loading wallet data: $e');
      rethrow;
    }
  }

  /// Retrieves the transaction list for the current user.
  ///
  /// - Returns a list of [QueryDocumentSnapshot]s representing the transactions.
  Future<List<QueryDocumentSnapshot>> getTransactionList() async {
    try {
      final User? user = _auth.currentUser;
      if (user != null) {
        final QuerySnapshot querySnapshot = await _firestore
            .collection('transactions')
            .where('userId', isEqualTo: user.uid)
            .orderBy('createdAt', descending: true)
            .get();
        return querySnapshot.docs;
      }
      return [];
    } catch (e) {
      print('An unexpected error occurred while fetching transactions: $e');
      rethrow;
    }
  }
}
