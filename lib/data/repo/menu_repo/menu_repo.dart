import 'package:firebase_auth/firebase_auth.dart';
import 'package:verzusxyz/core/helper/shared_preference_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class MenuRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> logout() async {
    await _auth.signOut();
    await clearSharedPrefData();
  }

  Future<void> clearSharedPrefData() async {
    final SharedPreferences sharedPreferences = Get.find();
    await sharedPreferences.remove(SharedPreferenceHelper.userNameKey);
    await sharedPreferences.remove(SharedPreferenceHelper.fullNameKey);
    await sharedPreferences.remove(SharedPreferenceHelper.userEmailKey);
    await sharedPreferences.remove(SharedPreferenceHelper.rememberMeKey);
  }

  Future<void> removeAccount() async {
    try {
      await _auth.currentUser?.delete();
      await clearSharedPrefData();
    } catch (e) {
      print('Error removing account: $e');
      rethrow;
    }
  }
}
