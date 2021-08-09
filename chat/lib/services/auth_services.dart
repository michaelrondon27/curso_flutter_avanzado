import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'package:chat/global/environment.dart';

import 'package:chat/models/login_response.dart';
import 'package:chat/models/usuario.dart';

class AuthService with ChangeNotifier {
  late Usuario usuario;

  bool _autenticando = false;
  bool get autenticando => this._autenticando;
  set autenticando( bool value ) {
    this._autenticando = value;

    notifyListeners();
  }

  final _storage = new FlutterSecureStorage();
  static Future<String> getToken() async {
    final _storage = new FlutterSecureStorage();

    final token = await _storage.read(key: 'token');

    return token!;
  }

  static Future<void> deleteToken() async {
    final _storage = new FlutterSecureStorage();

    await _storage.delete(key: 'token');
  }

  Future<bool> login( String email, String password ) async {
    this.autenticando = true;
    
    final data = {
      'email': email,
      'password': password
    };

    final resp = await http.post(
      Uri.parse('${ Environment.apiUrl }/login'),
      body: jsonEncode( data ),
      headers: {
        'Content-Type': 'application/json'
      }
    );

    this.autenticando = false;

    if ( resp.statusCode == 200 ) {
      final loginResponse = loginResponseFromJson( resp.body );

      this.usuario = loginResponse.usuario;

      this._gaurdarToken( loginResponse.token );
      
      return true;
    } else {
      return false;
    }
  }

  Future register( String email, String nombre, String password ) async {
    this.autenticando = true;
    
    final data = {
      'email': email,
      'nombre': nombre,
      'password': password
    };

    final resp = await http.post(
      Uri.parse('${ Environment.apiUrl }/login/new'),
      body: jsonEncode( data ),
      headers: {
        'Content-Type': 'application/json'
      }
    );

    this.autenticando = false;

    if ( resp.statusCode == 200 ) {
      final loginResponse = loginResponseFromJson( resp.body );

      this.usuario = loginResponse.usuario;

      this._gaurdarToken( loginResponse.token );
      
      return true;
    } else {
      final respBody = jsonDecode( resp.body );

      return respBody['msg'];
    }
  }

  Future _gaurdarToken( String token ) async {
    await _storage.write(key: 'token', value: token);

    return;
  }

  Future logout() async {
    await _storage.delete(key: 'token');
  }
}
