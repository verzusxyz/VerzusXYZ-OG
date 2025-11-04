import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:verzusxyz/data/model/kyc/kyc_response_model.dart';

class KycRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<KycResponseModel> getKycData() async {
    final User? user = _auth.currentUser;
    if (user == null) {
      return KycResponseModel(
          status: 'error', message: 'User not logged in');
    }

    final DocumentSnapshot doc =
        await _firestore.collection('kyc').doc(user.uid).get();

    if (doc.exists) {
      return KycResponseModel.fromJson(doc.data() as Map<String, dynamic>);
    } else {
      return KycResponseModel(status: 'pending', message: 'No KYC data found');
    }
  }

  Future<void> submitKycData(Map<String, dynamic> data, Map<String, File> files) async {
    final User? user = _auth.currentUser;
    if (user == null) {
      throw Exception('User not logged in');
    }

    final Map<String, String> fileUrls = {};
    for (final entry in files.entries) {
      final ref = _storage.ref().child('kyc/${user.uid}/${entry.key}');
      final uploadTask = ref.putFile(entry.value);
      final snapshot = await uploadTask.whenComplete(() {});
      final downloadUrl = await snapshot.ref.getDownloadURL();
      fileUrls[entry.key] = downloadUrl;
    }

    await _firestore.collection('kyc').doc(user.uid).set({
      ...data,
      ...fileUrls,
      'status': 'submitted',
      'submittedAt': FieldValue.serverTimestamp(),
    });
  }
}
