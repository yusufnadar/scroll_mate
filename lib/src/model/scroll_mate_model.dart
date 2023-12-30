import 'package:flutter/material.dart';

import '../../scroll_mate.dart';

class ScrollMateModel<T> {
  ScrollMateModel({
    required this.items,
    required this.builder,
    Widget? title,
    CrossAxisAlignment? crossAxisAlignment,
    int? lineCount,
    double? crossAxisSpacing,
    double? mainAxisSpacing,
    EdgeInsets? scrollPadding,
  })  : assert(lineCount != null && lineCount > 1 && items.length >= lineCount),
        lineCount = lineCount ?? 2,
        title = title ?? const SizedBox(),
        crossAxisSpacing = crossAxisSpacing ?? 10,
        mainAxisSpacing = mainAxisSpacing ?? 20,
        scrollPadding = scrollPadding ?? EdgeInsets.zero,
        crossAxisAlignment = CrossAxisAlignment.start;

  /// Total line count in list
  int lineCount;

  /// Spacing between columns
  double crossAxisSpacing;

  /// Spacing between rows
  double mainAxisSpacing;

  /// Padding of scroll
  EdgeInsets scrollPadding;

  /// If there is a title ve control crossAxisAlignment
  CrossAxisAlignment crossAxisAlignment;

  /// Widget at the beginning of items
  Widget title;

  /// Items to show users
  List<T> items;

  /// Generic value and custom widget
  ScrollMateItem Function(T title, int index) builder;
}
