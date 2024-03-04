import 'dart:async';

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../error/exception.dart';

abstract class BaseApiClient {
  Future<dynamic> get(String url);
}

class ApiClient extends BaseApiClient {
  final http.Client client;
  int timeOutDuration = 35;

  ApiClient({ required this.client});

  Future<dynamic> get(String url) async {
    var uri = Uri.parse(url);
    try {
      var response =
      await http.get(uri).timeout(Duration(seconds: timeOutDuration));
      return _processResponse(response);
    } catch (e) {
      throw ExceptionHandlers().getExceptionString(e);
    }
  }

  dynamic _processResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = response.body;
        return responseJson;
      case 400: //Bad request
        throw BadRequestException(jsonDecode(response.body)['message']);
      case 401: //Unauthorized
        throw UnAuthorizedException(jsonDecode(response.body)['message']);
      case 403: //Forbidden
        throw UnAuthorizedException(jsonDecode(response.body)['message']);
      case 404: //Resource Not Found
        throw NotFoundException(jsonDecode(response.body)['message']);
      case 500: //Internal Server Error
      default:
        throw FetchDataException(
            'Something went wrong! ${response.statusCode}');
    }
  }
}