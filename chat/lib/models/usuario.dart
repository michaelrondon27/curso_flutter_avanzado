class Usuario {
  String email;
  String nombre;
  bool online;
  String uid;

  Usuario({
    required this.email,
    required this.nombre,
    this.online: false,
    required this.uid
  });
}