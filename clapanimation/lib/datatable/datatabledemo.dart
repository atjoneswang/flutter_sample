import 'package:faker/faker.dart';
import 'package:flutter/material.dart';

import '../common/widgetmods.dart';

class DataTableDemo extends StatefulWidget {
  @override
  _DataTableDemoState createState() => _DataTableDemoState();
}

class _DataTableDemoState extends State<DataTableDemo> {
  int _sortColumnIndex = 0;
  List<Name> nameList;
  bool _sortAscending = true;

  @override
  void initState(){
    super.initState();
    nameList = getFakeNames();
    _sort((Name n) => n.firstName, _sortColumnIndex, _sortAscending);
  }

  Widget bodyData() => DataTable(
        sortColumnIndex: _sortColumnIndex,
        sortAscending: _sortAscending,
        columns: <DataColumn>[
          DataColumn(
            label: Text('First Name'),
            numeric: false,
            onSort: (i, b) {
              print("$i, $b");
              print(_sortAscending);
              _sort<String>((Name n) => n.firstName, i, _sortAscending);
            },
            tooltip: "To display first name of the name",
          ),
          DataColumn(
            label: Text('Last Name'),
            numeric: false,
            onSort: (i, b) {
              print("$i, $b");
              print(_sortAscending);
              _sort<String>((Name n) => n.lastName, i, _sortAscending);
            },
            tooltip: "To display last name of the name",
          ),
        ],
        rows: nameList
            .map((name) => DataRow(cells: [
                  DataCell(
                    Text(name.firstName),
                    showEditIcon: false,
                    placeholder: false,
                  ),
                  DataCell(
                    Text(name.lastName),
                    showEditIcon: false,
                    placeholder: false,
                  ),
                ]))
            .toList(),
      );
  
  void _sort<T>(
      Comparable<T> getField(Name a), int columnIndex, bool ascending) {
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending == true ? false : true;
      nameList.sort((Name a, Name b) {
        if (!ascending) {
          final Name c = a;
          a = b;
          b = c;
        }
        final Comparable<T> aValue = getField(a);
        final Comparable<T> bValue = getField(b);
        return Comparable.compare(aValue, bValue);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = getStatusBarHeight(context);
    return Container(
      decoration: BoxDecoration(
          gradient:
              LinearGradient(
                colors: [Colors.cyanAccent, Colors.indigoAccent],
                begin: Alignment.bottomLeft,
                end: Alignment.bottomRight
                )),
      child: Container(
          width: double.infinity,
          decoration: buildRadiusContainer(),
          margin: EdgeInsets.only(
              top: statusBarHeight + 4, bottom: 10.0, left: 10.0, right: 10.0),
          child: Scaffold(
            body: SingleChildScrollView(child: bodyData()),
          )),
    );
  }
}

class Name {
  String firstName;
  String lastName;
  bool selected = false;
  Name({this.firstName, this.lastName});
}

List<Name> getFakeNames() {
  var list = <Name>[];
  for (var i = 0; i < 30; i++) {
    var name = new Name(
        firstName: faker.person.firstName(), lastName: faker.person.lastName());
    list.add(name);
  }
  return list;
}
