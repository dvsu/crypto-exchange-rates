import 'package:crypto_converter/access/keys.dart';
import 'package:http/http.dart' as http;

class Networking {
  Future<dynamic> getExchangeRate({required String fiatCurrency}) async {
    var url = Uri.https('rest.coinapi.io', '/v1/exchangerate/$fiatCurrency',
        {'apikey': coinAPIKey, 'invert': 'true'});

    var response = await http.get(url);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      print(response.statusCode);
    }
  }
}
