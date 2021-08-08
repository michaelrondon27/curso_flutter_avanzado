import 'package:flutter/material.dart';

import 'package:chat/widgets/custom_input.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: SafeArea(
        child: Column(
          children: [
            _Logo(),

            _Form(),

            _Labels(),

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
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          CustomInput(),
          
          CustomInput()

          // ElevatedButton(
          //   child: Text('Login'),
          //   onPressed: () {}, 
          // )
        ]
      ),
      margin: EdgeInsets.only( top: 40 ),
      padding: EdgeInsets.symmetric( horizontal: 50 )
    );
  }
}

class _Labels extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            '¿No tienes cuenta?',
            style: TextStyle(
              color: Colors.black54,
              fontSize: 15,
              fontWeight: FontWeight.w300
            )
          ),

          SizedBox( height: 10 ),

          Text(
            'Crea una ahora!',
            style: TextStyle(
              color: Colors.blue[600],
              fontSize: 18,
              fontWeight: FontWeight.bold
            ),
          )
        ]
      )
    );
  }
}

class _Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Column(
          children: [
            Image(
              image: AssetImage('assets/tag-logo.png'),
            ),

            SizedBox( height: 20 ),

            Text(
              'Messenger',
              style: TextStyle( fontSize: 30 ),
            )
          ]
        ),
        margin: EdgeInsets.only( top: 50 ),
        width: 200
      )
    );
  }
}
