import 'package:crypto_converter/access/keys.dart';
import 'package:http/http.dart' as http;

class Networking {
  //var url = Uri.https('https://rest.coinapi.io/v1/exchangerate/');

  Future<dynamic> getExchangeRate({required String fiatCurrency}) async {
    var url = Uri.https('rest.coinapi.io', '/v1/exchangerate/BTC/$fiatCurrency',
        {'apikey': coinAPIKey});

    var response = await http.get(url);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      print(response.statusCode);
    }
  }
}
