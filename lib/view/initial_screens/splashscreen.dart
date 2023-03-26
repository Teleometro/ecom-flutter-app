import 'package:flutter/material.dart';

import 'register_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _controller.forward().then((value) => Navigator.push(
          context,
          MaterialPageRoute(
            settings: const RouteSettings(name: "/RegisterPage"),
            builder: (context) => const RegisterPage(),
          ),
        ));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          const Spacer(),
          RotationTransition(
            turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
            child: const Icon(
              color: Colors.black,
              Icons.public,
              size: 150,
            ),
          ),
          const Spacer(
            flex: 2,
          ),
        ],
      )),
    );
  }
}
