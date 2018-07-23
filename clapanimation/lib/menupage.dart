import 'package:flutter/material.dart';
import 'list_menu.dart';

class MainPage extends StatelessWidget {

  final String title;

  MainPage(this.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: TextStyle(fontSize: 16.0, color: Colors.black87),),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.white,
        brightness: Brightness.light,
      ),
      body: MenuList(),
      backgroundColor: Colors.white,
    );
  }
}
