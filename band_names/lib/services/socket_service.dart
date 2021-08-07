import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus {
  Connecting,
  Offline,
  Online
}

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;
  late IO.Socket _socket;

  ServerStatus get serverStatus => this._serverStatus; 
  IO.Socket get socket => this._socket;

  SocketService() {
    this._initConfig();
  }

  void _initConfig() {
    this._socket = IO.io('http://192.168.1.54:3000', {
      'autoConnect': true,
      'transports': ['websocket']
    });

    this._socket.onConnect((_) {
      this._serverStatus = ServerStatus.Online;

      notifyListeners();
    });
    
    this._socket.onDisconnect((_) {
      this._serverStatus = ServerStatus.Offline;

      notifyListeners();
    });

    // socket.on('nuevo-mensaje', ( payload ) {
    //   print('nuevo-mensaje: $payload');
    // });
  }
}
