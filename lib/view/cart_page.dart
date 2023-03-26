import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecom/view/home_page.dart';
import 'package:ecom/view/payment_choice.dart';
import 'package:ecom/viewmodel.dart';
import 'package:flutter/material.dart';

import '../Model/cart.dart';
import '../Model/item.dart';
import 'templates/item_widget.dart';

class CartPage extends StatefulWidget {
  final ViewModel vm;

  CartPage({super.key, required this.vm});

  @override
  State<CartPage> createState() => _CartPageState(vm);
}

class _CartPageState extends State<CartPage> {
  ViewModel vm;

  _CartPageState(this.vm);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Cart>(future: Future(() {
        return vm.getCart();
      }), builder: ((context, snapshot) {
        if (snapshot.hasData) {
          Cart cart = snapshot.data!;
          if (cart.items.isNotEmpty) {
            return Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height - 300,
                  child: ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(25),
                    itemCount: cart.items.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8.0),
                        width: 150.0,
                        height: 150.0,
                        child: cartItem(cart.items[index]),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 48),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Total"),
                      Text((cart.getTotalPrice() / 100).toString()),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 48),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Tax"),
                      Text(((cart.getTotalPrice() / 10).round() / 100)
                          .toString()),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 48),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Subtotal",
                        style: TextStyle(
                            fontSize: 20,
                            color: Color(0xFFFBB74E),
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                          (((cart.getTotalPrice() / 10).round() +
                                      cart.getTotalPrice()) /
                                  100)
                              .toString(),
                          style: const TextStyle(
                              fontSize: 20,
                              color: Color(0xFFFBB74E),
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 300,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentMethodPage(vm),
                        ),
                      );
                    },
                    child: const Text("Check Out"),
                  ),
                ),
              ],
            );
          } else {
            List<Item> items = vm.getCategoryItems("all");

            return Column(
              children: [
                Container(
                    height: 260,
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.remove_shopping_cart_outlined,
                          size: 144,
                          color: Colors.grey,
                        ),
                        const Text(
                          "No Items in Cart",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                        ),
                      ],
                    )),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (a) => HomePage(vm, 1)));
                    },
                    child: const Text("Return to Home")),
                    const Spacer(),
                const Text(
                  "Recommended For You",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 15,
                ),
                CarouselSlider.builder(
                  itemCount: vm.getCategoryItems("all").length,
                  itemBuilder: (context, index, realIndex) {
                    return Container(
                      width: 200,
                      height: 200,
                      margin: const EdgeInsets.all(6.0),
                      child: Expanded(
                          child: ItemDisplay(
                        item: items[index],
                        vm: vm,
                      )),
                    );
                  },
                  options: CarouselOptions(
                    height: 180.0,
                    autoPlay: true,
                    aspectRatio: 16 / 9,
                    autoPlayCurve: Curves.ease,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration: const Duration(milliseconds: 800),
                    viewportFraction: 0.5,
                  ),
                ),
                const Spacer(),
              ],
            );
          }
        } else {
          return const SizedBox(
            width: 60,
            height: 60,
            child: CircularProgressIndicator(),
          );
        }
      })),
    );
  }

  Widget cartItem(CartItem cartItem) {
    return Container(
      padding: const EdgeInsets.all(5),
      child: Container(
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 255, 255),
            border: Border.all(
              color: const Color.fromARGB(255, 206, 239, 255),
            ),
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: SizedBox(
                width: 180,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                        height: 80,
                        width: 80,
                        child: vm.getImage(cartItem.item.imageID)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(cartItem.item.name),
                        Text(cartItem.item.category),
                        Text(
                          (cartItem.item.price * cartItem.amount / 100)
                              .toString(),
                          style: const TextStyle(color: Colors.orange),
                        ),
                        const Spacer(
                          flex: 3,
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  vm.cartIncrement(cartItem.item, -1);
                                });
                              },
                              child: Container(
                                decoration: const BoxDecoration(
                                    color: Color(0xFF115599),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        bottomLeft: Radius.circular(15))),
                                alignment: Alignment.center,
                                height: 20,
                                width: 24,
                                child: const Text(
                                  "-",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            Container(
                              height: 20,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 2),
                              color: const Color(0x11000000),
                              child: Text(
                                cartItem.amount.toString(),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  vm.cartIncrement(cartItem.item, 1);
                                });
                              },
                              child: Container(
                                decoration: const BoxDecoration(
                                    color: Color(0xFF115599),
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(15),
                                        bottomRight: Radius.circular(15))),
                                alignment: Alignment.center,
                                height: 20,
                                width: 24,
                                child: const Text(
                                  "+",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Spacer()
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        vm.cartRemove(cartItem.item);
                      });
                    },
                    icon: const Icon(Icons.delete)),
                const Spacer()
              ],
            ),
          ],
        ),
      ),
    );
  }
}
