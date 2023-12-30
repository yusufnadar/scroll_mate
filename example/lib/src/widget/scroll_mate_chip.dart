import 'package:flutter/material.dart';
import 'package:scroll_mate/scroll_mate.dart';

class ScrollMateChip extends StatelessWidget {
  final String title;
  final int index;

  const ScrollMateChip({super.key, required this.title, required this.index});

  @override
  Widget build(BuildContext context) {
    return ScrollMateItem(
      rightMargin: 20,
      leftMargin: 20,
      item: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color(0xff4c546d),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ).item;
  }
}
