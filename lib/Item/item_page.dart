import 'package:budget_app/Item/item.dart';
import 'package:budget_app/Item/newitem.dart';
import 'package:flutter/material.dart';
import 'package:budget_app/model/model.dart';
import 'package:percent_indicator/percent_indicator.dart';

const TWO_PI = 3.14 * 2;

class ItemDisplay extends StatefulWidget {
  ItemDisplay({this.category, this.itemDetails, this.notif});
  final Category category;
  final List<Item> itemDetails;
  final Function() notif;

  @override
  ItemDisplayState createState() => ItemDisplayState();
}

class ItemDisplayState extends State<ItemDisplay> {
  void itemBottomSheet(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              child: NewItem(addItem),
              height: 300,
            ),
          );
        });
  }

  void addItem(String text, double amount, DateTime date) {
    final Item item = Item(
      itemId: widget.itemDetails.length,
      title: text,
      price: amount,
      date: date,
      categoryID: widget.category.id,
    );
    setState(() {
      if (widget.category.limit >= widget.category.total) {
        widget.itemDetails.add(item);
        widget.category.total += amount;
        widget.notif();
      }
    });
  }

  double totalItems() {
    double totalValue = 0;
    for (int i = 0; i < widget.itemDetails.length; i++) {
      if (widget.itemDetails[i].categoryID == widget.category.id)
        totalValue += widget.itemDetails[i].price;
    }
    return totalValue;
  }

  double totalUsed() {
    double totalUsedItems;
    totalUsedItems = totalItems() / widget.category.limit;
    return totalUsedItems;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final circleSize = 200.0;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.category.name,
          style: TextStyle(
            fontSize: 21.0,
            color: Colors.white,
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => itemBottomSheet(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(padding: EdgeInsets.all(15.0)),
              Container(
                height: 250.0,
                width: size.width - 60.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Center(
                    child: TweenAnimationBuilder(
                  tween: Tween(begin: 0.0, end: totalUsed()),
                  duration: Duration(seconds: 1),
                  builder: (context, value, child) {
                    return Container(
                      width: circleSize,
                      height: circleSize,
                      child: Column(
                        children: <Widget>[
                          CircularPercentIndicator(
                            progressColor: Colors.green,
                            percent: totalItems() / widget.category.limit,
                            animation: true,
                            radius: 200.0,
                            lineWidth: 15.0,
                            circularStrokeCap: CircularStrokeCap.round,
                            center: Text("₱ " +
                                totalItems().toString() +
                                "/ ₱ ${widget.category.limit}"),
                          ),
                        ],
                      ),
                    );
                  },
                )),
              ),
              Padding(padding: EdgeInsets.all(15.0)),
              SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    ItemList(widget.itemDetails, widget.category),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
