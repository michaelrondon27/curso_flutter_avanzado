import 'package:chat/services/auth_services.dart';
import 'package:http/http.dart' as http;

import 'package:chat/global/environment.dart';

import 'package:chat/models/usuario.dart';
import 'package:chat/models/usuarios_response.dart';

class UsuariosService {
  Future<List<Usuario>> getUsuarios() async {
    try {
      final resp = await http.get(
        Uri.parse('${ Environment.apiUrl }/usuarios'),
        headers: {
          'Content-type': 'application/json',
          'x-token': await AuthService.getToken()
        }
      );

      final usuariosResp = usuariosResponseFromJson( resp.body );

      return usuariosResp.usuarios!;
    } catch (e) {
      return [];
    }
  }
}