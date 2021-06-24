import 'package:flutter/material.dart';
import 'package:crypto_converter/utilities/color_palette.dart';

BoxDecoration mainPageBackgroundDecoration = BoxDecoration(
  borderRadius: BorderRadius.circular(10.0),
  gradient: RadialGradient(
    center: Alignment(-1.5, -2.0),
    radius: 2.2,
    stops: [
      0.2,
      1.8,
    ],
    colors: mainPageBackgroundColor,
  ),
);
