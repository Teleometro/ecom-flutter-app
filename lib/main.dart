
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'view/initial_screens/splashscreen.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,
);

  runApp(const AppWidget());
}

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        canvasColor: Color(0xFFE8F0FA),
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 26, 90, 120)),
        
      ),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

