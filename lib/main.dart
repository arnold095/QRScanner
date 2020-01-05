import 'package:flutter/material.dart';
import 'package:qr_scanner/src/pages/HomePage.dart';
import 'package:qr_scanner/src/pages/MapPage.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QRScanner',
      initialRoute: 'home',
      routes: {
        'home': (BuildContext context) => HomePage(),
        'map': (BuildContext context) => MapPage(),
      },
      theme: ThemeData(
        primaryColor: Colors.indigo
      ),
    );
  }
}