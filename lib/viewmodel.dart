import 'package:ecom/Model/item.dart';
import 'package:ecom/Model/message.dart';
import 'package:flutter/material.dart';

import 'Model/cart.dart';
import 'Model/user.dart';

abstract class ViewModel {
  Future<List<User>> fetchUsers();
  bool registerUser(User user);
  Future<List<Message>> getMessages(String username);
  Future<String> chatbotQuery(String question);
  Cart getCart();
  void saveCart(Cart cart);
  Future<User?> signIn(String username, String password);
  Image getImage(String imageID);
  void cartAdd(Item item);
  void cartRemove(Item item);
  void cartClear();
  void cartIncrement(Item item, int amount);
  Future<List<Item>> getItems();
  Item getItem(String itemName);
  Future<List<Item>> getDeals();
  void signOut();
  List<String> getCategories();
  List<Item> getCategoryItems(String category);
  User getUser();
  void updateUser(oldUser, newUser);
}