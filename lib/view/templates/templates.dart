import 'package:ecom/Model/image_handler.dart';
import 'package:ecom/Model/item.dart';
import 'package:ecom/view/settings_page.dart';
import 'package:ecom/view/templates/item_widget.dart';
import 'package:ecom/viewmodel.dart';
import 'package:flutter/material.dart';

Widget labelledTextField(String label, TextEditingController controller,
    [bool obscure = false]) {
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.symmetric(horizontal: 60),
      child: TextField(
        
        obscureText: obscure,
        controller: controller,
        decoration: InputDecoration(
          hintText: label,
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    ),
  );
}


Widget message(String text, [int style = 0]) {
  Color boxCol = Colors.blue;
  var textCol = Colors.white;
  if (style == 1) {
    boxCol = Colors.grey.shade300;
    textCol = Colors.black;
  }
  return Container(
    padding: const EdgeInsets.all(5),
    decoration: BoxDecoration(
      color: boxCol,
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
    ),
    child: Text(
      style: TextStyle(color: textCol),
      text,
    ),
  );
}

void onPressed() {}

class HorizontalListWithArrows extends StatefulWidget {
  final List<Widget> items;
  final double width;
  HorizontalListWithArrows({required this.items, required this.width});

  @override
  _HorizontalListWithArrowsState createState() =>
      _HorizontalListWithArrowsState();
}

class _HorizontalListWithArrowsState extends State<HorizontalListWithArrows> {
  late ScrollController _scrollController;
  
  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  _moveUp() {
    _scrollController.animateTo(
      _scrollController.offset - 150,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
    );
  }

  _moveDown() {
    _scrollController.animateTo(
      _scrollController.offset + 150,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(icon: const Icon(Icons.arrow_back_ios), onPressed: _moveUp),
        Container(
          height: 150.0,
          width: widget.width,
          child: ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            itemCount: widget.items.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                width: 150.0,
                height: 150.0,
                child: widget.items[index],
              );
            },
          ),
        ),
        IconButton(
            icon: const Icon(Icons.arrow_forward_ios), onPressed: _moveDown),
      ],
    );
  }
}



Widget paddedProgressionIndicator() {
  return const Padding(
    padding: EdgeInsets.all(32.0),
    child: CircularProgressIndicator(),
  );
}
