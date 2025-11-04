import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:verzusxyz/data/model/profile/profile_post_model.dart';

/// A repository class for handling user profile data with Firebase.
class ProfileRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Retrieves the profile information for the current user.
  ///
  /// - Returns a [DocumentSnapshot] containing the user's profile data.
  Future<DocumentSnapshot?> loadProfileInfo() async {
    try {
      final User? user = _auth.currentUser;
      if (user != null) {
        return await _firestore.collection('users').doc(user.uid).get();
      }
      return null;
    } catch (e) {
      print('An unexpected error occurred: $e');
      return null;
    }
  }

  /// Updates the profile information for the current user.
  ///
  /// - [model]: The updated profile data.
  /// - Returns `true` if the update is successful, otherwise `false`.
  Future<bool> updateProfile(ProfilePostModel model) async {
    try {
      final User? user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).update({
          'firstname': model.firstname,
          'lastname': model.lastName,
          'address': model.address,
          'zip': model.zip,
          'state': model.state,
          'city': model.city,
        });
        return true;
      }
      return false;
    } catch (e) {
      print('An unexpected error occurred: $e');
      return false;
    }
  }
}
