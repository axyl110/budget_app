import 'package:budget_app/model/model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChartDetails extends StatefulWidget {
  ChartDetails({this.day, this.budget, this.percent});
  final String day;
  final double budget;
  final double percent;

  @override
  _ChartDetails createState() => _ChartDetails();
}

class _ChartDetails extends State<ChartDetails> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        FittedBox(
          child: Text(
            '₱ ${widget.budget}',
            style: TextStyle(
              fontSize: 14.0,
              fontFamily: 'OpenSans',
            ),
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        Container(
          width: 10.0,
          height: 100.0,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: FractionallySizedBox(
                  heightFactor: widget.percent,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        Text(
          '${widget.day}',
          style: TextStyle(
              fontSize: 14.0,
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class ChartList extends StatefulWidget {
  ChartList(this.userTransactions);
  final List<Item> userTransactions;

  @override
  _ChartList createState() => _ChartList();
}

class _ChartList extends State<ChartList> {
  DateTime now = new DateTime.now();

  List<Map<String, Object>> get daysList {
    return List.generate(7, (count) {
      DateTime days = DateTime.now().subtract(Duration(days: count));
      double total = 0.0;

      for (int counter = 0;
          counter < widget.userTransactions.length;
          counter++) {
        if (days.year == widget.userTransactions[counter].date.year &&
            days.month == widget.userTransactions[counter].date.month &&
            days.day == widget.userTransactions[counter].date.day) {
          total += widget.userTransactions[counter].price;
        }
      }

      return {
        'day': DateFormat.E().format(days),
        'budget': total,
      };
    }).reversed.toList();
  }

  double get expense {
    return daysList.fold(0.0, (sum, item) {
      return sum + item['budget'];
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime week = now.subtract(Duration(days: 7));
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 10.0,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            Text(
              'Weekly Spending',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black,
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  iconSize: 18.0,
                  onPressed: () => null,
                ),
                Text(
                  DateFormat.yMMMd().format(week) +
                      ' - ' +
                      DateFormat.yMMMd().format(now),
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward),
                  iconSize: 18.0,
                  onPressed: () => null,
                ),
              ],
            ),
            SizedBox(
              height: 5.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: daysList.map((exp) {
                return ChartDetails(
                  day: exp['day'],
                  budget: exp['budget'],
                  percent:
                      expense != 0 ? (exp['budget'] as double) / expense : 0.0,
                );
              }).toList(),
            ),
            SizedBox(
              height: 5.0,
            ),
          ],
        ),
      ),
    );
  }
}
