import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewItem extends StatefulWidget {
  NewItem(this.item);
  final Function item;

  @override
  _NewItem createState() => _NewItem();
}

class _NewItem extends State<NewItem> {
  final _userinput = TextEditingController();
  final _amountInput = TextEditingController();
  DateTime _date;

  void _datePicked() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((pickedDate) {
      setState(() {
        _date = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _userinput,
              style: TextStyle(fontFamily: 'OpenSans'),
              decoration: InputDecoration(
                labelText: 'Title',
              ),
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: _amountInput,
              style: TextStyle(fontFamily: 'OpenSans'),
              decoration: InputDecoration(
                labelText: 'Expense',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      _date == null
                          ? 'No Date Chosen'
                          : DateFormat.yMMMMd().format(_date),
                      style: TextStyle(fontSize: 15.0, fontFamily: 'OpenSans'),
                    ),
                  ),
                  FlatButton(
                    child: Text(
                      'Choose Date',
                      style: TextStyle(fontSize: 16.0, fontFamily: 'OpenSans'),
                    ),
                    onPressed: _datePicked,
                    textColor: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
            RaisedButton(
              child: Text(
                'Add item',
                style: TextStyle(fontFamily: 'OpenSans'),
              ),
              onPressed: () {
                if (_amountInput.text.isEmpty ||
                    _userinput.text.isEmpty ||
                    _date == null) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Error',
                              style: TextStyle(fontFamily: 'OpenSans')),
                          content: Text('Invalid Input',
                              style: TextStyle(fontFamily: 'OpenSans')),
                          actions: [
                            FlatButton(
                              child: Text(
                                'OK',
                                style: TextStyle(fontFamily: 'OpenSans'),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop('dialog');
                              },
                            ),
                          ],
                        );
                      });
                } else {
                  widget.item(
                      _userinput.text, double.parse(_amountInput.text), _date);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
