import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

/// A service class for managing and providing access to global application settings.
class SettingsService extends GetxService {
  DocumentSnapshot? _settings;

  /// The global settings document.
  DocumentSnapshot? get settings => _settings;

  /// Sets the global settings document.
  void setSettings(DocumentSnapshot settings) {
    _settings = settings;
  }

  /// Whether the "agree to terms" policy is required.
  bool get needAgreePolicy => _settings?['needAgreePolicy'] ?? true;

  /// Whether to check for password strength.
  bool get checkPasswordStrength => _settings?['checkPasswordStrength'] ?? true;
}
