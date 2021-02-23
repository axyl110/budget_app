import 'package:flutter/material.dart';

class ChartBar extends StatefulWidget {
  final String whatday;
  final double budgetSpent;
  final double spendPctOfTotal;

  ChartBar({this.whatday, this.budgetSpent, this.spendPctOfTotal});

  ChartBarState createState() => ChartBarState();
}

class ChartBarState extends State<ChartBar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 20,
          child: FittedBox(
            child: Text(
              '${widget.budgetSpent}',
              style: TextStyle(
                fontSize: 0.6,
                color: Colors.black,
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 70,
          width: 15,
          child: Stack(
            children: <Widget>[
              FractionallySizedBox(
                heightFactor: 0.0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blue[300],
                    width: 1.5,
                  ),
                  color: Colors.grey[350],
                  borderRadius: BorderRadius.circular(9),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          '${widget.whatday}',
          style: TextStyle(
            fontSize: 13.0,
            color: Colors.black,
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
