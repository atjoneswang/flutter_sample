import 'package:flutter/material.dart';
import 'mainpage.dart';

class PageOne extends StatefulWidget {
  final List<Data> dataList;

  PageOne({Key key, this.dataList}) : super(key: key);

  @override
  _PageOneState createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.dataList.length,
        itemBuilder: (context, index) {
          return ExpansionTile(
            key: PageStorageKey("${widget.dataList[index].id}"),
            title: Text(widget.dataList[index].title),
            children: <Widget>[
              Container(
                color: index % 2 == 0 ? Colors.orange : Colors.limeAccent,
                height: 100.0,
              ),
            ],
          );
        });
  }
}


class PageTwo extends StatefulWidget {
  PageTwo({Key key}) : super(key: key);
  @override
  _PageTwoState createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemExtent: 250.0,
        itemBuilder: (context, index) => Container(
          padding: EdgeInsets.all(10.0),
          child: Material(
            elevation: 4.0,
            borderRadius: BorderRadius.circular(5.0),
            color: index % 2 == 0 ? Colors.cyan : Colors.deepOrange,
            child: Center(
              child: Text(index.toString()),
            ),
          ),
        ));
  }
}

