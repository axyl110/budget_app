class Item {
  int itemId;
  int categoryID;
  String title;
  double price;
  DateTime date;

  Item({this.itemId, this.categoryID, this.title, this.price, this.date});
}

class Category {
  int id;
  String name;
  double limit;
  double total;

  Category({this.id, this.name, this.total = 0, this.limit});

  categoryMap() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id;
    mapping['name'] = name;
    mapping['limit'] = limit;
    mapping['total'] = total;

    return mapping;
  }
}

