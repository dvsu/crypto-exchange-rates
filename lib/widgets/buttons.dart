import 'package:flutter/material.dart';
import 'package:crypto_converter/utilities/textstyling.dart';

class ConvertButton extends StatelessWidget {
  final String buttonText;
  final bool isDisabled;
  final VoidCallback onPressed;

  const ConvertButton(
      {required this.buttonText,
      required this.isDisabled,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        gradient: LinearGradient(
          begin: Alignment(-1.5, -1.0),
          end: Alignment.bottomRight,
          stops: [-1.0, 1.2],
          colors: [
            (isDisabled == true) ? Color(0xbbaaaaaa) : Color(0xbb38e2f5),
            (isDisabled == true) ? Color(0xbbaaaaaa) : Color(0xbbbe31f5),
          ],
        ),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          shadowColor: MaterialStateProperty.all(Colors.transparent),
          overlayColor: (isDisabled == true)
              ? MaterialStateProperty.all(Colors.transparent)
              : MaterialStateProperty.all(Color(0x5538e2f5)),
        ),
        child: Text(
          'CONVERT',
          style: convertButtonTextStyle,
        ),
      ),
    );
  }
}
