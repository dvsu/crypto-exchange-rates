import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:crypto_converter/currencies.dart';
import 'package:crypto_converter/widgets/currency_widgets.dart';
import 'package:crypto_converter/utilities/textstyling.dart';
import 'package:crypto_converter/utilities/color_palette.dart';
import 'package:crypto_converter/utilities/decorations.dart';
import 'package:crypto_converter/widgets/title_widgets.dart';
import 'package:crypto_converter/process/time_parser.dart';

class PricePage extends StatefulWidget {
  @override
  _PricePageState createState() => _PricePageState();
}

class _PricePageState extends State<PricePage> {
  String selectedCurrency = 'USD';
  int pickedCurrencyNumber = 0;
  bool isButtonDisabled = false;
  String updatedDateTime = '';
  Map<String, double> exchangeRates = {};

  void initState() {
    super.initState();
    updateCurrencyData();
  }

  void updateCurrencyData() async {
    var result = await CoinData().getExchangeRate(
      fiatCurrency: currenciesList[pickedCurrencyNumber],
    );

    if (result != null) {
      print(result);
      setState(() {
        for (Map<String, dynamic> currency in result["rates"]) {
          try {
            updatedDateTime =
                TimeParser().utcToLocalTimeAsString(currency["time"]);
            exchangeRates[currency["asset_id_quote"].toString()] =
                currency["rate"];
          } catch (e) {
            print(e);
          }
        }

        selectedCurrency = currenciesList[pickedCurrencyNumber];
        isButtonDisabled = true;
      });
    }
  }

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
              TitleWidget(titleName: 'CRYPTO CONVERTER'),
              Expanded(
                  flex: 1,
                  child: Center(
                    child: Text(
                      (updatedDateTime == '')
                          ? ''
                          : 'last update on $updatedDateTime',
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
                      rate: exchangeRates["BTC"]?.toStringAsFixed(0) ?? 'N/A',
                      cryptoImage: AssetImage('images/bitcoin.png'),
                    ),
                    CryptoRateWidget(
                      cryptoCurrency: 'ETH',
                      fiatCurrency: selectedCurrency,
                      rate: exchangeRates["ETH"]?.toStringAsFixed(0) ?? 'N/A',
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
                      rate: exchangeRates["LTC"]?.toStringAsFixed(1) ?? 'N/A',
                      cryptoImage: AssetImage('images/litecoin.png'),
                    ),
                    CryptoRateWidget(
                      cryptoCurrency: 'DOGE',
                      fiatCurrency: selectedCurrency,
                      rate: exchangeRates["DOGE"]?.toStringAsFixed(3) ?? 'N/A',
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
                        updateCurrencyData();
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
