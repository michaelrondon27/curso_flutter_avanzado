import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus {
  Connecting,
  Offline,
  Online
}

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;

  get serverStatus => this._serverStatus; 

  SocketService() {
    this._initConfig();
  }

  void _initConfig() {
    IO.Socket socket = IO.io('http://192.168.1.54:3000', {
      'autoConnect': true,
      'transports': ['websocket']
    });

    socket.onConnect((_) {
      this._serverStatus = ServerStatus.Online;

      notifyListeners();
    });
    
    socket.onDisconnect((_) {
      this._serverStatus = ServerStatus.Offline;

      notifyListeners();
    });

    socket.on('nuevo-mensaje', ( payload ) {
      print('nuevo-mensaje: $payload');
    });
  }
}
