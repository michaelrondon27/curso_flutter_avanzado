import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat/pages/login_page.dart';
import 'package:chat/pages/usuarios_page.dart';

import 'package:chat/services/auth_services.dart';
import 'package:chat/services/socket_service.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        builder: ( context, snapshot ) {
          return Center(
            child: Text('Espere...'),
          );
        },
        future: checkLogginState( context )
      ),
    );
  }

  Future checkLogginState( BuildContext context ) async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final socketService = Provider.of<SocketService>(context, listen: false);

    final autenticado = await authService.isLoggedIn();

    if ( autenticado ) {
      socketService.connect();
      
      Navigator.pushReplacement(context, PageRouteBuilder(
        pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) => UsuariosPage(),
        transitionDuration: Duration( milliseconds: 700 ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final curvedAnimation = CurvedAnimation(parent: animation, curve: Curves.easeIn);
          
          return SlideTransition(
            child: child,
            position: Tween<Offset>(
              begin: Offset(1.0, 0),
              end: Offset.zero
            ).animate(curvedAnimation)
          );
        }
      ));
    } else {
      Navigator.pushReplacement(context, PageRouteBuilder(
        pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) => LoginPage(),
        transitionDuration: Duration( milliseconds: 700 ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final curvedAnimation = CurvedAnimation(parent: animation, curve: Curves.easeIn);
          
          return SlideTransition(
            child: child,
            position: Tween<Offset>(
              begin: Offset(1.0, 0),
              end: Offset.zero
            ).animate(curvedAnimation)
          );
        }
      ));
    }
  }
}
