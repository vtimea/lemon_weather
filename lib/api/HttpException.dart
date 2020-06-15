class HTTPException implements Exception {
  final int statusCode;
  final String message;

  HTTPException(this.statusCode, this.message) : assert(statusCode != null);

  @override
  String toString() {
    return 'HTTPException{code: $statusCode, message: $message}';
  }
}
