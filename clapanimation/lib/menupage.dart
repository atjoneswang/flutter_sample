import 'package:flutter/material.dart';
import 'list_menu.dart';

class MainPage extends StatelessWidget {
  final String title;

  MainPage(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0,
      decoration: ShapeDecoration(
        color: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(40.0),
            topRight: const Radius.circular(40.0),
          ),
          side: BorderSide(color: Colors.black38),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            title,
            style: TextStyle(fontSize: 16.0, color: Colors.black87),
          ),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.white,
          brightness: Brightness.light,
        ),
        body: MenuList(),
        backgroundColor: Colors.white,
      ),
    );
  }
}
