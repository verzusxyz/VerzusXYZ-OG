import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// A repository class for handling deposits with Firebase.
class DepositRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseFunctions _functions = FirebaseFunctions.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Retrieves the deposit history for the current user.
  ///
  /// - Returns a list of [QueryDocumentSnapshot]s representing the deposit history.
  Future<List<QueryDocumentSnapshot>> getDepositHistory() async {
    try {
      final User? user = _auth.currentUser;
      if (user != null) {
        final QuerySnapshot querySnapshot = await _firestore
            .collection('deposits')
            .where('userId', isEqualTo: user.uid)
            .orderBy('createdAt', descending: true)
            .get();
        return querySnapshot.docs;
      }
      return [];
    } catch (e) {
      print('An unexpected error occurred while fetching deposit history: $e');
      rethrow;
    }
  }

  /// Retrieves the available deposit methods from Firestore.
  ///
  /// - Returns a list of [QueryDocumentSnapshot]s representing the active payment gateways.
  Future<List<QueryDocumentSnapshot>> getDepositMethods() async {
    try {
      final QuerySnapshot querySnapshot = await _firestore
          .collection('paymentGateways')
          .where('isActive', isEqualTo: true)
          .get();
      return querySnapshot.docs;
    } catch (e) {
      print('An unexpected error occurred while fetching deposit methods: $e');
      rethrow;
    }
  }

  /// Initiates a new deposit by calling a Firebase Cloud Function.
  ///
  /// This method calls the `createCheckoutSession` function, which securely
  /// communicates with the payment provider and returns a checkout URL.
  ///
  /// - [amount]: The amount to deposit.
  /// - [providerId]: The unique identifier for the selected payment gateway.
  /// - Returns the checkout URL as a string.
  Future<String?> createDeposit({
    required double amount,
    required String providerId,
  }) async {
    try {
      final HttpsCallable callable =
          _functions.httpsCallable('createCheckoutSession');
      final result = await callable.call<Map<String, dynamic>>({
        'amount': amount,
        'providerId': providerId,
      });

      if (result.data['url'] != null) {
        return result.data['url'];
      }
      return null;
    } on FirebaseFunctionsException catch (e) {
      print('Firebase Functions Exception: ${e.message}');
      return null;
    } catch (e) {
      print('An unexpected error occurred while creating a deposit: $e');
      return null;
    }
  }
}
