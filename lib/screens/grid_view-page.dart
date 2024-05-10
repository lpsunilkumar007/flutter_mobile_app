import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:editable/editable.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:mobile_app/routes/app_route.gr.dart';
import 'package:mobile_app/values/app_api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

@RoutePage()
class GridViewPage extends StatefulWidget {
  const GridViewPage({super.key});
  @override
  State<GridViewPage> createState() => _DataTableState();
}

var url = Uri.https(AppApi.baseUrl, AppApi.employee);

class _DataTableState extends State<GridViewPage> {
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  var url = Uri.https(AppApi.baseUrl, AppApi.employee);
  List rows = [];
  Future<void> fetchData() async {
    final storage = await SharedPreferences.getInstance();
    var accessToken = await storage.getString('access_token');
    bool authenticated = !JwtDecoder.isExpired(accessToken!);
    if (authenticated) {
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );
      var parsedData = json.decode(response.body);
      if (response.statusCode == 200) {
        setState(() {
          var data = (parsedData["data"]);
          for (var ii in data) {
            rows.add(
              {
                "id": ii["id"],
                "firstName": ii["firstName"],
                "lastName": ii["lastName"],
                "age": ii["age"],
                "role": ii["role"],
                "email": ii["email"],
                "username": ii["username"],
              },
            );
          }
        });
      } else if (response.statusCode == 403 || response.statusCode == 401) {
        context.router.push(LoginRoute(onResult: (bool) {}));
      }
    } else {
      print("qwqweqwqwewqqwewqewq");
      context.router.push(LoginRoute(onResult: (bool) {}));
    }
  }

  _save() async {
    print("object123123123");
    final storage = await SharedPreferences.getInstance();
  }

  /// Create a Key for EditableState
  final _editableKey = GlobalKey<EditableState>();

  List cols = [
    {"title": 'Id', 'widthFactor': 0.3, 'key': 'id', 'editable': false},
    {"title": 'First Name', 'widthFactor': 0.3, 'key': 'firstName'},
    {"title": 'Last Name', 'widthFactor': 0.3, 'key': 'lastName'},
    {"title": 'User Name', 'widthFactor': 0.3, 'key': 'username'},
    {"title": 'Age', 'widthFactor': 0.3, 'key': 'age'},
    {"title": 'Role', 'widthFactor': 0.3, 'key': 'role'},
    {"title": 'Email', 'widthFactor': 0.3, 'key': 'email'},
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
        onRowSaved: (value) {
          _save();
        },
        onSubmitted: (value) {
          _save();
        },
        tdStyle: const TextStyle(fontSize: 16),
        trHeight: 80,
        thStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        thAlignment: TextAlign.center,
        thVertAlignment: CrossAxisAlignment.center,
        thPaddingBottom: 2,
        showSaveIcon: true,
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
