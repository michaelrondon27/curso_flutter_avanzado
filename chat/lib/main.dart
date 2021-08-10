import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:chat/routes/routes.dart';

import 'package:chat/services/auth_services.dart';
import 'package:chat/services/chat_service.dart';
import 'package:chat/services/socket_service.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: 'loading',
        routes: appRoutes,
        title: 'Chat App'
      ),
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => ChatService()),
        ChangeNotifierProvider(create: (_) => SocketService()),
      ],
    );
  }
}