import 'package:flutter/material.dart';

void main() {
  runApp(CryptoConverterApp());
}

class CryptoConverterApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crypto Exchange Rates',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: MyHomePage(title: 'Crypto Exchange Rates'),
    );
  }
}
