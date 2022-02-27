import 'dart:convert';

import 'package:http/http.dart';

class Network {
  static String BASE = 'api.github.com';
  static String API_GET = '/users/khurshid88';

  static Future<String?> GET(String api) async {
    var uri = Uri.https(BASE, api);
    var response = await get(uri);
    if(response.statusCode == 200) return response.body;
    return null;
  }
  static Map<String, String> paramsEmpty() {
    Map<String, String> params = {};
    return params;
  }
}