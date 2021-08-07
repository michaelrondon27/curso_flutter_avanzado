import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:band_names/services/socket_service.dart';

class StatusPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final socketService = Provider.of<SocketService>(context);
    
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text('ServerStatus: ${ socketService.serverStatus }')
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        )
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon( Icons.message ),
        onPressed: () {
          socketService.socket.emit('emitir-mensaje', {
            'nombre': 'Flutter',
            'mensaje': 'Hola desde Flutter' 
          });
        },
      ),
    );
  }
}