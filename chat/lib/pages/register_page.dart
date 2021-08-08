import 'package:flutter/material.dart';

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
            onPressed: () {
              print( emailCtrl.text );
              print( passwordCtrl.text );
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
