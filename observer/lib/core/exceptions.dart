class CustomException implements Exception {}

class ObserverException extends CustomException {}

class ObserverAlreadyClosedException extends ObserverException {}
