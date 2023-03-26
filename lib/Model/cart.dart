import 'package:ecom/Model/item.dart';

class Cart {
  String username;
  List<CartItem> items;
  Cart(this.username, this.items);

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      json['username'],
      json['items'],
    );
  }

  Map<String, dynamic> toJson() => {
        "username": username,
        "items": items,
      };
  bool addItem(Item item) {
    if (items.any((i) => i.name == item.name)) return false;

    items.add(CartItem(item, 1));
    return true;
  }

  void removeItem(Item item) {
    items.removeWhere((i) => i.name == item.name);
  }

  void incrementItem(Item item, int amount) {
    CartItem cItem = items.firstWhere((i) => i.name == item.name); 
    cItem.amount += amount;
    if (cItem.amount < 1) {
      cItem.amount = 1;
    }
  }

  int getTotalPrice() {
    int total = 0;
    for (CartItem item in items) {
      total += item.item.price * item.amount;
    }
    return total;
  }
}

class CartItem {
  late String name;
  int amount;
  Item item;

  CartItem (this.item, this.amount) {
    name = item.name;
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      json['name'],
      json['amount'],
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "amount": amount,
      };
}
