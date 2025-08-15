/// API Constants
///
/// Contains all API endpoints and configuration
class ApiConstants {
  ApiConstants._();

  // Base URLs
  static const String host = '192.168.0.69';
  static const String baseUrl = 'http://$host:8000';

  // Image URLs
  static const String imageBaseUrl = '$baseUrl/storage/products/';

  // Endpoints
  static const String loginUrl = '/api/login';
  static const String logoutUrl = '/api/logout';
  static const String registerUrl = '/api/register';

  // Headers
  static const Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  // Timeouts
  static const int connectTimeout = 30000; // 30 seconds
  static const int receiveTimeout = 30000; // 30 seconds
  static const int sendTimeout = 30000; // 30 seconds

  // Retry configuration
  static const int maxRetries = 3;
  static const Duration retryDelay = Duration(seconds: 2);
}
