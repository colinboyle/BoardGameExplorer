class ApiException implements Exception {
  final _message;
  final prefix;
  
ApiException([this._message, this.prefix]);
  
String toString() {
    return "$prefix$_message";
  }
}

class FetchDataException extends ApiException {
  FetchDataException([String message]) : super(message, "Error During Communication: ");
}

class BadRequestException extends ApiException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class AcceptedProcessingException extends ApiException {
  AcceptedProcessingException([message]) : super(message, "Accepted Request: ");
}

class UnauthorisedException extends ApiException {
  UnauthorisedException([message]) : super(message, "Unauthorised: ");
}

class InvalidInputException extends ApiException {
  InvalidInputException([String message]) : super(message, "Invalid Input: ");
}