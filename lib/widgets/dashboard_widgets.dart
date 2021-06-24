import 'package:flutter/material.dart';
import 'package:crypto_converter/utilities/textstyling.dart';
import 'package:crypto_converter/utilities/color_palette.dart';

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
              colors: rateWidgetBackgroundColor,
            ),
            boxShadow: [
              BoxShadow(
                color: rateWidgetShadowColor,
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
                      style: rateWidgetTitleTextStyle,
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
                      style: rateWidgetValueTextStyle,
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
