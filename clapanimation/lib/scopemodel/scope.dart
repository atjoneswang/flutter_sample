import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class AppModel extends Model {
  int _count = 0;
  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }

  void decrement() {
    _count--;
    notifyListeners();
  }
}

class ScopeDemo extends StatelessWidget {
  final AppModel appModelOne = AppModel();
  final AppModel appModelTwo = AppModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Basic counter"),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ScopedModel<AppModel>(
              model: appModelOne,
              child: Counter(
                counterName: 'App Model One',
              ),
            ),
            ScopedModel<AppModel>(
              model: appModelTwo,
              child: Counter(
                counterName: 'App Model Two',
              ),
            ),
          ],
        )),
    );
  }
}

class Counter extends StatelessWidget {
  final String counterName;
  Counter({Key key, @required this.counterName});

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModel>(
      builder: (context, child, model) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("$counterName: "),
              Text(
                model.count.toString(),
                style: Theme.of(context).textTheme.display1,
              ),
              ButtonBar(
                children: <Widget>[
                  IconButton(
                  icon: Icon(Icons.add),
                  onPressed: model.increment,
                ),
                IconButton(
                  icon: Icon(Icons.minimize),
                  onPressed: model.decrement,
                ),
                ],
              ),
            ],
          ),
    );
  }
}

class ScopeHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Scoped Model",
          style: TextStyle(
              color: Colors.black, fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text("Counter:"),
            ScopedModelDescendant<AppModel>(
              builder: (context, child, model) => Text(
                    model.count.toString(),
                    style: Theme.of(context).textTheme.display1,
                  ),
            ),
          ],
        ),
      ),
      floatingActionButton: ScopedModelDescendant<AppModel>(
        builder: (context, child, model) => ButtonBar(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: model.increment,
                ),
                IconButton(
                  icon: Icon(Icons.minimize),
                  onPressed: model.decrement,
                ),
              ],
            ),
      ),
    );
  }
}
