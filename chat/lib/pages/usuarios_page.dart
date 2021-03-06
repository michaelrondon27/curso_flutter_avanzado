import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:chat/models/usuario.dart';

import 'package:chat/services/auth_services.dart';
import 'package:chat/services/chat_service.dart';
import 'package:chat/services/socket_service.dart';
import 'package:chat/services/usuarios_service.dart';

class UsuariosPage extends StatefulWidget {
  @override
  _UsuariosPageState createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  final usuariosService = new UsuariosService();
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  List<Usuario> usuarios = [];

  @override
  void initState() { 
    this._cargarUsuarios();
    
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);

    final usuario = authService.usuario;

    return Scaffold(
      appBar: AppBar(
        actions: [
          Container(
            child: (socketService.serverStatus == ServerStatus.Online ) 
              ? Icon( Icons.check_circle, color: Colors.blue[400] )
              : Icon( Icons.offline_bolt, color: Colors.red ),
            margin: EdgeInsets.only( right: 10 ),
          )
        ],
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 1,
        leading: IconButton(
          icon: Icon( Icons.exit_to_app, color: Colors.black87 ),
          onPressed: () {
            socketService.disconnect();
            
            Navigator.pushReplacementNamed(context, 'login');
            
            AuthService.deleteToken();
          },
        ),
        title: Text(
          usuario.nombre,
          style: TextStyle( color: Colors.black87 ),
        )
      ),
      body: SmartRefresher(
        child: _listViewUsuarios(),
        controller: _refreshController,
        enablePullDown: true,
        header: WaterDropHeader(
          complete: Icon( Icons.check, color: Colors.blue[400] ),
          waterDropColor: Colors.blue[400]!,
        ),
        onRefresh: _cargarUsuarios,
      )
    );
  }

  ListView _listViewUsuarios() {
    return ListView.separated(
      itemBuilder: (_, i) => _usuarioTile( usuarios[i] ),
      itemCount: usuarios.length,
      physics: BouncingScrollPhysics(),
      separatorBuilder: (_, i) => Divider(),
    );
  }

  ListTile _usuarioTile( Usuario usuario ) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.blue[100],
        child: Text(usuario.nombre.substring(0, 2))
      ),
      onTap: () {
        final chatService = Provider.of<ChatService>(context, listen: false);

        chatService.usuarioPara = usuario;

        Navigator.pushNamed(context, 'chat');
      },
      subtitle: Text( usuario.email ),
      title: Text(usuario.nombre),
      trailing: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: usuario.online! ? Colors.green[300] : Colors.red
        ),
        height: 10,
        width: 10
      ),
    );
  }

  _cargarUsuarios() async {
    this.usuarios = await usuariosService.getUsuarios();

    setState(() {});

    _refreshController.refreshCompleted();
  }
}
