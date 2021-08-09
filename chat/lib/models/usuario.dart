import 'dart:convert';

Usuario usuarioFromJson(String str) => Usuario.fromJson(json.decode(str));

String usuarioToJson(Usuario data) => json.encode(data.toJson());

class Usuario {
  Usuario({
    this.online: false,
    required this.email,
    required this.nombre,
    required this.uid,
  });

  bool? online;
  String email;
  String nombre;
  String uid;

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
    online: json["online"],
    email: json["email"],
    nombre: json["nombre"],
    uid: json["uid"],
  );

  Map<String, dynamic> toJson() => {
    "online": online,
    "email": email,
    "nombre": nombre,
    "uid": uid,
  };
}
