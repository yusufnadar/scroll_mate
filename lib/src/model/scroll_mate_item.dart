import 'package:flutter/material.dart';

class ScrollMateItem {
  Widget item;
  double leftMargin;
  double rightMargin;

  ScrollMateItem({
    required this.item,
    double? leftMargin,
    double? rightMargin,
  })  : leftMargin = leftMargin ?? 0,
        rightMargin = rightMargin ?? 0;
}
