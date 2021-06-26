import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:crypto_converter/currencies.dart';
import 'package:crypto_converter/widgets/dashboard_widgets.dart';
import 'package:crypto_converter/utilities/textstyling.dart';
import 'package:crypto_converter/utilities/color_palette.dart';
import 'package:crypto_converter/utilities/decorations.dart';
import 'package:crypto_converter/network/networking.dart';

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
      currencies.add(
        Text(
          currency,
          style: currencyTextStyle,
        ),
      );
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
          decoration: mainPageBackgroundDecoration,
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                  flex: 2,
                  child: Center(
                    child: Text(
                      'CRYPTO CONVERTER',
                      style: mainTitleTextStyle,
                    ),
                  )),
              Expanded(
                  flex: 1,
                  child: Center(
                    child: Text(
                      'last update on 25 June 2021, 12:34:56',
                      textAlign: TextAlign.center,
                      style: statusTextStyle,
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
                      onPressed: () async {
                        Networking network = Networking();

                        var result = await network.getExchangeRate(
                          fiatCurrency: currenciesList[pickedCurrencyNumber],
                        );

                        if (result != null) {
                          print(result);
                        }

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
                        style: convertButtonTextStyle,
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
