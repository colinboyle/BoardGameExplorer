class ApiException implements Exception {
  final _message;
  final _prefix;
  final statusCode;
  
ApiException([this._message, this._prefix, this.statusCode]);
  
String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends ApiException {
  FetchDataException([String message, int statusCode]) : super(message, "Error During Communication: ", statusCode);
}

class BadRequestException extends ApiException {
  BadRequestException([message, int statusCode]) : super(message, "Invalid Request: ", statusCode);
}

class AcceptedProcessingException extends ApiException {
  AcceptedProcessingException([message, int statusCode]) : super(message, "Accepted Request: ", statusCode);
}

class UnauthorisedException extends ApiException {
  UnauthorisedException([message, int statusCode]) : super(message, "Unauthorised: ", statusCode);
}

class InvalidInputException extends ApiException {
  InvalidInputException([String message, int statusCode]) : super(message, "Invalid Input: ", statusCode);
}