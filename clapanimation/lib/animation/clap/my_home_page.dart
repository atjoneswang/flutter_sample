import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

enum ScoreWidgetStatus {
  HIDDEN,
  BECOMING_VISIBLE,
  VISIBLE,
  BECOMING_INVISIBLE
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  int _counter = 0;
  double _sparklesAngle = 0.0;
  final duration = new Duration(milliseconds: 300);
  Random random;
  Timer holdTimer, scoreOutETA;
  AnimationController scoreInAnimationController, scoreOutAnimationController, scoreSizeAnimationController, sparklesAnimationController;
  Animation scoreOutPositionAnimation, sparklesAnimation;
  ScoreWidgetStatus _scoreWidgetStatus = ScoreWidgetStatus.HIDDEN;

  initState(){
    super.initState();
    scoreInAnimationController = new AnimationController(duration: Duration(milliseconds: 150), vsync: this);
    scoreInAnimationController.addListener((){
      setState(() {});
    });

    scoreOutAnimationController = new AnimationController(duration: duration, vsync: this);
    scoreOutPositionAnimation = new Tween(begin: 100.0, end: 150.0).animate(
        new CurvedAnimation(parent: scoreOutAnimationController, curve: Curves.easeOut)
    );
    scoreOutPositionAnimation.addListener(() {
      setState(() {});
    });
    scoreOutAnimationController.addStatusListener((status){
      if(status == AnimationStatus.completed){
        _scoreWidgetStatus = ScoreWidgetStatus.HIDDEN;
      }
    });

    scoreSizeAnimationController = new AnimationController(vsync: this, duration: new Duration(milliseconds: 150));
    scoreSizeAnimationController.addStatusListener((status){
      if(status == AnimationStatus.completed){
        scoreSizeAnimationController.reverse();
      }
    });
    scoreSizeAnimationController.addListener((){
      setState(() {

      });
      random = new Random();
    });

    sparklesAnimationController = new AnimationController(vsync: this,duration: duration);
    sparklesAnimation = new CurvedAnimation(parent: sparklesAnimationController, curve: Curves.easeIn);
    sparklesAnimation.addListener((){
      setState(() {

      });
    });

  }


  dispose(){
    super.dispose();
  }

  void increment(Timer t){
    scoreSizeAnimationController.forward(from: 0.0);
    sparklesAnimationController.forward(from: 0.0);
    setState(() {
      _counter++;
      _sparklesAngle = random.nextDouble() * (2*pi);
    });
  }

  void onTapDown(TapDownDetails tap){
    if(scoreOutETA != null){
      scoreOutETA.cancel();
    }
    if(_scoreWidgetStatus == ScoreWidgetStatus.BECOMING_INVISIBLE){
      scoreOutAnimationController.stop(canceled: true);
      _scoreWidgetStatus = ScoreWidgetStatus.VISIBLE;
    }else if(_scoreWidgetStatus == ScoreWidgetStatus.HIDDEN){
      _scoreWidgetStatus = ScoreWidgetStatus.BECOMING_VISIBLE;
      scoreInAnimationController.forward(from: 0.0);
    }
    increment(null);
    holdTimer = Timer.periodic(duration, increment);
  }

  void onTapUp(TapUpDetails tap){
    scoreOutETA = new Timer(duration,(){
      scoreInAnimationController.forward(from: 0.0);
      _scoreWidgetStatus = ScoreWidgetStatus.BECOMING_VISIBLE;
    });

    holdTimer.cancel();

  }

  Widget getScoreButton(){
    var scorePosition = 0.0;
    var scoreOpacity = 0.0;
    var extraSize = 0.0;
    switch(_scoreWidgetStatus) {
      case ScoreWidgetStatus.HIDDEN:
        break;
      case ScoreWidgetStatus.BECOMING_VISIBLE:
      case ScoreWidgetStatus.VISIBLE:
        scorePosition = scoreInAnimationController.value * 100;
        scoreOpacity = scoreInAnimationController.value;
        extraSize = scoreSizeAnimationController.value * 3;
        break;
      case ScoreWidgetStatus.BECOMING_INVISIBLE:
        scorePosition = scoreOutAnimationController.value;
        scoreOpacity = 1.0 - scoreOutAnimationController.value;
    }

    var stackChildren = <Widget>[];
    var firstAngle = _sparklesAngle;
    var sparkRadius = sparklesAnimationController.value * 50;
    var sparkOpacity = (1 - sparklesAnimation.value);

    for(int i=0; i <5; i++){
      var currentAngle = (firstAngle + ((2*pi)/5)*(i));
      var sparklesWidget = new Positioned(child: new Transform.rotate(
        angle: currentAngle - pi/2,
        child: new Opacity(opacity: sparkOpacity, child: new Image.asset("images/sparkles.png", width: 14.0, height: 14.0,),),
      ),
        left: (sparkRadius * cos(currentAngle)) + 20,
        top: (sparkRadius * sin(currentAngle)) + 20,
      );
      stackChildren.add(sparklesWidget);
    }

    stackChildren.add(new Opacity(opacity: scoreOpacity, child: new Container(
      height: 50.0 + extraSize,
      width: 50.0 + extraSize,
      decoration: new ShapeDecoration(
        shape: new CircleBorder(side: BorderSide.none),
        color: Colors.pink,
      ),
      child: Center(
        child: Text(
          "+" + _counter.toString(),
          style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold
          ),
        ),
      ),
    ),

    ));

    var widget = Positioned(
      child: Stack(
        alignment: FractionalOffset.center,
        overflow: Overflow.visible,
        children: stackChildren,
      ),
      bottom: scorePosition,
    );
    return widget;
  }

  Widget getClapButton(){
    var extraSize = 0.0;
    if(_scoreWidgetStatus == ScoreWidgetStatus.VISIBLE || _scoreWidgetStatus == ScoreWidgetStatus.BECOMING_VISIBLE){
      extraSize = scoreSizeAnimationController.value * 3;
    }
    return GestureDetector(
      onTapUp: onTapUp,
      onTapDown: onTapDown,
      child: Container(
        height: 60.0 + extraSize,
        width: 60.0 + extraSize,
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.pink, width: 1.0),
            borderRadius: BorderRadius.circular(50.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.pink, blurRadius: 8.0),
            ]
        ),
        child: ImageIcon(
          AssetImage("images/clap.png"),
          color: Colors.pink,
          size: 40.0,
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: new Text(widget.title),

      ),
      body: new Center(

        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'You have pushed the button this many times:',
            ),
            new Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(right: 20.0),
        child: Stack(
          alignment: FractionalOffset.center,
          overflow: Overflow.visible,
          children: <Widget>[
            getScoreButton(),
            getClapButton(),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}