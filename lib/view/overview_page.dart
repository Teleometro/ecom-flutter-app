import 'package:ecom/view/store_page.dart';
import 'package:ecom/view/templates/item_widget.dart';
import 'package:ecom/viewmodel.dart';
import 'package:flutter/material.dart';

import '../Model/item.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'templates/templates.dart';

class OverviewPage extends StatelessWidget {
  final String username;
  late List<String> categories = ["all"];
  final ViewModel vm;
  late List<Item> items;
  OverviewPage({super.key, required this.username, required this.vm}) {
    categories.addAll(vm.getCategories());
    items = vm.getCategoryItems("all");
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView(children: [
        Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(8),
          child: const Text(
            'Promotions',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
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
        // CarouselSlider(
        //       items: [

        //         //2nd Image of Slider
        //         Container(
        //           margin: EdgeInsets.all(6.0),
        //           child: vm.getImage("1"),
        //         ),

        //         //3rd Image of Slider
        //         Container(
        //           margin: EdgeInsets.all(6.0),
        //           child: vm.getImage("1"),
        //         ),

        //         //4th Image of Slider
        //         Container(
        //           margin: EdgeInsets.all(6.0),
        //           child: vm.getImage("1"),
        //         ),
        //   ],

        //   ),
        Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(8),
          child: const Text(
            'Deals',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: FutureBuilder<List<Item>>(
              future: vm.getDeals(),
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  List<Item> items = snapshot.data!;
                  return HorizontalListWithArrows(
                      items: items
                          .map((item) => ItemDisplay(item: item, vm: vm))
                          .toList(),
                      width: 300);
                } else {
                  return HorizontalListWithArrows(items: [
                    paddedProgressionIndicator(),
                    paddedProgressionIndicator(),
                    paddedProgressionIndicator()
                  ], width: 300);
                }
              })),
        ),
        Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(8),
          child: const Text(
            'Categories',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          height: 200,
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.all(8),
          child: GridView.builder(
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                width: 30.0,
                height: 12.0,
                child: ElevatedButton(
                  style: categories[index] == "all"
                      ? const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Color(0xFFEEBB11)))
                      : const ButtonStyle(),
                  child: Text(
                    categories[index],
                    style: const TextStyle(fontSize: 18),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StorePage(
                            items: vm.getCategoryItems(categories[index]),
                            vm: vm),
                      ),
                    );
                  },
                ),
              );
            },
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 2,
                mainAxisSpacing: 10,
                childAspectRatio: 3,
                crossAxisCount: 3),
          ),
        ),
      ]),
    );
  }
}
