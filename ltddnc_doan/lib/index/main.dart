import 'package:flutter/material.dart';
import 'CartPage.dart';
import '../Homepage.dart';
import 'ItemPage.dart';
import '../LoginPage.dart';
import 'package:ltddnc_doan/widget_tree.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        colorSchemeSeed: Colors.blueGrey,

      ),
      // routes: {
      //   "/" : (context) => LoginPage(),
      //   "loginPage" : (context) => LoginPage(),
      //   "Homepage": (context) => HomePage(),
      //   "cartPage" : (context) => CartPage(),
      //   "itemPage" : (context) => ItemPage(),
      // },
      home: const WidgetTree(),
    );
  }
}

