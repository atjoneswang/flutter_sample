import 'package:flutter/material.dart';
import 'models/example_model.dart';

class MenuList extends StatelessWidget {

  final models = initModels;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: models.length,
        itemBuilder: (BuildContext context, int index){
          return Column(
            children: <Widget>[
              ListTile(
                title: Text(models[index].title),
                subtitle: Text(models[index].shortDescription),
                trailing: Icon(Icons.chevron_right,color: Colors.blueGrey,),
                onTap: (){
                  debugPrint('navigator...');
                  navigator(context, models[index].route);
                  },
              ),
              Divider(
                height: 1.0,
                color: Colors.black12,
              ),
            ],
          );
        },
    );
  }

  void navigator(BuildContext context, String path){
    Navigator.pushNamed(context, path);
//     Navigator.push(context, PageRouteBuilder(pageBuilder: (_, __, ___) => new MyHomePage(title: 'Animation'),));
  }
}
