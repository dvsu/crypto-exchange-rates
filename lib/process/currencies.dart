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

Map<String, String> currencyLocale = {
  'AUD': 'en_AU',
  'BRL': 'pt_BR',
  'CAD': 'en_CA',
  'CNY': 'zh_CN',
  'EUR': 'en_150',
  'GBP': 'en_GB',
  'HKD': 'en_HK',
  'IDR': 'in_ID',
  'ILS': 'iw_IL',
  'INR': 'en_IN',
  'JPY': 'ja_JP',
  'MXN': 'es_MX',
  'NOK': 'nb_NO',
  'NZD': 'en_NZ',
  'PLN': 'pl_PL',
  'RON': 'ro_RO',
  'RUB': 'ru_RU',
  'SEK': 'sv_SE',
  'SGD': 'en_SG',
  'USD': 'en_US',
  'ZAR': 'en_ZA'
};

Map<String, String> currencySymbol = {
  'AUD': '\$',
  'BRL': 'R\$',
  'CAD': '\$',
  'CNY': '¥',
  'EUR': '€',
  'GBP': '£',
  'HKD': 'HK\$',
  'IDR': 'Rp',
  'ILS': '₪',
  'INR': '₹',
  'JPY': '¥',
  'MXN': '\$',
  'NOK': 'kr',
  'NZD': '\$',
  'PLN': 'zl',
  'RON': 'lei',
  'RUB': '₽',
  'SEK': 'kr',
  'SGD': '\$',
  'USD': '\$',
  'ZAR': 'R'
};

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

    // try {
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
    // } catch (e) {
    //   print(e);
    // }
  }
}
