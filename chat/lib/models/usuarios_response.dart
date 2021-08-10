import 'dart:convert';

import 'package:chat/models/usuario.dart';

UsuariosResponse usuariosResponseFromJson(String str) => UsuariosResponse.fromJson(json.decode(str));

String usuariosResponseToJson(UsuariosResponse data) => json.encode(data.toJson());

class UsuariosResponse {
  UsuariosResponse({
    this.ok: false,
    this.usuarios,
  });

  bool ok;
  List<Usuario>? usuarios = [];

  factory UsuariosResponse.fromJson(Map<String, dynamic> json) => UsuariosResponse(
    ok: json["ok"],
    usuarios: List<Usuario>.from(json["usuarios"].map((x) => Usuario.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ok": ok,
    "usuarios": ( usuarios!.length > 0) ? List<dynamic>.from(usuarios!.map((x) => x.toJson())) : [],
  };
}
