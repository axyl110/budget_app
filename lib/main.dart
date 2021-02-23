import 'package:flutter/material.dart';
import 'package:budget_app/screen/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BUDGET APP',
      theme: ThemeData(
          primarySwatch: Colors.green,
          backgroundColor: Colors.green[600],
          accentColor: Colors.green[400],
          appBarTheme: AppBarTheme(elevation: 5.0)),
      home: HomePage(),
    );
  }
}
