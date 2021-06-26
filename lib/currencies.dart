import 'dart:convert' as convert;
import 'package:crypto_converter/access/keys.dart';
import 'package:crypto_converter/network/networking.dart';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
  'DOGE',
];

class CoinData {
  Future<dynamic> getExchangeRate({required String fiatCurrency}) async {
    var url = Uri.https('rest.coinapi.io', '/v1/exchangerate/$fiatCurrency',
        {'apikey': coinAPIKey, 'invert': 'true'});

    try {
      Map<String, dynamic> result = convert.jsonDecode(
        await Networking().networkResponse(url: url),
      );

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
  }
}
