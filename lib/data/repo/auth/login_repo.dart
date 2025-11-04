import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

/// A repository class for handling user authentication with Firebase.
class LoginRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  /// Logs in a user with the given [email] and [password].
  ///
  /// - [email]: The user's email address.
  /// - [password]: The user's password.
  /// - Returns a [UserCredential] if the login is successful, otherwise `null`.
  Future<UserCredential?> loginUser(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
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

  /// Initiates the password reset process for the user.
  ///
  /// - [email]: The user's email address.
  Future<void> forgetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print('An unexpected error occurred: $e');
    }
  }

  /// Logs in a user using Google Sign-In.
  ///
  /// - Returns a [UserCredential] if the login is successful, otherwise `null`.
  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        // The user canceled the sign-in
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      return await _auth.signInWithCredential(credential);
    } catch (e) {
      print('An unexpected error occurred: $e');
      return null;
    }
  }
}
