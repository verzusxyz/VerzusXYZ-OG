import 'package:verzusxyz/data/services/api_service.dart';

/// A repository class for handling splash screen-related data.
///
/// This class may be used to fetch initial data or configuration required
/// before the main application starts.
class SplashRepo {
  /// The API client for making HTTP requests.
  final ApiClient apiClient;

  /// Creates a new [SplashRepo] instance.
  ///
  /// Requires an [ApiClient] instance to communicate with the backend.
  SplashRepo({required this.apiClient});
}
