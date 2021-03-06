import 'dart:ui' as ui;

import 'package:clipanimation/pagereveal/pages.dart';
import 'package:flutter/material.dart';

class PageIndicator extends StatelessWidget {
  final PagerIndicatorViewModel viewModel;
  PageIndicator({
    this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    List<PageBubble> bubbles = [];
    for (var i = 0; i < viewModel.pages.length; ++i) {
      var page = viewModel.pages[i];

      var percentActive;
      if (i == viewModel.activeIndex) {
        percentActive = 1.0 - viewModel.slidePercent;
      } else if (i == viewModel.activeIndex - 1 &&
          viewModel.direction == SlideDirection.leftToRight) {
        percentActive = viewModel.slidePercent;
      } else if (i == viewModel.activeIndex + 1 &&
          viewModel.direction == SlideDirection.rightToLeft) {
        percentActive = viewModel.slidePercent;
      } else {
        percentActive = 0.0;
      }
      bool isHollow = i > viewModel.activeIndex ||
          (i == viewModel.activeIndex &&
              viewModel.direction == SlideDirection.leftToRight);

      bubbles.add(new PageBubble(
        viewModel: new PageBubbleViewModel(
            page.iconAssetIcon, page.color, isHollow, percentActive),
      ));
    }
    final BUBBLE_WIDTH = 55.0;
    final baseTranslation = ((viewModel.pages.length * BUBBLE_WIDTH) / 2) - (BUBBLE_WIDTH /2);
    var translation = baseTranslation - (viewModel.activeIndex * BUBBLE_WIDTH);
    if(viewModel.direction == SlideDirection.leftToRight) {
      translation += BUBBLE_WIDTH * viewModel.slidePercent;
    }else if(viewModel.direction == SlideDirection.rightToLeft) {
      translation -= BUBBLE_WIDTH * viewModel.slidePercent;
    }

    return Column(
      children: <Widget>[
        Expanded(
          child: Container(),
        ),
        Transform(
          transform: new Matrix4.translationValues(translation, 0.0, 0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: bubbles,
          ),
        ),
      ],
    );
  }
}

enum SlideDirection {
  leftToRight,
  rightToLeft,
  none,
}

class PagerIndicatorViewModel {
  final List<PageViewModel> pages;
  int activeIndex;
  final double slidePercent;
  final SlideDirection direction;

  PagerIndicatorViewModel(
      this.pages, this.activeIndex, this.direction, this.slidePercent);
}

class PageBubble extends StatelessWidget {
  final PageBubbleViewModel viewModel;
  PageBubble({
    this.viewModel,
  });
  @override
  Widget build(BuildContext context) {
    print('build bubble');
    return new Container(
      width: 55.0,
      height: 65.0,
      child: new Center(
        child: new Container(
          width: ui.lerpDouble(20.0, 45.0, viewModel.activePercent),
          height: ui.lerpDouble(20.0, 45.0, viewModel.activePercent),
          decoration: new BoxDecoration(
            shape: BoxShape.circle,
              color: viewModel.isHollow
                  ? const Color(0x88ffffff)
                      .withAlpha((0x88 * viewModel.activePercent).round())
                  : const Color(0x88ffffff),
              border: Border.all(
                  color: viewModel.isHollow
                      ? const Color(0x88ffffff).withAlpha(
                          (0x88 * (1.0 - viewModel.activePercent)).round())
                      : Colors.transparent,
                  width: 3.0
                  ),
              ),
          child: Opacity(
              opacity: viewModel.activePercent,
              child: new Image.asset(viewModel.iconAssetPath,
                  color: viewModel.color)),
        ),
      ),
      
    );
  }
}

class PageBubbleViewModel {
  final String iconAssetPath;
  final Color color;
  final bool isHollow;
  final double activePercent;

  PageBubbleViewModel(
      this.iconAssetPath, this.color, this.isHollow, this.activePercent);
}
