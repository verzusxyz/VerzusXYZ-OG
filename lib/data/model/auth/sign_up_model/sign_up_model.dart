import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpModel {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String refference;
  final bool? agree;

  SignUpModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    this.refference = "",
    required this.agree,
  });

  Map<String, dynamic> toMap() {
    return {
      'firstname': firstName,
      'lastname': lastName,
      'email': email,
      'password': password,
      'password_confirmation': password,
      'reference': refference,
      'agree': agree.toString() == 'true' ? 'true' : '',
    };
  }

  factory SignUpModel.fromMap(Map<String, dynamic> map) {
    return SignUpModel(
      firstName: map['firstname'] as String,
      lastName: map['lastname'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      refference: map['reference'] as String,
      agree: map['agree'] as bool,
    );
  }

  factory SignUpModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return SignUpModel(
      firstName: data['firstName'] ?? '',
      lastName: data['lastName'] ?? '',
      email: data['email'] ?? '',
      password: '', // Password should not be stored in Firestore
      refference: data['reference'] ?? '',
      agree: false, // This is not stored in Firestore
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'reference': refference,
      'balance': 0, // Initial balance
    };
  }
}
