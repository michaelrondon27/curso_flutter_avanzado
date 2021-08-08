import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat/routes/routes.dart';
import 'package:chat/services/auth_services.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: 'login',
        routes: appRoutes,
        title: 'Chat App'
      ),
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService())
      ],
    );
  }
}