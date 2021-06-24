import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:crypto_converter/currencies.dart';

class PricePage extends StatefulWidget {
  @override
  _PricePageState createState() => _PricePageState();
}

class _PricePageState extends State<PricePage> {
  String selectedCurrency = 'USD';
  int pickedCurrencyNumber = 0;
  bool isButtonDisabled = false;

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
          if (value != null) {
            selectedCurrency = value;
          }
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
          fontSize: 24.0,
          fontFamily: 'Barlow',
          fontWeight: FontWeight.w500,
          color: Color(0xff121212),
        ),
      ));
    }

    return CupertinoPicker(
      useMagnifier: true,
      itemExtent: 35.0,
      onSelectedItemChanged: (selectedItem) {
        print(selectedItem);
        setState(() {
          pickedCurrencyNumber = selectedItem;
          if (currenciesList[pickedCurrencyNumber] != selectedCurrency) {
            isButtonDisabled = false;
          } else {
            isButtonDisabled = true;
          }
        });
      },
      children: currencies,
      magnification: 1.1,
      looping: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            gradient: RadialGradient(
              center: Alignment(-1.5, -2.0),
              radius: 2.2,
              stops: [
                0.2,
                1.8,
              ],
              colors: [
                Color(0xbbd6fbff),
                Color(0xccfefefe),
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
                      'CRYPTO CONVERTER',
                      style: TextStyle(
                        fontFamily: 'Anaheim',
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0,
                      ),
                    ),
                  )),
              Expanded(
                  flex: 1,
                  child: Center(
                    child: Text(
                      'last update on 25 June 2021, 12:34:56',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Barlow',
                        fontWeight: FontWeight.w400,
                        fontSize: 13.0,
                      ),
                    ),
                  )),
              Expanded(
                flex: 7,
                child: Row(
                  children: [
                    CryptoRateWidget(
                      cryptoCurrency: 'BTC',
                      fiatCurrency: selectedCurrency,
                      rate: '23,456',
                      cryptoImage: AssetImage('images/bitcoin.png'),
                    ),
                    CryptoRateWidget(
                      cryptoCurrency: 'ETH',
                      fiatCurrency: selectedCurrency,
                      rate: '3,123',
                      cryptoImage: AssetImage('images/ethereum.png'),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 7,
                child: Row(
                  children: [
                    CryptoRateWidget(
                      cryptoCurrency: 'LTC',
                      fiatCurrency: selectedCurrency,
                      rate: '123.12',
                      cryptoImage: AssetImage('images/litecoin.png'),
                    ),
                    CryptoRateWidget(
                      cryptoCurrency: 'DOGE',
                      fiatCurrency: selectedCurrency,
                      rate: '0.12',
                      cryptoImage: AssetImage('images/doge.png'),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  height: 150.0,
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10.0),
                  child: getIOSCurrencyPicker(),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 5.0,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      gradient: LinearGradient(
                        begin: Alignment(-1.5, -1.0),
                        end: Alignment.bottomRight,
                        stops: [-1.0, 1.2],
                        colors: [
                          (isButtonDisabled == true)
                              ? Color(0xbbaaaaaa)
                              : Color(0xbb38e2f5),
                          (isButtonDisabled == true)
                              ? Color(0xbbaaaaaa)
                              : Color(0xbbbe31f5),
                        ],
                      ),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedCurrency =
                              currenciesList[pickedCurrencyNumber];
                          isButtonDisabled = true;
                        });
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.transparent),
                        shadowColor:
                            MaterialStateProperty.all(Colors.transparent),
                        overlayColor: (isButtonDisabled == true)
                            ? MaterialStateProperty.all(Colors.transparent)
                            : MaterialStateProperty.all(Color(0x5538e2f5)),
                      ),
                      child: Text(
                        'CONVERT',
                        style: TextStyle(
                          color: Color(0xfff1f1f1),
                          fontFamily: 'Anaheim',
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
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
  final AssetImage cryptoImage;

  const CryptoRateWidget(
      {required this.cryptoCurrency,
      required this.fiatCurrency,
      required this.rate,
      required this.cryptoImage});

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
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      '$cryptoCurrency$fiatCurrency',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 23.0,
                        color: Color(0xff454545),
                        fontFamily: 'Anaheim',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Image(image: cryptoImage),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      '$rate',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 32.0,
                        color: Color(0xff383838),
                        fontFamily: 'Anaheim',
                        fontWeight: FontWeight.bold,
                      ),
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
