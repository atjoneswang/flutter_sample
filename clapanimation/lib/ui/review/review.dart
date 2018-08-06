import 'package:flutter/material.dart';

class ReviewPage extends StatefulWidget {
  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> with TickerProviderStateMixin{
  final PageController pageController = new PageController(
    initialPage: 2,
    keepPage: false,
    viewportFraction: 0.2,
  );

  int slideValue = 200;
  int lastAnimPosition = 2;
  AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
