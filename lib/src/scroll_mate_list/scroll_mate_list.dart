import 'package:flutter/material.dart';

import '../../scroll_mate.dart';
import '../scroll_behavior/my_scroll_behavior.dart';

class ScrollMateList<T> extends StatefulWidget {
  final ScrollMateModel<T> scrollMateModel;

  const ScrollMateList({super.key, required this.scrollMateModel});

  @override
  State<ScrollMateList> createState() => _ScrollMateListState<T>();
}

class _ScrollMateListState<T> extends State<ScrollMateList<T>> {
  /// Create a controller instance
  final scrollMateController = ScrollMateController.instance;

  /// Different item count calculating to send [itemList] function
  int totalCount = 0;

  /// Each lines have equal value at first
  late int eachLineCount;

  /// How many lines have should extra value calculating with index value
  late int remainder;

  /// Each [SingleChildScrollView] must have a controller
  final scrollControllers = <ScrollController>[];

  /// Define a new value to assign
  late ScrollMateModel<T> scrollMateModel;

  void initializeControllers() {
    /// Define a new value and assigned parameter who come
    /// Compare differences to refresh page
    scrollMateModel = widget.scrollMateModel;

    /// Calculated equal values
    eachLineCount = (scrollMateModel.items.length / scrollMateModel.lineCount).truncate();

    /// Calculated extra values for some index
    remainder = scrollMateModel.items.length % scrollMateModel.lineCount;

    /// Clear old controllers when the [didUpdateWidget] work
    scrollControllers.clear();

    /// Create a controller to add [scrollControllers] list
    for (int i = 0; i < scrollMateModel.lineCount; i++) {
      scrollControllers.add(ScrollController());
    }

    /// Activate controllers to listen and sync each other
    scrollMateController.initController(scrollControllers: scrollControllers);
  }

  /// Working just when the change values
  @override
  void didUpdateWidget(covariant ScrollMateList<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    /// Compare the old value and new value difference
    if (oldWidget.scrollMateModel.lineCount != widget.scrollMateModel.lineCount) {}
    initializeControllers();
  }

  @override
  void initState() {
    super.initState();

    /// Work at first time
    initializeControllers();
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      /// To control scrollController
      behavior: MyScrollBehavior(),
      child: Column(
        crossAxisAlignment: scrollMateModel.crossAxisAlignment,
        children: [
          /// Showing title widget if we need
          scrollMateModel.title,
          ListView.builder(
            itemCount: scrollMateModel.lineCount,
            scrollDirection: Axis.vertical,

            /// This physics never effect other controllers
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              if (index != 0) {
                /// Check the line need extra item
                /// Increase total count to send from specific index (0-7)-(7-14)-(14-20)
                totalCount += eachLineCount + ((index - 1) < remainder ? 1 : 0);
              } else {
                /// Calculate which index from start
                totalCount = 0;
              }
              return itemList(
                /// Send +1 or 0 to index
                itemCount: eachLineCount + (index < remainder ? 1 : 0),

                ///  (0-7)-(7-14)-(14-20)
                items: scrollMateModel.items.sublist(totalCount),

                /// Different scroll controllers for different [SingleChildScrollView]
                scrollController: scrollControllers[index],

                /// Check last line to remove padding
                lastLine: index == scrollMateModel.lineCount - 1,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget itemList({
    required int itemCount,
    required ScrollController scrollController,
    required List<T> items,
    required bool lastLine,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: lastLine == false ? scrollMateModel.mainAxisSpacing : 0),
      child: SingleChildScrollView(
        padding: scrollMateModel.scrollPadding,

        /// Prefer [SingleChildScrollView] when use [ListView] maxScrollExtent change to the list and rate not rendering properly
        scrollDirection: Axis.horizontal,
        controller: scrollController,
        child: Row(
          children: List.generate(
            itemCount,
            (index) {
              final builder = scrollMateModel.builder(
                items[index],
                totalCount + index,
              );

              /// If custom widget exists it is used and return generic value
              /// Users may not be add padding and margin only can is handled here
              return Container(
                margin: EdgeInsets.only(
                  left: index == 0 ? builder.leftMargin : 0,
                  right: (index == itemCount - 1) ? builder.rightMargin : scrollMateModel.crossAxisSpacing,
                ),
                child: builder.item,
              );
            },
          ),
        ),
      ),
    );
  }
}
