import 'package:flutter/material.dart';

const scrollPhysics =
    BouncingScrollPhysics(decelerationRate: ScrollDecelerationRate.normal);

extension PriceLabel on int {
  String get withPriceLabel => '$this تومان';
}
