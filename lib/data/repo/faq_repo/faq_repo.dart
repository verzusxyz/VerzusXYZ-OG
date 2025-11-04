import 'package:cloud_firestore/cloud_firestore.dart';

class FaqRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<QuerySnapshot> loadFaq() async {
    try {
      return await _firestore.collection('faq').orderBy('order').get();
    } catch (e) {
      print('Error loading FAQ: $e');
      rethrow;
    }
  }
}
