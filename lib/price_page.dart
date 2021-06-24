import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:crypto_converter/currencies.dart';

class PricePage extends StatefulWidget {
  @override
  _PricePageState createState() => _PricePageState();
}

class _PricePageState extends State<PricePage> {
  String? selectedCurrency = 'USD';

  // a list of currency for Material design
  DropdownButton<String> getAndroidCurrencyDropdownList() {
    // iterate using for-in loop
    List<DropdownMenuItem<String>> currencyItemList = [];

    for (String currency in currenciesList) {
      currencyItemList
          .add(DropdownMenuItem(child: Text(currency), value: currency));
    }

    // alternatively, using map() method
    // return currenciesList.map((String value) {
    //   return DropdownMenuItem<String>(
    //     value: value,
    //     child: Text(
    //       value,
    //     ),
    //   );
    // }).toList();

    // dropdown (Material style)
    return DropdownButton<String>(
      value: selectedCurrency,
      items: currencyItemList,
      onChanged: (value) {
        print(value);
        setState(() {
          selectedCurrency = value;
        });
      },
    );
  }

  // a list of currency for Cupertino design
  CupertinoPicker getIOSCurrencyPicker() {
    List<Text> currencies = [];

    for (String currency in currenciesList) {
      currencies.add(Text(
        currency,
        style: TextStyle(
          fontSize: 20.0,
          color: Color(0xff121212),
        ),
      ));
    }

    return CupertinoPicker(
      useMagnifier: true,
      itemExtent: 35.0,
      onSelectedItemChanged: (selectedItem) {
        print(selectedItem);
      },
      children: currencies,
      magnification: 1.1,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Color(0xfff1f1f1),
      //   brightness: ,
      //   elevation: 0.0,
      //   title: Text('Crypto Converter'),
      // ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            gradient: RadialGradient(
              // begin: Alignment.topLeft,
              // end: Alignment.bottomRight,
              center: Alignment(-0.7, -2.1),
              radius: 2.7,
              stops: [
                0.6,
                0.8,
                1.1,
              ],
              colors: [
                Color(0xccfefefe),
                Color(0xffd6fbff),
                Color(0xffeec2ff),
              ],
            ),
          ),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                  flex: 2,
                  child: Center(
                    child: Text(
                      'Crypto Converter',
                      style: TextStyle(
                        fontSize: 25.0,
                      ),
                    ),
                  )),
              Expanded(
                  flex: 1,
                  child: Center(
                    child: Text('last update on xx:xx'),
                  )),
              Expanded(
                flex: 5,
                child: Row(
                  children: [
                    CryptoRateWidget(
                      cryptoCurrency: 'BTC',
                      fiatCurrency: 'USD',
                      rate: '32,123',
                    ),
                    CryptoRateWidget(
                      cryptoCurrency: 'ETH',
                      fiatCurrency: 'USD',
                      rate: '3,123',
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 5,
                child: Row(
                  children: [
                    CryptoRateWidget(
                      cryptoCurrency: 'LTC',
                      fiatCurrency: 'USD',
                      rate: '123.12',
                    ),
                    CryptoRateWidget(
                      cryptoCurrency: 'DOGE',
                      fiatCurrency: 'USD',
                      rate: '0.12',
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  height: 150.0,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(bottom: 30.0),
                  child: getIOSCurrencyPicker(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CryptoRateWidget extends StatelessWidget {
  final String cryptoCurrency;
  final String fiatCurrency;
  final String rate;

  const CryptoRateWidget(
      {required this.cryptoCurrency,
      required this.fiatCurrency,
      required this.rate});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            gradient: RadialGradient(
              // begin: Alignment.topLeft,
              // end: Alignment.bottomRight,
              center: Alignment(-0.5, -1.9),
              radius: 2.0,
              stops: [
                0.3,
                0.55,
                0.95,
              ],
              colors: [
                Color(0xccfefefe),
                Color(0xddffffeb),
                Color(0xee9cf7eb),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(2, 2), // changes position of shadow
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    '$cryptoCurrency$fiatCurrency',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Color(0xff454545),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Icon(
                    Icons.circle,
                    size: 40.0,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    '$rate',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 50.0,
                      color: Color(0xff383838),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
