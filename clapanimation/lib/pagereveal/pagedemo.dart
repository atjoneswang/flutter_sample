import 'package:clipanimation/pagereveal/page_indicator.dart';
import 'package:clipanimation/pagereveal/page_reveal.dart';
import 'package:clipanimation/pagereveal/pages.dart';
import 'package:flutter/material.dart';

class PageRevealDemo extends StatefulWidget {
  @override
  _PageRevealDemoState createState() => _PageRevealDemoState();
}

class _PageRevealDemoState extends State<PageRevealDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Page(
            viewModel: pages[0],
            percentVisible: 1.0,
          ),
          PageReveal(
            revealPercent: 0.2,
            child: Page(
              viewModel: pages[1],
              percentVisible: 1.0,
            ),
          ),
          PageIndicator(
            viewModel: new PagerIndicatorViewModel(
              pages, 
              1, 
              SlideDirection.rightToLeft, 
              1.0
            ),
          ),
        ],
      ),
    );
  }
}
