import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:star_wars_wiki/core/utils/constants.dart';

class HttpHelper {
  Future<Map<String, dynamic>> invokeHttp(
    String path,
    RequestType type, {
    Map<String, String>? headers,
    dynamic? body,
    Map<String, dynamic>? queryParameters,
    Encoding? encoding,
    Uri? customUri,
  }) async {
    http.Response response;
    Map<String, dynamic> responseBody;

    try {
      Uri uri = customUri ??
          Uri.https(
            Constants.swUrl,
            Constants.swApiPath + path,
            queryParameters,
          );

      response = await _invoke(
        uri,
        type,
        headers: headers,
        body: body,
        encoding: encoding,
      );
    } catch (error) {
      rethrow;
    }

    responseBody = jsonDecode(response.body);
    return responseBody;
  }

  /// Invoke the `http` request, returning the [http.Response] unparsed.
  Future<http.Response> _invoke(
    Uri uri,
    RequestType type, {
    Map<String, String>? headers,
    dynamic? body,
    Encoding? encoding,
  }) async {
    http.Response response;

    try {
      switch (type) {
        case RequestType.get:
          response = await http.get(
            uri,
            headers: headers,
          );
          break;
        case RequestType.post:
          response = await http.post(
            uri,
            headers: headers,
            body: body,
            encoding: encoding,
          );
          break;
        case RequestType.put:
          response = await http.put(
            uri,
            headers: headers,
            body: body,
            encoding: encoding,
          );
          break;
        case RequestType.delete:
          response = await http.delete(
            uri,
            headers: headers,
          );
          break;
      }

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ApiException();
      }

      return response;
    } on SocketException {
      rethrow;
    } catch (error) {
      rethrow;
    }
  }
}

class ApiException implements Exception {}

// types used by the helper
enum RequestType { get, post, put, delete }
