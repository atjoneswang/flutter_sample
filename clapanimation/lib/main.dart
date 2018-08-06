import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'animation/clap/my_home_page.dart';
import 'blur/artist_details_container.dart';
import 'menupage.dart';
import 'ui/bottomnav/mainpage.dart';
import 'models/example_model.dart';
import 'scopemodel/scope.dart';
import 'stream/streamdemo.dart';

void main(){
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(

        primarySwatch: Colors.blue,
      ),
      //home: new MyHomePage(title: 'Flutter Demo Home Page'),
      debugShowCheckedModeBanner: false,

      home: new MainPage('Flutter Demo Home Page'),
      routes: {
        Routes.animation: (BuildContext context) => new MyHomePage(title: 'Animation'),
        Routes.designui: (BuildContext context) => new ArtistsDetailsAnimator(),
        Routes.bottomnav: (context) => new BottomNav(),
        Routes.scopemodel: (context) => new ScopeDemo(),
        Routes.stream: (context) => StreamDemo(),
      },
    );
  }
}


