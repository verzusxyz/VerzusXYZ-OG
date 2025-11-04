import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// A repository class for handling game logs with Firebase.
class GameLogRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Retrieves the game logs for the current user.
  ///
  /// - Returns a list of [QueryDocumentSnapshot]s representing the game logs.
  Future<List<QueryDocumentSnapshot>> getGameLogs() async {
    try {
      final User? user = _auth.currentUser;
      if (user != null) {
        final QuerySnapshot querySnapshot = await _firestore
            .collection('gameLogs')
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
