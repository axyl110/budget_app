import 'package:flutter/material.dart';
import 'package:budget_app/model/model.dart';

class ItemList extends StatefulWidget {
  ItemList(this.itemList, this.info);
  final List<Item> itemList;
  final Category info;

  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  void deleteUser(int id) {
    setState(() {
      widget.itemList.removeWhere((index) {
        return index.itemId == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return widget.itemList.isEmpty
        ? Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Text(
                  'No item added yet!',
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
            width: size.width - 40.0,
            child: ListView.builder(
              itemCount: widget.itemList.length,
              itemBuilder: (context, index) {
                if (widget.itemList[index].categoryID == widget.info.id) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 3,
                      child: ListTile(
                        title: Text(
                          widget.itemList[index].title,
                          style: TextStyle(
                            fontSize: 21.0,
                            color: Colors.black,
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: FittedBox(
                          child: Row(
                            children: <Widget>[
                              Text(
                                '- ₱ ' + '${widget.itemList[index].price}',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontFamily: 'OpenSans',
                                  color: Colors.black,
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.black),
                                onPressed: () =>
                                    deleteUser(widget.itemList[index].itemId),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }
                return Container();
              },
            ),
          );
  }
}
