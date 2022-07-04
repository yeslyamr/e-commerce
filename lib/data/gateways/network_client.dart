import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:test_store_app/data/gateways/api_constants.dart';
import 'package:test_store_app/data/gateways/api_exceptions.dart';

class NetworkClient {
  final _client = http.Client();

  Uri _makeUri(String path, [Map<String, dynamic>? parameters]) {
    final uri = Uri.https(ApiConstants.baseUrl, path, parameters);
    return uri;
  }

  Future<T> get<T>(
      {required String path,
      required T Function(dynamic json) parser,
      Map<String, dynamic>? parameters,
      Map<String, String>? headers}) async {
    final url = _makeUri(path, parameters);
    try {
      //GET
      final response = await _client.get(url); //, headers: headers);

      if (response.statusCode == 200) {
        final jsonDecoded = jsonDecode(utf8.decode(response.bodyBytes));
        // serialising
        return parser(jsonDecoded);
      } else {
        throw ApiException(response.statusCode, response.body);
      }
    } on SocketException catch (e) {
      throw ApiException(1, e.message);
    } catch (e) {
      rethrow;
    }
  }
}
