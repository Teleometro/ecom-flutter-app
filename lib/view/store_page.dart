import 'package:ecom/view/templates/appbar.dart';
import 'package:ecom/viewmodel.dart';
import 'package:flutter/material.dart';

import '../Model/item.dart';
import 'chatbot_page.dart';
import 'templates/item_widget.dart';
import 'templates/templates.dart';

class StorePage extends StatefulWidget {
  
  List<Item> items;
  final ViewModel vm;
  
  StorePage({super.key, required this.items, required this.vm});
  @override
  State<StorePage> createState() => _StorePageState(items, vm);
}

class _StorePageState extends State<StorePage> {
   List<Item> items;
   ViewModel vm;

  _StorePageState(this.items, this.vm) {
    if (items.isEmpty) {
      vm.getItems().then((value) => _changeItems(value));
    }
  }

  _changeItems(List<Item> newItems) {
    setState(() {
      items = newItems;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWithBackButton(context, vm),
      body: Container(
          margin: EdgeInsets.symmetric(horizontal: 12),
          width: MediaQuery.of(context).size.width - 20,
          height: MediaQuery.of(context).size.height - 173,
          child: GridView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.all(15),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10),
              itemCount: items.length,
              itemBuilder: (BuildContext context, index) {
                return ItemDisplay(
                  item: items[index],
                  vm: vm,
                );
              })),
    );
  }
}
