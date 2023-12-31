import 'package:flutter/material.dart';
import 'package:scroll_mate/scroll_mate.dart';

import '../const/interest_constants.dart';
import '../widget/scroll_mate_chip.dart';

class InterestView extends StatefulWidget {
  const InterestView({super.key});

  @override
  State<InterestView> createState() => _InterestViewState();
}

class _InterestViewState extends State<InterestView> {
  final scrollController = ScrollController();
  final scrollController2 = ScrollController();

  @override
  void initState() {
    super.initState();
    ScrollMateController.instance.initController(
      scrollControllers: [scrollController, scrollController2],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ScrollMateList<String>(
                scrollMateModel: ScrollMateModel(
                  lineCount: 2,
                  items: Interests.list,
                  title: buildInterestTitle(),
                  builder: (String title, int index) {
                    return ScrollMateItem(
                      rightMargin: 20,
                      leftMargin: 20,
                      item: ScrollMateChip(
                        title: title,
                        index: index,
                      ),
                    );
                  },
                ),
              ),
              ScrollMateList<dynamic>(
                scrollMateModel: ScrollMateModel(
                  lineCount: 3,
                  items: Interests.list,
                  title: buildInterestTitle(),
                  builder: (dynamic title, int index) {
                    return ScrollMateItem(
                      rightMargin: 20,
                      leftMargin: 20,
                      item: ScrollMateChip(title: title.toString(), index: index),
                    );
                  },
                ),
              ),
              ScrollMateList<dynamic>(
                scrollMateModel: ScrollMateModel(
                  lineCount: 4,
                  items: Interests.list,
                  title: buildInterestTitle(),
                  builder: (dynamic title, int index) {
                    return ScrollMateItem(
                      rightMargin: 20,
                      leftMargin: 20,
                      item: ScrollMateChip(title: title.toString(), index: index),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding buildInterestTitle() {
    return const Padding(
      padding: EdgeInsets.only(bottom: 15, left: 20, top: 15),
      child: Text(
        'Interests',
        style: TextStyle(fontSize: 20, color: Color(0xff4c546d), fontWeight: FontWeight.bold),
      ),
    );
  }
}
