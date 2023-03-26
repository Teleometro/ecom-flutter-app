import 'package:ecom/view/item_page.dart';
import 'package:ecom/viewmodel.dart';
import 'package:flutter/material.dart';

import '../../Model/image_handler.dart';
import '../../Model/item.dart';

class ItemDisplay extends StatelessWidget {
  final Item item;
  final ViewModel vm;
  const ItemDisplay({super.key, required this.item, required this.vm});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ItemPage(item: item, vm: vm),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            SizedBox(
              height: 100,
              width: 100,
              child: ImageHandler().getImage(item.imageID),
            ),
            SizedBox(
              child: Text(item.name,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  child: Text(
                    '\$${item.price / 100}',
                    style: const TextStyle(color: Color(0xFFFBB74E)),
                  ),
                ),
                if (item.dealEndDate != null)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEE4C69),
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: Text(
                      '${item.dealPercentage}%',
                      style: const TextStyle(color: Color(0xFFFFFFFF)),
                    ),
                  ),
              ],
            ),
            const Spacer()
          ],
        ),
      ),
    );
  }
}
