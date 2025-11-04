import 'package:cloud_firestore/cloud_firestore.dart';

class AllGamesRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<QuerySnapshot> loadData() async {
    try {
      return await _firestore.collection('games').get();
    } catch (e) {
      print('Error loading games: $e');
      rethrow;
    }
  }
}
