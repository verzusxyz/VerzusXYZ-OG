import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<DocumentSnapshot?> getUserData() async {
    try {
      final User? user = _auth.currentUser;
      if (user != null) {
        return await _firestore.collection('users').doc(user.uid).get();
      }
      return null;
    } catch (e) {
      print('Error loading user data: $e');
      rethrow;
    }
  }

  Future<QuerySnapshot> getGames() async {
    try {
      return await _firestore.collection('games').get();
    } catch (e) {
      print('Error loading games: $e');
      rethrow;
    }
  }
}
