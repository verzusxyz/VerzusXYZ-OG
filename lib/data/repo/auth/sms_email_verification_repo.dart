import 'package:firebase_auth/firebase_auth.dart';
import 'package:verzusxyz/view/components/snack_bar/show_custom_snackbar.dart';
import 'package:get/get.dart';
import 'package:verzusxyz/core/utils/my_strings.dart';

class SmsEmailVerificationRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> sendVerificationEmail() async {
    try {
      User? user = _auth.currentUser;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
        CustomSnackBar.success(successList: [MyStrings.verificationEmailSent.tr]);
        return true;
      }
      return false;
    } catch (e) {
      CustomSnackBar.error(errorList: [MyStrings.requestFail.tr]);
      return false;
    }
  }

  Future<bool> isEmailVerified() async {
    try {
      await _auth.currentUser?.reload();
      return _auth.currentUser?.emailVerified ?? false;
    } catch (e) {
      return false;
    }
  }
}
