import 'dart:convert';
import 'package:extension_example/model/currency.dart';
import 'package:http/http.dart' as http;

class CryptoApi {
  static const _key = '1f4b5bdfcfc532698ecf0af1ee1be39338d18214'; // your key here

  static Future<List<Currency>> getCurrencies() async {
    final url =
        "https://api.nomics.com/v1/currencies/ticker?key=$_key&per-page=100";

    final response = await http.get(Uri.parse(url));
    final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();

    return parsed;
  }
}
