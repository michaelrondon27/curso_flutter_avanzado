import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
 
import 'package:band_names/pages/home.dart';
import 'package:band_names/pages/status.dart';
import 'package:band_names/services/socket_service.dart';

void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: 'home',
        routes: {
          'home': (_) => HomePage(),
          'status': (_) => StatusPage(),
        },
        title: 'Material App'
      ),
      providers: [
        ChangeNotifierProvider(create: (_) => SocketService())
      ],
    );
  }
}