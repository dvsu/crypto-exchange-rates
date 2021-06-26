import 'package:flutter/material.dart';
import 'package:crypto_converter/utilities/textstyling.dart';

class TitleWidget extends StatelessWidget {
  final String titleName;

  const TitleWidget({required this.titleName});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.0,
      child: Center(
        child: Text(
          titleName,
          style: mainTitleTextStyle,
        ),
      ),
    );
  }
}
