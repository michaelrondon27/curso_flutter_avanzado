import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat/helpers/mostrar_alerta.dart';

import 'package:chat/services/auth_services.dart';
import 'package:chat/services/socket_service.dart';

import 'package:chat/widgets/boton_azul.dart';
import 'package:chat/widgets/custom_input.dart';
import 'package:chat/widgets/labels.dart';
import 'package:chat/widgets/logo.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Logo(
                  title: 'Registro',
                ),
        
                _Form(),
        
                Labels(
                  route: 'login',
                  subtitle: 'Ingresa ahora!',
                  title: '¿Ya tienes una cuenta?',
                ),
        
                Text(
                  'Términos y condiciones de uso',
                  style: TextStyle(
                    fontWeight: FontWeight.w200
                  ),
                )
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
            height: MediaQuery.of(context).size.height * 0.9,
          ),
          physics: BouncingScrollPhysics(),
        ),
      )
    );
  }
}

class _Form extends StatefulWidget {
  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final emailCtrl = TextEditingController();
  final nameCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);
    
    return Container(
      child: Column(
        children: [
          CustomInput(
            icon: Icons.perm_identity,
            placeholder: 'Nombre',
            textController: nameCtrl
          ),

          CustomInput(
            icon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            placeholder: 'Correo',
            textController: emailCtrl
          ),

          CustomInput(
            icon: Icons.lock_outline,
            isPassword: true,
            placeholder: 'Contraseña',
            textController: passwordCtrl
          ),

          BotonAzul(
            onPressed: authService.autenticando ? null : () async {
              final registerOk = await authService.register(
                emailCtrl.text.trim(),
                nameCtrl.text.trim(),
                passwordCtrl.text.trim()
              );

              if ( registerOk == true ) {
                socketService.connect();
                
                Navigator.pushReplacementNamed(context, 'usuarios');
              } else {
                mostrarAlerta(
                  context,
                  registerOk,
                  'Registro incorrecto'
                );
              }
            },
            text: 'Crear cuenta',
          )
        ]
      ),
      margin: EdgeInsets.only( top: 40 ),
      padding: EdgeInsets.symmetric( horizontal: 50 )
    );
  }
}
