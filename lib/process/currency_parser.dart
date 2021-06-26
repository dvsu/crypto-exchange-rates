import 'package:intl/intl.dart';
import 'package:crypto_converter/process/currencies.dart';

class CurrencyParser {
  String convertToCurrencyFormat(
      {double? value, required String targetCurrency}) {
    return (value != null)
        ? NumberFormat.currency(
                locale: currencyLocale[targetCurrency],
                symbol: currencySymbol[targetCurrency])
            .format(value)
        : '';
  }
}
