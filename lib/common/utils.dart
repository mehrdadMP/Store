import 'package:flutter/material.dart';

const scrollPhysics =
    BouncingScrollPhysics(decelerationRate: ScrollDecelerationRate.normal);

final textButtonStyle = ButtonStyle(
    overlayColor: MaterialStateProperty.all(Colors.transparent),
    padding: MaterialStateProperty.all(EdgeInsets.all(0)));

extension PriceLabel on int {
  String get withPriceLabel => '$this تومان';
}
