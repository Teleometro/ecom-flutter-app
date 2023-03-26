import 'package:ecom/Model/item.dart';

class Category {
  String name;
  List<Item> items;
  Category(this.name, this.items);

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      json['name'],
      json['items'],
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "items": items,
      };
  
}
