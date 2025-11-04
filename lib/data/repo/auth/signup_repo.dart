import 'package.cloud_firestore/cloud_firestore.dart';
import 'package.firebase_auth/firebase_auth.dart';
import 'package.verzusxyz/data/model/auth/sign_up_model/sign_up_model.dart';

/// A repository class for handling user registration with Firebase.
class RegistrationRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Registers a new user with the provided [SignUpModel].
  ///
  /// - [model]: The user's registration data.
  /// - Returns a [UserCredential] if the registration is successful, otherwise `null`.
  Future<UserCredential?> registerUser(SignUpModel model) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: model.email,
        password: model.password,
      );

      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'firstName': model.firstName,
        'lastName': model.lastName,
        'email': model.email,
        'reference': model.refference,
        'liveBalance': 0,
        'demoBalance': 1000,
      });

      return userCredential;
    } on FirebaseAuthException catch (e) {
      // Handle Firebase-specific exceptions
      print('Firebase Auth Exception: ${e.message}');
      return null;
    } catch (e) {
      // Handle other exceptions
      print('An unexpected error occurred: $e');
      return null;
    }
  }
}
