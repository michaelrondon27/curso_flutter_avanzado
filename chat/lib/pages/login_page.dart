import 'package:flutter/material.dart';

import 'package:chat/widgets/custom_input.dart';
import 'package:chat/widgets/labels.dart';
import 'package:chat/widgets/logo.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: SafeArea(
        child: Column(
          children: [
            Logo(),

            _Form(),

            Labels(),

            Container(
              child: Text(
                'Términos y condiciones de uso',
                style: TextStyle(
                  fontWeight: FontWeight.w200
                ),
              ),
              margin: EdgeInsets.only( bottom: 30),
            )
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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

          ElevatedButton(
            child: Text('Login'),
            onPressed: () {
              print(emailCtrl.text);
            }, 
          )
        ]
      ),
      margin: EdgeInsets.only( top: 40 ),
      padding: EdgeInsets.symmetric( horizontal: 50 )
    );
  }
}
