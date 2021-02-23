import 'package:budget_app/category/newcategory.dart';
import 'package:flutter/material.dart';
import 'package:budget_app/chart/chart.dart';
import 'package:budget_app/category/category.dart';
import 'package:budget_app/model/model.dart';

class HomePage extends StatefulWidget {
  final Category cat;

  HomePage({this.cat});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Category> userCategories = [];
  final List<Item> userItems = [];

  void catBottomSheet(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              child: NewCategory(addCategory),
              height: 250,
            ),
          );
        });
  }

  void addCategory(String text, double amount) {
    final Category category =
        Category(name: text, limit: amount, id: userCategories.length);
    setState(() {
      userCategories.add(category);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[400],
        title: Text(
          'BUDGET APP',
          style: TextStyle(
            fontSize: 21.0,
            color: Colors.white,
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.white,
              size: 35.0,
            ),
            onPressed: () => catBottomSheet(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ChartList(userItems),
            CategoryList(userCategories, userItems, widget.cat),
          ],
        ),
      ),
    );
  }
}
