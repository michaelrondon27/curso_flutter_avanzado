import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:chat/global/environment.dart';

class AuthService with ChangeNotifier {
  Future login( String email, String password ) async {
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

    print( resp.body );
  }
}
