import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:chat/helpers/mostrar_alerta.dart';

import 'package:chat/services/auth_services.dart';
import 'package:chat/services/socket_service.dart';

import 'package:chat/widgets/boton_azul.dart';
import 'package:chat/widgets/custom_input.dart';
import 'package:chat/widgets/labels.dart';
import 'package:chat/widgets/logo.dart';

class LoginPage extends StatelessWidget {
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
                  title: 'Messenger',
                ),
        
                _Form(),
        
                Labels(
                  route: 'register',
                  subtitle: 'Crea una ahora!',
                  title: '¿No tienes cuenta?',
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
  final passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);

    return Container(
      child: Column(
        children: [
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
              FocusScope.of(context).unfocus();

              final loginOk = await authService.login(
                emailCtrl.text.trim(), 
                passwordCtrl.text.trim()
              );

              if ( loginOk ) {
                socketService.connect();
                
                Navigator.pushReplacementNamed(context, 'usuarios');
              } else {
                mostrarAlerta(
                  context,
                  'Revise sus credenciales nuevamente',
                  'Login incorrecto'
                );
              }
            },
            text: 'Ingrese',
          )
        ]
      ),
      margin: EdgeInsets.only( top: 40 ),
      padding: EdgeInsets.symmetric( horizontal: 50 )
    );
  }
}
