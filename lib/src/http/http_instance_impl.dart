import 'package:another_flutter_helper/src/http/http_instance.dart';
import 'package:another_flutter_helper/src/http/models/response.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class HttpInstanceImpl extends HttpInstance {
  @override
  Future<Response> delete(Uri uri,
      {Map<String, dynamic>? queryParameters,
      Map<String, String>? headers,
      Map<String, dynamic>? body}) async {
    final http.Response response = await http.delete(uri, headers: headers);

    final Map<String, dynamic> result = {
      'statusCode': response.statusCode,
      'body': response.body,
      'headers': response.headers,
    };

    _logger(
      method: 'DELETE',
      uri: uri,
      headers: headers,
      responseBody: response.body,
      queryParameters: queryParameters,
      statusCode: response.statusCode,
    );

    return Response.fromJson(result);
  }

  @override
  Future<Response> get(Uri uri,
      {Map<String, dynamic>? queryParameters,
      Map<String, String>? headers}) async {
    final http.Response response = await http.get(uri, headers: headers);

    final Map<String, dynamic> result = {
      'statusCode': response.statusCode,
      'body': response.body,
      'headers': response.headers,
    };

    _logger(
      method: 'GET',
      uri: uri,
      headers: headers,
      responseBody: response.body,
      queryParameters: queryParameters,
      statusCode: response.statusCode,
    );

    return Response.fromJson(result);
  }

  @override
  Future<Response> patch(Uri uri,
      {Map<String, dynamic>? queryParameters,
      Map<String, String>? headers,
      Map<String, dynamic>? body}) async {
    final http.Response response = await http.patch(uri, headers: headers);

    final Map<String, dynamic> result = {
      'statusCode': response.statusCode,
      'body': response.body,
      'headers': response.headers,
    };

    _logger(
      method: 'PATCH',
      uri: uri,
      headers: headers,
      responseBody: response.body,
      queryParameters: queryParameters,
      payload: body,
    );

    return Response.fromJson(result);
  }

  @override
  Future<Response> post(Uri uri,
      {Map<String, dynamic>? queryParameters,
      Map<String, String>? headers,
      Map<String, dynamic>? body}) async {
    final http.Response response =
        await http.post(uri, headers: headers, body: body);

    final Map<String, dynamic> result = {
      'statusCode': response.statusCode,
      'body': response.body,
      'headers': response.headers,
    };

    _logger(
      method: 'POST',
      uri: uri,
      headers: headers,
      responseBody: response.body,
      queryParameters: queryParameters,
      payload: body,
      statusCode: response.statusCode,
    );

    return Response.fromJson(result);
  }

  @override
  Future<Response> put(Uri uri,
      {Map<String, dynamic>? queryParameters,
      Map<String, String>? headers,
      Map<String, dynamic>? body}) async {
    final http.Response response =
        await http.put(uri, headers: headers, body: body);

    final Map<String, dynamic> result = {
      'statusCode': response.statusCode,
      'body': response.body,
      'headers': response.headers,
    };

    _logger(
      method: 'PUT',
      uri: uri,
      headers: headers,
      responseBody: response.body,
      queryParameters: queryParameters,
      payload: body,
      statusCode: response.statusCode,
    );

    return Response.fromJson(result);
  }

  void _logger({
    required String method,
    required Uri uri,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    Map<String, dynamic>? payload,
    String? responseBody,
    int? statusCode,
  }) {
    if (kDebugMode) {
      final endpoint = '${uri.scheme}://${uri.host}${uri.path}';
      print(
          '[$method]\nStatus Code: ($statusCode)\nEndpoint: $endpoint\n${headers != null ? 'Headers: $headers' : ''}\n${payload != null ? 'Payload: $payload' : ''}\nResponse: $responseBody\n${queryParameters != null ? 'Query Parameters: $queryParameters' : ''}');
    }
  }
}
