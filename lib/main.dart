import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sortable Data',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final List<Map> _products = List.generate(30, (i){
    return {
      "id" : i,
      "name" : "Product $i",
      "price" : Random().nextInt(200) + 1
    };
  });

  int _currentSortColumn = 0;
  bool _isAscending = true;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sortable Data"),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: DataTable(
            sortAscending: _isAscending,
            sortColumnIndex: _currentSortColumn,
            headingRowColor: MaterialStateProperty.all(Colors.amber[200]),
            columns: [
              DataColumn(label: Text("Id")),
              DataColumn(label: Text("Name")),
              DataColumn(
                  label: Text(
                      "Price",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue
                    ),
                  ),
                onSort: (columnIndex, _){
                    setState(() {
                      _currentSortColumn = columnIndex;
                      if(_isAscending == true){
                        _isAscending = false;
                        _products.sort((productA, productB) =>
                            productB['price'].compareTo(productA['price']));
                      } else{
                        _isAscending = true;
                        _products.sort((productA, productB) =>
                            productB['price'].compareTo(productA['price']));
                      }
                    });
                }),
            ],
            rows: _products.map((item) {
              return DataRow(
                  cells: [
                    DataCell(Text(item['id'].toString())),
                    DataCell(Text(item['name'])),
                    DataCell(Text(item['price'].toString())),
                  ]
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
