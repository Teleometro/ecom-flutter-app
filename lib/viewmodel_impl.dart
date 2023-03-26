
import 'package:ecom/Model/cart.dart';
import 'package:ecom/Model/image_handler.dart';
import 'package:ecom/Model/item.dart';
import 'package:flutter/src/widgets/image.dart';
import 'Model/model.dart';
import 'package:ecom/Model/message.dart';
import 'package:ecom/Model/user.dart';
import 'package:ecom/viewmodel.dart';

import 'package:cloud_firestore/cloud_firestore.dart';



class ViewModelImpl implements ViewModel {
  Model model = Model();
  ImageHandler imhand = ImageHandler();
  

  @override
  Future<List<User>> fetchUsers() async {
    return model.fetchUsers();
  }

  @override
  bool registerUser(User user) {
    return model.registerUser(user);
  }

  @override
  Future<List<Message>> getMessages(String username) async {
    return model.getMessages(username);
  }

  @override
  Future<String> chatbotQuery(String question) async {
    return model.chatbotQuery(question);
  }

  @override
  Cart getCart()  {
    return model.getCart();
  }
  
  @override
  void saveCart(Cart cart) {
    model.saveCart(cart);
  }
  
  @override
  Future<User?> signIn(String username, String password) {
    return model.signIn(username, password);
  }

  @override
  Image getImage(String imageID) {
    return imhand.getImage(imageID);
  }

  @override
  void cartAdd(Item item) {
    model.cartAdd(item);
  }

  @override
  void cartRemove(Item item) {
    model.cartRemove(item);
  }
  
  @override
  Future<List<Item>> getItems() async {
    return await model.getItems();
  }
  
  @override
  Future<List<Item>> getDeals() {
    return model.getDeals();
  }
  
  @override
  Item getItem(String itemName) {
    return model.getItem(itemName);
  }
  
  @override
  void cartIncrement(Item item, int amount) {
    model.cartIncrement(item, amount);
  }
  
  @override
  void signOut() {
    model.signOut();
  }
  
  @override
  List<String> getCategories() {
    return model.categoryList();
  }
  
  @override
  List<Item> getCategoryItems(String category) {
    return model.getCategoryItems(category);
  }
  
  @override
  void cartClear() {
    model.cartClear();
  }
  
  @override
  User getUser() {
    return model.user!;
  }
  
  @override
  void updateUser(oldUser, newUser) {
    model.updateUser(oldUser.username, newUser);
  }
}
