import 'package:http/http.dart' as http;
import 'dart:convert';

class Requisition {
  static Future<Map> fetch() async {
    http.Response response = await http.get(Uri.http('api.hgbrasil.com', '/finance', {'key': '2e37582e', 'format': 'json'}));
    return json.decode(response.body);
  }
}