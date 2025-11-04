import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// A repository class for handling withdrawal methods with Firebase.
class WithdrawalMethodRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Retrieves the available withdrawal methods from Firestore.
  ///
  /// - Returns a list of [QueryDocumentSnapshot]s representing the withdrawal methods.
  Future<List<QueryDocumentSnapshot>> getWithdrawalMethods() async {
    try {
      final QuerySnapshot querySnapshot = await _firestore
          .collection('withdrawalMethods')
          .where('isActive', isEqualTo: true)
          .get();
      return querySnapshot.docs;
    } catch (e) {
      print('An unexpected error occurred while fetching withdrawal methods: $e');
      rethrow;
    }
  }
}
