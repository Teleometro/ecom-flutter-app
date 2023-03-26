import 'package:ecom/view/cart_page.dart';
import 'package:ecom/view/overview_page.dart';
import 'package:ecom/view/profile_page.dart';
import 'package:ecom/viewmodel.dart';
import 'package:flutter/material.dart';

import '../Model/user.dart';
import 'templates/appbar.dart';

class HomePage extends StatefulWidget {
  final ViewModel vm;
  final int startingTab;
  HomePage(this.vm, this.startingTab);

  @override
  State<HomePage> createState() => _HomePageState(vm, startingTab);
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  ViewModel vm;
  late TabController _tab_controller;
  late User user;
  final int startingTab;
  _HomePageState(this.vm, this.startingTab) {
    user = vm.getUser();
  }

  @override
  void initState() {
    _tab_controller = TabController(length: 3, vsync: this);
    _tab_controller.addListener(() {
      setState(() {
        _tab_controller.animateTo(_tab_controller.index);
      });
    });
    _tab_controller.animateTo(startingTab);
    super.initState();
  }

  @override
  void dispose() {
    _tab_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: appBarWithoutBackButton(context, vm),
        body: TabBarView(
          controller: _tab_controller,
          children: [
            ProfilePage(vm, user: user,),
            OverviewPage(username: user.username, vm:vm),
            CartPage(vm:vm),
          ],
        ),
        bottomNavigationBar: Material(
          color: const Color.fromARGB(255, 26, 91, 120),
          child: TabBar(
            controller: _tab_controller,
            labelColor: const Color.fromARGB(255, 0, 172, 224),
            unselectedLabelColor: Colors.white,
            indicatorColor: Colors.transparent,
            tabs: [
              const Tab(icon: Icon(Icons.person)),
              const Tab(icon: Icon(Icons.home)),
              const Tab(icon: Icon(Icons.shopping_cart)),
            ],
          ),
        ),
      ),
    );
  }
}
