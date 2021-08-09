import 'package:flutter/material.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:chat/global/environment.dart';

import 'package:chat/services/auth_services.dart';

enum ServerStatus {
  Online,
  Offline,
  Connecting
}

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;
  ServerStatus get serverStatus => this._serverStatus;

  late IO.Socket _socket;
  IO.Socket get socket => this._socket;  
  
  Function get emit => this._socket.emit;

  void connect() async {
    final token = await AuthService.getToken();

    this._socket = IO.io( Environment.socketUrl, {
      'autoConnect': true,
      'extraHeaders': {
        'x-token': token
      },
      'forceNew': true,
      'transports': ['websocket']
    });

    this._socket.on('connect', (_) {
      this._serverStatus = ServerStatus.Online;
      notifyListeners();
    });

    this._socket.on('disconnect', (_) {
      this._serverStatus = ServerStatus.Offline;
      notifyListeners();
    });
  }

  void disconnect() {
    this._socket.disconnect();
  }
}
