import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// A repository class for handling transactions with Firebase.
class TransactionRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Retrieves the transactions for the current user.
  ///
  /// - Returns a list of [QueryDocumentSnapshot]s representing the transactions.
  Future<List<QueryDocumentSnapshot>> getTransactions() async {
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
      print('An unexpected error occurred: $e');
      return [];
    }
  }
}
