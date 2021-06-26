import 'package:crypto_converter/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:crypto_converter/process/currencies.dart';
import 'package:crypto_converter/widgets/currency_widgets.dart';
import 'package:crypto_converter/utilities/textstyling.dart';
import 'package:crypto_converter/utilities/decorations.dart';
import 'package:crypto_converter/widgets/currency_selector.dart';
import 'package:crypto_converter/widgets/title_widgets.dart';
import 'package:crypto_converter/process/time_parser.dart';
import 'package:crypto_converter/process/currency_parser.dart';

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
    try {
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
    } catch (e) {
      print(e);
      showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Network Connection Error'),
              content: SingleChildScrollView(
                padding: EdgeInsets.all(0.0),
                child: ListBody(
                  children: <Widget>[
                    Text('$e'),
                    Text(
                        'Ensure either mobile network or WiFi is connected to the internet.'),
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        child: const Text('Okay'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              // actions: <Widget>[
              //   SizedBox(
              //     width: double.infinity,
              //     child: TextButton(
              //       child: const Text('Okay'),
              //       onPressed: () {
              //         Navigator.of(context).pop();
              //       },
              //     ),
              //   ),
              // ],
              contentPadding: EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 0.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
            );
          });
    }
  }

  void onChangedMaterialCurrencyPicker(String? pickedValue) {
    print(pickedValue);
    setState(() {
      if (pickedValue != null) {
        selectedCurrency = pickedValue;
      }
    });
  }

  void onSelectedCupertinoCurrencyPicker(int itemNumber) {
    print(itemNumber);
    setState(() {
      pickedCurrencyNumber = itemNumber;
      if (currenciesList[pickedCurrencyNumber] != selectedCurrency) {
        isButtonDisabled = false;
      } else {
        isButtonDisabled = true;
      }
    });
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
                      rate: CurrencyParser().convertToCurrencyFormat(
                          value: exchangeRates["BTC"],
                          targetCurrency: selectedCurrency),
                      cryptoImage: AssetImage('images/bitcoin.png'),
                    ),
                    CryptoRateWidget(
                      cryptoCurrency: 'ETH',
                      fiatCurrency: selectedCurrency,
                      rate: CurrencyParser().convertToCurrencyFormat(
                          value: exchangeRates["ETH"],
                          targetCurrency: selectedCurrency),
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
                      rate: CurrencyParser().convertToCurrencyFormat(
                          value: exchangeRates["LTC"],
                          targetCurrency: selectedCurrency),
                      cryptoImage: AssetImage('images/litecoin.png'),
                    ),
                    CryptoRateWidget(
                      cryptoCurrency: 'DOGE',
                      fiatCurrency: selectedCurrency,
                      rate: CurrencyParser().convertToCurrencyFormat(
                          value: exchangeRates["DOGE"],
                          targetCurrency: selectedCurrency),
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
                  child: CupertinoCurrencyPicker(
                    onSelectedItem: (itemNumber) {
                      onSelectedCupertinoCurrencyPicker(itemNumber);
                    },
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 5.0,
                  ),
                  child: ConvertButton(
                    buttonText: 'CONVERT',
                    isDisabled: isButtonDisabled,
                    onPressed: () {
                      updateCurrencyData();
                    },
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
