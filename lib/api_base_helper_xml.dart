import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;
import './api_exceptions.dart';

class ApiBaseHelper {
  final String _baseUrl = "https://www.boardgamegeek.com/";
  final String _baseJSONUrl = "https://api.geekdo.com/api/";

  Future<dynamic> get(String url) async {
      var responseXml;
      print('helper hitting url');
      print(_baseUrl + url);
      try {
        final response = await http.get(_baseUrl + url);
        responseXml = _returnResponse(response);
      } on SocketException {
        throw FetchDataException('No Internet connection');
      }
      return responseXml;
  }

  Future<dynamic> getJSON(String url) async {
      var responseJSON;
      print('helper hitting url for JSON');
      print(_baseJSONUrl + url);
      try {
        final response = await http.get(_baseJSONUrl + url);
        responseJSON = _returnResponseJSON(response);
      } on SocketException {
        throw FetchDataException('No Internet connection');
      }
      return responseJSON;
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseXml = xml.parse(response.body);
        //print(responseXml);
        return responseXml;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }

  dynamic _returnResponseJSON(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJSON =  response.body;//);
        //print(responseXml);
        return responseJSON;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}