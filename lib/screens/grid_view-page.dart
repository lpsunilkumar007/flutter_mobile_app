import 'package:auto_route/annotations.dart';
import 'package:editable/editable.dart';
import 'package:flutter/material.dart';

@RoutePage()
class GridViewPage extends StatefulWidget {
  const GridViewPage({super.key});
  @override
  State<GridViewPage> createState() => _DataTableState();
}

class _DataTableState extends State<GridViewPage> {
  /// Create a Key for EditableState
  final _editableKey = GlobalKey<EditableState>();
  List rows = [
    {
      "name": 'James Joe',
      "date": '23/09/2020',
      "month": 'June',
      "status": 'completed'
    },
    {
      "name": 'Daniel Paul',
      "month": 'March',
      "status": 'new',
      "date": '12/4/2020',
    },
    {
      "month": 'May',
      "name": 'Mark Zuckerberg',
      "date": '09/4/1993',
      "status": 'expert'
    },
    {
      "name": 'Jack',
      "status": 'legend',
      "date": '01/7/1820',
      "month": 'December',
    },
  ];
  List cols = [
    {"title": 'Name', 'widthFactor': 0.2, 'key': 'name', 'editable': false},
    {"title": 'Date', 'widthFactor': 0.2, 'key': 'date'},
    {"title": 'Month', 'widthFactor': 0.2, 'key': 'month'},
    {"title": 'Status', 'key': 'status'},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Editable DataTable",
        ),
      ),
      body: Editable(
        key: _editableKey,
        columns: cols,
        borderWidth: 1,
        rows: rows,
        zebraStripe: false,
        onRowSaved: (value) {},
        onSubmitted: (value) {},
        tdStyle: const TextStyle(fontSize: 16),
        trHeight: 80,
        thStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        thAlignment: TextAlign.center,
        thVertAlignment: CrossAxisAlignment.center,
        thPaddingBottom: 2,
        showSaveIcon: false,
        saveIconColor: Colors.black,
        showCreateButton: false,
        tdAlignment: TextAlign.left,
        tdEditableMaxLines: 100, // don't limit and allow data to wrap
        tdPaddingTop: 0,
        tdPaddingLeft: 10,
        tdPaddingRight: 8,
      ),
    );
  }
}
