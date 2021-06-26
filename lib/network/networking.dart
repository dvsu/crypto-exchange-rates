import 'package:crypto_converter/access/keys.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Networking {
  Future<dynamic> getExchangeRate({required String fiatCurrency}) async {
    var url = Uri.https('rest.coinapi.io', '/v1/exchangerate/$fiatCurrency',
        {'apikey': coinAPIKey, 'invert': 'true'});

    var response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> result = convert.jsonDecode(response.body);

      try {
        return {
          "asset_id_base": result["asset_id_base"],
          "rates": result["rates"]
              .where((d) =>
                  d["asset_id_quote"] == "BTC" ||
                  d["asset_id_quote"] == "ETH" ||
                  d["asset_id_quote"] == "LTC" ||
                  d["asset_id_quote"] == "DOGE")
              .toList()
        };
      } catch (e) {
        print(e);
      }
    } else {
      print(response.statusCode);
    }
  }
}
