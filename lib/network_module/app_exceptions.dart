class AppException implements Exception {
  final message, prefix, url;

  AppException([this.message, this.prefix, this.url]);
}

class BadRequestException extends AppException {
  BadRequestException([String? message, String? url])
      : super(message, 'Bad Request', url);
}

class UnprocessableEntity extends AppException {
  UnprocessableEntity([String? message, String? url])
      : super(message, 'Incorrect Details', url);
}

class FetchDataException extends AppException {
  FetchDataException([String? message, String? url])
      : super(message, 'Bad Request', url);
}

class ApiNotRespondingException extends AppException {
  ApiNotRespondingException([String? message, String? url])
      : super(message, 'Bad Request', url);
}

class UnAuthorizedException extends AppException {
  UnAuthorizedException([String? message, String? url])
      : super(message, 'Expired Session', url);
}

class ServerException extends AppException {
  ServerException([String? message, String? url])
      : super(message, 'Server undergoing maintenance', url);
}

class PageNotFoundException extends AppException {
  PageNotFoundException([String? message, String? url])
      : super(message, 'Page not found, please try again!', url);
}
