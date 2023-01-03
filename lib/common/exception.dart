class ServerException implements Exception {}

class PreferenceException implements Exception {
  final String message;

  PreferenceException(this.message);
}
