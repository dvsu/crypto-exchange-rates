import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:crypto_converter/currencies.dart';
import 'package:crypto_converter/utilities/textstyling.dart';

// List of DropdownMenuItem widgets to be used for MaterialCurrencyPicker
final List<DropdownMenuItem<String>> currencyItemList = [
  for (String currency in currenciesList)
    DropdownMenuItem(
      child: Text(
        currency,
        style: currencyTextStyle,
      ),
      value: currency,
    )
];

// alternatively, using map() method
// final List<DropdownMenuItem<String>> currencyItemList = currenciesList
//     .map(
//       (String value) => DropdownMenuItem<String>(
//         value: value,
//         child: Text(
//           value,
//         ),
//       ),
//     )
//     .toList();

// List of Text widgets to be used for CupertinoCurrencyPicker
final List<Text> currencyPicker = [
  for (String currency in currenciesList)
    Text(
      currency,
      style: currencyTextStyle,
    )
];

// a list of currency for Material design
class MaterialCurrencyPicker extends StatelessWidget {
  const MaterialCurrencyPicker(
      {required this.initialCurrency, required this.onChanged});
  final String initialCurrency;
  final Function(String?) onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: initialCurrency,
      items: currencyItemList,
      onChanged: onChanged,
    );
  }
}

// a list of currency for Cupertino design
class CupertinoCurrencyPicker extends StatelessWidget {
  const CupertinoCurrencyPicker({required this.onSelectedItem});

  final Function(int) onSelectedItem;

  @override
  Widget build(BuildContext context) {
    return CupertinoPicker(
      useMagnifier: true,
      itemExtent: 35.0,
      onSelectedItemChanged: onSelectedItem,
      children: currencyPicker,
      magnification: 1.1,
      looping: true,
    );
  }
}
