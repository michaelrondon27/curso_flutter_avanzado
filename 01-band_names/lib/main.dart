import 'package:flutter/material.dart';
 
import 'package:band_names/pages/home.dart';
import 'package:band_names/pages/status.dart';

void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'status',
      routes: {
        'home': (_) => HomePage(),
        'status': (_) => StatusPage(),
      },
      title: 'Material App'
    );
  }
}