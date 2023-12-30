import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ScrollMateController {
  // Define class as lazy singleton
  static ScrollMateController? _instance;

  ScrollMateController._init();

  static ScrollMateController get instance {
    _instance ??= ScrollMateController._init();
    return _instance!;
  }

  // run initialize function inside of initState
  void initController({required List<ScrollController> scrollControllers}) {
    for (int i = 0; i < scrollControllers.length; i++) {
      scrollControllers[i].addListener(() {
        // each scrollController being listened
        if (scrollControllers[i].position.userScrollDirection != ScrollDirection.idle) {
          // if scrollController not changing manual don't listen own addListener
          // do not trigger other addListener functions when you handle one
          for (int j = 0; j < scrollControllers.length; j++) {
            if (i != j) {
              // each controller listening others and just others changing position without manual
              _jumpTo(scrollControllers[i], scrollControllers[j]);
            }
          }
        }
      });
    }
  }

  // other scroll controllers changing on the ratio of main scroll controller
  void _jumpTo(ScrollController s1, ScrollController s2) => s2.jumpTo(
        s2.position.maxScrollExtent * (s1.position.pixels / s1.position.maxScrollExtent),
      );
}
