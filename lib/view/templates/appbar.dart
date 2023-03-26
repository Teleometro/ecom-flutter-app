import 'package:ecom/Model/category.dart';
import 'package:ecom/view/cart_page.dart';
import 'package:ecom/view/home_page.dart';
import 'package:ecom/view/store_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


import '../../viewmodel.dart';
import '../settings_page.dart';

PreferredSizeWidget appBarWithBackButton(var context, ViewModel vm) {
  return AppBar(
    title:  Text(
      'ecom',
          style: GoogleFonts.pacifico(color: Colors.white, fontSize: 32),
    ),
  );
}

PreferredSizeWidget appBarWithoutBackButton(var context, ViewModel vm) {
  return AppBar(
    automaticallyImplyLeading: false,
    title: Row(
      children: [
        Text(
          'ecom',
          style: GoogleFonts.pacifico(color: Colors.white, fontSize: 32),
        ),
      ],
    ),
    actions: [
      IconButton(
        onPressed: () {
          // method to show the search bar
          showSearch(
              context: context,
              // delegate to customize the search bar
              delegate: CustomSearchDelegate(vm));
        },
        icon: const Icon(Icons.search),
      ),
    ],
  );
}

PreferredSizeWidget appBarWithCart(var context, ViewModel vm) {
  return AppBar(
    title: Row(
      children: [
         Text(
          'ecom',
          style: GoogleFonts.pacifico(color: Colors.white, fontSize: 32),
        ),
      ],
    ),
    actions: [
      IconButton(
        onPressed: () {
          // method to show the search bar
          showSearch(
              context: context,
              // delegate to customize the search bar
              delegate: CustomSearchDelegate(vm));
        },
        icon: const Icon(Icons.search),
      ),
      InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(vm, 2),
            ),
          );
        },
        child: Row(
          children: [
            const Icon(Icons.shopping_cart),
            const SizedBox(width: 8,),
            Container(
                alignment: Alignment.center,
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16)),
                child: Text(
                  vm.getCart().items.length.toString(),
                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                )),
                            const SizedBox(width: 8,),

          ],
        ),
      ),
    ],
  );
}

class CustomSearchDelegate extends SearchDelegate {
  late List<String> searchTerms;
  ViewModel vm;
  CustomSearchDelegate(this.vm) {
    searchTerms = vm.getCategories();
  }

  // first overwrite to
  // clear the search text
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  // second overwrite to pop out of search menu
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  // third overwrite to show query result
  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var category in searchTerms) {
      if (category.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(category);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }

  // last overwrite to show the
  // querying process at the runtime
  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var category in searchTerms) {
      if (category.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(category);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => StorePage(
                  items: vm.getCategoryItems(result),
                  vm: vm,
                ),
              ),
            );
          },
          child: ListTile(
            title: Text(result),
          ),
        );
      },
    );
  }
}
