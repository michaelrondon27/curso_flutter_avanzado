import 'package:flutter/material.dart';

import 'package:chat/models/usuario.dart';

class UsuariosPage extends StatefulWidget {
  @override
  _UsuariosPageState createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  final usuarios = [
    Usuario(email: 'test1@test.com', nombre: 'Maria', online: true, uid: '1'),
    Usuario(email: 'test2@test.com', nombre: 'Melissa', uid: '2'),
    Usuario(email: 'test3@test.com', nombre: 'Michael', online: true, uid: '3'),
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Container(
            child: Icon( Icons.check_circle, color: Colors.blue[400] ),
            // child: Icon( Icons.offline_bolt, color: Colors.red ),
            margin: EdgeInsets.only( right: 10 ),
          )
        ],
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 1,
        leading: IconButton(
          icon: Icon( Icons.exit_to_app, color: Colors.black87 ),
          onPressed: () {},
        ),
        title: Text(
          'Mi Nombre',
          style: TextStyle( color: Colors.black87 ),
        )
      ),
      body: ListView.separated(
        itemBuilder: (_, i) => ListTile(
          leading: CircleAvatar(
            child: Text(usuarios[i].nombre.substring(0, 2))
          ),
          title: Text(usuarios[i].nombre),
          trailing: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: usuarios[i].online ? Colors.green[300] : Colors.red
            ),
            height: 10,
            width: 10
          ),
        ),
        itemCount: usuarios.length,
        physics: BouncingScrollPhysics(),
        separatorBuilder: (_, i) => Divider(),
      )
    );
  }
}
