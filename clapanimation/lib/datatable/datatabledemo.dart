import 'package:flutter/material.dart';

class DataTableDemo extends StatefulWidget {
  @override
  _DataTableDemoState createState() => _DataTableDemoState();
}

class _DataTableDemoState extends State<DataTableDemo> {
  Widget bodyData() => DataTable(
    columns: <DataColumn>[
      DataColumn(
        label: Text('First Name'),
        numeric: false,
        onSort: (i,b){},
        tooltip: "To display first name of the name",
      ),
      DataColumn(
        label: Text('Last Name'),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}