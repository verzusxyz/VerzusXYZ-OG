import 'package:cloud_firestore/cloud_firestore.dart';

class PrivacyRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<DocumentSnapshot> loadAboutData() async {
    try {
      return await _firestore.collection('policies').doc('privacy').get();
    } catch (e) {
      print('Error loading privacy policy: $e');
      rethrow;
    }
  }
}
