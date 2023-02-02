import 'package:another_flutter_helper/src/http/models/response.dart';

abstract class HttpInstance {
  Future<Response> delete(Uri uri,
      {Map<String, dynamic>? queryParameters,
      Map<String, String>? headers,
      Map<String, dynamic>? body});

  Future<Response> get(Uri uri,
      {Map<String, dynamic>? queryParameters, Map<String, String>? headers});

  Future<Response> patch(Uri uri,
      {Map<String, dynamic>? queryParameters,
      Map<String, String>? headers,
      Map<String, dynamic>? body});

  Future<Response> post(Uri uri,
      {Map<String, dynamic>? queryParameters,
      Map<String, String>? headers,
      Map<String, dynamic>? body});

  Future<Response> put(Uri uri,
      {Map<String, dynamic>? queryParameters,
      Map<String, String>? headers,
      Map<String, dynamic>? body});
}
