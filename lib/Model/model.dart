import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom/Model/category.dart';
import 'package:ecom/Model/item.dart';

import 'cart.dart';
import 'message.dart';
import 'user.dart';

class Model {
  late FirebaseFirestore db;

  Cart? cart;
  late List<Item> items;
  User? user;

  Model() {
    db = FirebaseFirestore.instance;
    items = [];
    for (String cat in categoryList()) {
      items.addAll(getCategoryItems(cat));
    }
  }

  Future<User?> signIn(String username, String password) async {
    List<User> users = await fetchUsers();
    for (User user in users) {
      if (user.matches(username, password)) {
        this.user = user;
        _fetchCart();
        return user;
      }
    }
    return null;
  }

  void signOut() {
    user = null;
    cart = null;
  }

  Future<List<Item>> getItems() async {
    return items;
  }

  Item getItem(String itemName) {
    return items.firstWhere((element) => element.name == itemName);
  }

  Future<List<Item>> getDeals() async {
    //TODO
    return [
      Item(
          "Nike Shoes",
          1999,
          "Nike is a highly acclaimed brand in the athletic footwear industry, renowned for its exceptional quality. The company offers a comprehensive selection of shoes to meet the varying needs of athletes and fitness enthusiasts. From running to basketball and everyday wear, Nike offers a range of styles and sizes to cater to every requirement. Its extensive range of sneakers, such as the iconic Air Max and the innovative Zoom Fly, are designed to provide superior comfort and support during any level of physical activity. Invest in a pair of Nike shoes today and elevate your footwear experience to a new level of comfort and style.",
          "1.jpg",
          ["1.jpg", "n2.webp", "n3.jpg"],
          404,
          dealEndDate: DateTime.parse("20250202"),
          dealPercentage: 25),
      Item("Earphones", 1399, "earphones and details", "2", ["1.jpg", "2", "3"],
          404,
          dealEndDate: DateTime.parse("20250202"), dealPercentage: 40),
      Item(
          "Kid's Shoes",
          2399,
          "Ensure your child's comfort and style with a quality pair of kids' shoes. With an active lifestyle that involves playing at the park and running around the playground, it is essential to provide them with footwear that is both durable and supportive. A comprehensive selection of styles and sizes, including sneakers, sandals, and boots, are available to meet the needs of growing children. Whether your child is taking their first steps or already on the move, you can find the perfect pair of shoes to suit their needs. Invest in a pair of kids' shoes today and provide your child with the comfort and support they need to keep up with their active lifestyle.",
          "3",
          ["1.jpg", "2", "3"],
          404,
          dealEndDate: DateTime.parse("20250202"),
          dealPercentage: 15)
    ];
  }

  Cart getCart() {
    cart ??= _fetchCart();
    return cart!;
  }

  Cart _fetchCart()  {
    // QuerySnapshot querySnapshot = await db
    //     .collection("Carts")
    //     .where("username", isEqualTo: username)
    //     .get();
    // final List<Map<String, dynamic>> list = querySnapshot.docs
    //     .map((doc) => doc.data() as Map<String, dynamic>)
    //     .toList();
    // if (list.isEmpty) {
    //   return Cart(username, []);
    // }
    // return Cart.fromJson(list[0]);
    return Cart(user!.username, []);
  }

  Future<bool> saveCart(Cart cart) async {
    var oldCart = await db
        .collection("Carts")
        .where("username", isEqualTo: cart.username)
        .get();
    if (oldCart.docs.isNotEmpty) {
      oldCart.docs[0].reference.update({"items": cart.items});
    } else {
      db.collection("Carts").add(<String, dynamic>{
        "username": cart.username,
        "items": cart.items,
      });
    }

    return true;
  }

  void updateUser(String oldUsername, User newUser) async {
    QuerySnapshot qs = await db
        .collection("Users")
        .where('username', isEqualTo: oldUsername)
        .get();
    for (var doc in qs.docs) {
      doc.reference.delete();
    }
    registerUser(newUser);
  }

  Future<List<User>> fetchUsers() async {
    QuerySnapshot querySnapshot = await db.collection("Users").get();
    final List<Map<String, dynamic>> list = querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
    List<User> users = List.empty(growable: true);

    for (Map<String, dynamic> user in list) {
      if (user['username'] == null) continue;
      users.add(User.fromJson(user));
    }
    return users;
  }

  bool registerUser(User user) {
    final userMap = <String, dynamic>{
      "first": user.firstName,
      "last": user.lastName,
      "email": user.email,
      "phone_num": user.phoneNumber,
      "password": user.password,
      "address": user.address,
      "username": user.username,
    };

    // Add a new document with a generated ID
    db.collection("Users").add(userMap);
    return true;
  }

  Future<List<Message>> getMessages(String username) async {
    var user = await db
        .collection("Users")
        .where('username', isEqualTo: username)
        .get();
    QuerySnapshot<Map<String, dynamic>> mh = await user.docs
        .map((doc) => doc.reference.collection("MessageHistory").get())
        .first;

    QuerySnapshot<Map<String, dynamic>> qs =
        await db.collection("MessageHistory").orderBy("id").get();
    List<Map<String, dynamic>> list =
        mh.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();

    List<Message> messages = List.empty(growable: true);
    for (Map<String, dynamic> msg in list) {
      messages.add(Message.fromJson(msg));
    }
    return messages;
  }

  Future<String> chatbotQuery(String question) async {
    QuerySnapshot qs = await db.collection("ChatBotAnswers").get();
    final List<Map<String, dynamic>> list =
        qs.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    var response = list.where((element) => element['question'] == question);

    String answer;
    if (response.isEmpty) {
      answer = "No Answer for that question";
    } else {
      answer = response.first['answer'];
    }

    final questionMap = <String, dynamic>{
      "sender": "user",
      "content": question,
    };
    final answerMap = <String, dynamic>{
      "sender": "bot",
      "content": answer,
    };
    db.collection("MessageHistory").add(questionMap);
    db.collection("MessageHistory").add(answerMap);
    db.collection("MessageHistory").snapshots().forEach((querySnapshot) {
      for (QueryDocumentSnapshot docSnapshot in querySnapshot.docs) {
        docSnapshot.reference.delete();
      }
    });
    return answer;
  }

  cartAdd(Item item) {
    cart!.addItem(item);
  }

  cartRemove(Item item) {
    cart!.removeItem(item);
  }

  cartClear() {
    cart!.items.clear();
  }

  cartIncrement(Item item, int amount) {
    cart!.incrementItem(item, amount);
  }

  List<String> categoryList() {
    return [
      "shoes",
      "phones",
      "handbags",
      "perfume",
      "furniture",
      "stationary"
    ];
  }

  List<Item> getCategoryItems(String name) {
    switch (name) {
      case "shoes":
        {
          return [
            Item(
                "Nike Shoes",
                3999,
                "Nike is a world-renowned brand known for its high-quality athletic footwear. Whether you're a runner, basketball player, or just looking for a comfortable pair of shoes for everyday wear, Nike has you covered. With a wide range of styles and sizes available, you're sure to find the perfect pair of Nike shoes to suit your needs. From the classic Air Max sneakers to the latest Zoom Fly models, Nike offers a wide selection of shoes designed to provide maximum comfort and support, no matter what your activity level is. So why wait? Step up your footwear game and find your perfect pair of Nike shoes today!",
                "1.jpg",
                ["1.jpg", "n2.webp", "n3.jpg"],
                404),
            Item(
                "High Heels",
                5499,
                "Enhance your fashion wardrobe with a sophisticated pair of high heels. These stylish accessories are the perfect complement to any outfit and add a touch of elegance to your appearance. With an extensive range of styles, from strappy sandals to classic pumps and edgy stilettos, you can find the perfect pair to match your personal taste. Choose from an array of colors and materials, including leather, suede, and patent, to enhance your wardrobe and express your style. Elevate your confidence and step out in style with a pair of high heels.",
                "heel.jpg",
                ["1.jpg", "2", "3"],
                404),
            Item(
                "Kid's Shoes",
                2399,
                "Ensure your child's comfort and style with a quality pair of kids' shoes. With an active lifestyle that involves playing at the park and running around the playground, it is essential to provide them with footwear that is both durable and supportive. A comprehensive selection of styles and sizes, including sneakers, sandals, and boots, are available to meet the needs of growing children. Whether your child is taking their first steps or already on the move, you can find the perfect pair of shoes to suit their needs. Invest in a pair of kids' shoes today and provide your child with the comfort and support they need to keep up with their active lifestyle.",
                "3",
                ["1.jpg", "2", "3"],
                404)
          ];
        }
      case "phones":
        {
          return [
            Item(
                "iPhone 12 Pro",
                99900,
                "The latest iPhone with a 6.1-inch Super Retina XDR display, A14 Bionic chip, and professional-grade camera system.",
                "OIP.jpg",
                ["1.jpg", "2", "3"],
                20),
            Item(
                "Samsung Galaxy S21 Ultra",
                109900,
                "A powerful smartphone with a 6.8-inch Dynamic AMOLED 2X display, Exynos 2100 chip, and 108 MP camera.",
                "samsung.jpg",
                ["1.jpg", "2", "3"],
                15),
            Item(
                "Google Pixel 6 Pro",
                89900,
                "A premium smartphone with a 6.4-inch OLED display, Snapdragon 888 chip, and 48 MP camera with Night Sight technology.",
                "goog.png",
                ["1.jpg", "2", "3"],
                25)
          ];
        }
      case "handbags":
        {
          return [
            Item(
                "Leather Tote Bag",
                19900,
                "A stylish and practical leather tote bag, perfect for carrying everyday essentials.",
                "tote.jpg",
                ["1.jpg", "2", "3"],
                20),
            Item(
                "Suede Crossbody Bag",
                14900,
                "A trendy and versatile suede crossbody bag, perfect for a night out or running errands.",
                "suede.jpg",
                ["1.jpg", "2", "3"],
                15),
            Item(
                "Evening Clutch",
                10900,
                "A chic and elegant evening clutch, perfect for a special occasion or a night out.",
                "clutch.jpg",
                ["1.jpg", "2", "3"],
                25)
          ];
        }
      case "perfume":
        {
          return [
            Item(
                "Flower by Kenzo",
                19900,
                "A sweet and floral scent, perfect for women who love nature and the outdoors.",
                "flower.webp",
                ["1.jpg", "2", "3"],
                20),
            Item(
                "Armani Code",
                24900,
                "A woody and spicy scent, perfect for men who want to make a statement.",
                "aramain.webp",
                ["1.jpg", "2", "3"],
                15),
            Item(
                "Acqua Di Gio",
                19900,
                "A fresh and clean scent, perfect for both men and women.",
                "agua.webp",
                ["1.jpg", "2", "3"],
                25)
          ];
        }
      case "stationary":
        {
          return [
            Item(
                "Bic Ballpoint Pens",
                500,
                "A pack of 10 Bic ballpoint pens with black ink, perfect for everyday writing.",
                "bic.jpg",
                ["1.jpg", "2", "3"],
                50),
            Item(
                "Ruled Notebook",
                1500,
                "A spiral-bound notebook with lined pages, perfect for taking notes and keeping organized.",
                "notebook.jpg",
                ["1.jpg", "2", "3"],
                30),
            Item(
                "Post-it Sticky Notes",
                1000,
                "A pack of 50 Post-it sticky notes in various colors, perfect for leaving reminders and notes.",
                "sticky.jpg",
                ["1.jpg", "2", "3"],
                40)
          ];
        }
      case "furniture":
        {
          return [
            Item(
                "Leather Sofa",
                299900,
                "A comfortable and stylish leather sofa with a classic design, perfect for any living room.",
                "sofa.webp",
                ["1.jpg", "2", "3"],
                5),
            Item(
                "Oak Dining Table",
                199900,
                "A beautiful oak dining table with a traditional design, perfect for family meals and dinner parties.",
                "table.jpg",
                ["1.jpg", "2", "3"],
                10),
            Item(
                "King Size Bed",
                149900,
                "A comfortable king size bed with a sturdy frame and soft mattress, perfect for a good night's sleep.",
                "bed.jpg",
                ["1.jpg", "2", "3"],
                15)
          ];
        }
      default:
        {
          var items = categoryList().map((name) => getCategoryItems(name));
          List<Item> it = [];
          for (List<Item> i in items) {
            it.addAll(i);
          }
          return it;
        }
    }
  }
}
