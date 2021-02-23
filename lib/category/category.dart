import 'package:flutter/material.dart';
import 'package:budget_app/Item/item_page.dart';
import 'package:budget_app/model/model.dart';

class CategoryList extends StatefulWidget {
  final List<Category> categories;
  final List<Item> item;
  final Category cat;

  CategoryList(this.categories, this.item, this.cat);
  @override
  CategoryListState createState() => CategoryListState();
}

class CategoryListState extends State<CategoryList> {
  refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return widget.categories.isEmpty
        ? Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Text(
                  'No Category added yet!',
                  style: TextStyle(
                    fontSize: 21.0,
                    color: Colors.black,
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          )
        : Container(
            height: 390,
            child: ListView.builder(
              itemCount: widget.categories.length,
              itemBuilder: (context, index) {
                return Container(
                  height: 100,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    elevation: 5,
                    margin: EdgeInsets.all(20),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ItemDisplay(
                                  category: widget.categories[index],
                                  itemDetails: widget.item,
                                  notif: refresh,
                                )));
                      },
                      child: Column(children: <Widget>[
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text(
                                widget.categories[index].name,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.black,
                                  fontFamily: 'Quicksand',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Row(children: <Widget>[
                                Text(
                                  '₱ ' +
                                      "${widget.categories[index].total}" +
                                      '/ ${widget.categories[index].limit}',
                                ),
                              ]),
                            ]),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                height: 12,
                                width: 350,
                                child: Stack(
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.green,
                                          width: 1.5,
                                        ),
                                        color: Colors.grey[350],
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    FractionallySizedBox(
                                      widthFactor:
                                          (widget.categories[index].total /
                                              widget.categories[index].limit),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.green[500],
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ]),
                    ),
                  ),
                );
              },
            ),
          );
  }
}
