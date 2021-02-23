import 'package:budget_app/model/model.dart';
import 'package:flutter/material.dart';
//import 'package:budget_app/model/categoryservice.dart';
class NewCategory extends StatefulWidget {
  final Function addcategories;

  NewCategory(this.addcategories);

  @override
  _NewCategoryState createState() => _NewCategoryState();
}

class _NewCategoryState extends State<NewCategory> {
  var nameIn = TextEditingController();
  var budgetIn = TextEditingController();
  //var _cats = Category();
  //var _cateserve = CategoryService();

  void dataSub() {
    if (nameIn.text.isEmpty || budgetIn.text.isEmpty) {
      return;
    }

    widget.addcategories(
      nameIn.text,
      double.parse(budgetIn.text)
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'ADD CATEGORY',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.2,
              ),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'NAME',
              ),
              keyboardType: TextInputType.text,
              keyboardAppearance: Brightness.light,
              controller: nameIn,
              onSubmitted: (_) => dataSub(),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'BUDGET',
              ),
              keyboardType: TextInputType.number,
              keyboardAppearance: Brightness.light,
              controller: budgetIn,
              onSubmitted: (_) => dataSub(),
            ),
            Spacer(),
            RaisedButton(
              elevation: 5,
              color: Colors.green[400],
              child: Text(
                'ADD',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.w700,
                ),
              ),
              onPressed: dataSub,
              
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
