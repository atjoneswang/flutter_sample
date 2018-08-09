import 'package:flutter/material.dart';
import '../common/widgetmods.dart';
import 'package:faker/faker.dart';

class DataTableDemo extends StatefulWidget {
  @override
  _DataTableDemoState createState() => _DataTableDemoState();
}

class _DataTableDemoState extends State<DataTableDemo> {
  int _sortColumnIndex = 0;
  var nameList = getFakeNames();
  bool _sortAscending = true;
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
              setState(() {
                _sortColumnIndex = i;
                nameList.sort((a, b) => a.firstName.compareTo(b.firstName));
                _sortAscending = _sortAscending == true ? false : true;
              });
            },
            tooltip: "To display first name of the name",
          ),
          DataColumn(
            label: Text('Last Name'),
            numeric: false,
            onSort: (i, b) {
              print("$i, $b");
              print(_sortAscending);
              setState(() {
                _sortColumnIndex = i;
                nameList.sort((a, b) => a.lastName.compareTo(b.lastName));
                _sortAscending = _sortAscending == true ? false : true;
              });
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

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Container(
        width: double.infinity,
        decoration: buildRadiusContainer(),
        margin: EdgeInsets.only(
            top: statusBarHeight + 4, bottom: 10.0, left: 10.0, right: 10.0),
        child: Scaffold(
          body: SingleChildScrollView(child: bodyData()),
        ));
  }
}

class Name {
  String firstName;
  String lastName;
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
