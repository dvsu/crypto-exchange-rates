import 'package:flutter/material.dart';
import 'package:crypto_converter/price_page.dart';

void main() {
  runApp(CryptoConverterApp());
}

class CryptoConverterApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Crypto Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PricePage(),
    );
  }
}
