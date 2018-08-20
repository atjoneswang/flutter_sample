import 'dart:async';

import 'package:clipanimation/pagereveal/page_dragger.dart';
import 'package:clipanimation/pagereveal/page_indicator.dart';
import 'package:clipanimation/pagereveal/page_reveal.dart';
import 'package:clipanimation/pagereveal/pages.dart';
import 'package:flutter/material.dart';

class PageRevealDemo extends StatefulWidget {
  @override
  _PageRevealDemoState createState() => _PageRevealDemoState();
}

class _PageRevealDemoState extends State<PageRevealDemo> with TickerProviderStateMixin {
  StreamController<SlideUpdate> slideUpdateStream;
  AnimatedPageDragger animatedPageDragger;

  int activeIndex = 0;
  int nextPageIndex = 0;
  SlideDirection slideDirection = SlideDirection.none;
  double slidePercent = 0.0;

  _PageRevealDemoState() {
    slideUpdateStream = new StreamController<SlideUpdate>();
    slideUpdateStream.stream.listen((SlideUpdate event) {
      setState(() {
        if (event.updateType == UpdateType.doneDragging) {
          print('Done dragging');
          if (slidePercent > 0.5) {
            animatedPageDragger = new AnimatedPageDragger(
              slideDirection: slideDirection,
              transitionGoal: TransitionGoal.open,
              slidePercent: slidePercent,
              slideUpdateStream: slideUpdateStream,
              vsync: this
            );
          }else{
            animatedPageDragger = new AnimatedPageDragger(
              slideDirection: slideDirection,
              transitionGoal: TransitionGoal.close,
              slidePercent: slidePercent,
              slideUpdateStream: slideUpdateStream,
              vsync: this
            );
            nextPageIndex = activeIndex;
          }
          animatedPageDragger.run();
          
        } else if (event.updateType == UpdateType.dragging) {
          slideDirection = event.direction;
          slidePercent = event.slidePercent;

          if(slideDirection == SlideDirection.leftToRight){
            nextPageIndex = activeIndex -1;
          }else if(slideDirection == SlideDirection.rightToLeft) {
            nextPageIndex = activeIndex + 1;
          }else{
            nextPageIndex = activeIndex;
          }
        }else if(event.updateType == UpdateType.animating) {
          slideDirection = event.direction;
          slidePercent = event.slidePercent;
        
        }else if(event.updateType == UpdateType.doneAnimating){
          print('Done animating. Next page index: $nextPageIndex');
          activeIndex = nextPageIndex;
          
          slideDirection = SlideDirection.none;
          slidePercent == 0.0;
          animatedPageDragger.dispose();
        }
        print('active index: $activeIndex');
        print('next index: $nextPageIndex');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Page(
            viewModel: pages[activeIndex],
            percentVisible: 1.0,
          ),
          PageReveal(
            revealPercent: slidePercent,
            child: Page(
              viewModel: pages[nextPageIndex],
              percentVisible: slidePercent,
            ),
          ),
          PageIndicator(
            viewModel: new PagerIndicatorViewModel(
                pages, activeIndex, slideDirection, slidePercent),
          ),
          PageDagger(
            canDragRightToLeft: activeIndex < pages.length - 1,
            canDragLeftToRight: activeIndex > 0,
            slideUpdateStream: slideUpdateStream,
          ),
        ],
      ),
    );
  }
}
