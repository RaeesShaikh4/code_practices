class AppException implements Exception {
  final String message;
  const AppException(this.message);

  @override
  String toString() => 'AppException: $message';
}

class NetworkException extends AppException {
  const NetworkException([String message = 'Network error occurred'])
      : super(message);
}

class ServerException extends AppException {
  final int statusCode;
  const ServerException({required this.statusCode, required String message})
      : super(message);
}
