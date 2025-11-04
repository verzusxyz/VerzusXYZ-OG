import 'package:cloud_firestore/cloud_firestore.dart';

/// A repository class for handling global application settings with Firebase.
class SettingsRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Retrieves the global settings document from Firestore.
  ///
  /// - Returns a [DocumentSnapshot] containing the global settings.
  Future<DocumentSnapshot> getSettings() async {
    try {
      return await _firestore.collection('settings').doc('global').get();
    } catch (e) {
      print('An unexpected error occurred while fetching settings: $e');
      rethrow;
    }
  }
}
