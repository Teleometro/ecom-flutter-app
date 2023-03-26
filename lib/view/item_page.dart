import 'package:ecom/view/home_page.dart';
import 'package:ecom/viewmodel.dart';
import 'package:ecom/viewmodel_impl.dart';
import 'package:flutter/material.dart';

import '../../Model/user.dart';
import '../Model/cart.dart';
import '../Model/item.dart';
import 'templates/appbar.dart';
import 'templates/templates.dart';

class ItemPage extends StatefulWidget {
  final Item item;
  final ViewModel vm;

  ItemPage({required this.item, required this.vm});

  @override
  State<ItemPage> createState() => _ItemPageState(item, vm);
}

class _ItemPageState extends State<ItemPage> {
  Item item;
  ViewModel vm;
  bool _inCart = false;

  _ItemPageState(this.item, this.vm) {
    _inCart = vm.getCart().items.any((element) => element.name == item.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWithCart(context, vm),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            HorizontalListWithArrows(
                items: [for (String id in item.images) vm.getImage(id)], width: 280),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  child: Text(item.name, style: const TextStyle(fontSize: 20)),
                ),
                SizedBox(
                  child: Text(
                    '\$${item.price / 100}',
                    style: const TextStyle(
                        color: Color(0xFFFBB74E),
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: const Text("Details",
                  style: TextStyle(fontSize: 20, color: Color(0xFF575861))),
              expandedAlignment: Alignment.topLeft,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 48, right: 16, bottom: 16),
                  child: Text(item.details),
                )
              ],
            ),
            Container(
              height: 50,
              width: 300,
              decoration: BoxDecoration(
                color: _inCart ? const Color(0xFFFBB74E) : const Color(0xFF1A5B78),
                borderRadius: BorderRadius.circular(30),
              ),
              child: InkWell(
                onTap: () {
                  setState(() {
                    if (_inCart) {
                      vm.cartRemove(item);
                    } 
                    else {
                      vm.cartAdd(item);
                    }
                    _inCart = !_inCart;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _inCart
                          ? const Icon(
                              Icons.check,
                              color: Colors.white,
                            )
                          : const Text(
                              "Add to Cart",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20),
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
