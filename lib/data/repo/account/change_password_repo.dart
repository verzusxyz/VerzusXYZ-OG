import 'package:firebase_auth/firebase_auth.dart';
import 'package:verzusxyz/view/components/snack_bar/show_custom_snackbar.dart';
import 'package:get/get.dart';
import 'package:verzusxyz/core/utils/my_strings.dart';

class ChangePasswordRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> changePassword(String currentPass, String newPass) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        AuthCredential credential = EmailAuthProvider.credential(
          email: user.email!,
          password: currentPass,
        );
        await user.reauthenticateWithCredential(credential);
        await user.updatePassword(newPass);
        CustomSnackBar.success(successList: [MyStrings.passwordChanged.tr]);
        return true;
      }
      return false;
    } on FirebaseAuthException catch (e) {
      CustomSnackBar.error(errorList: [e.message ?? MyStrings.requestFail.tr]);
      return false;
    }
  }
}
