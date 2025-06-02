/// Application constants
class AppConstants {
  // App Info
  static const String appName = 'Flutter Clean Architecture BLoC Template';
  static const String appVersion = '1.0.0';

  // Storage Keys
  static const String counterValueKey = 'counter_value';
  static const String authTokenKey = 'auth_token';
  static const String userDataKey = 'user_data';

  // API
  static const String baseUrl = 'https://api.example.com';
  static const int connectTimeout = 30000; // 30 seconds
  static const int receiveTimeout = 30000; // 30 seconds

  // Authentication
  static const String defaultUsername = 'demo@example.com';
  static const String defaultPassword = 'password123';

  // UI
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;

  // Validation
  static const int minPasswordLength = 6;
  static const int maxUsernameLength = 50;
}
