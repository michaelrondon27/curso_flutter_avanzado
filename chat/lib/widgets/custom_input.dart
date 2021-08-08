import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        autocorrect: false,
        decoration: InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintText: 'Email',
          prefixIcon: Icon( Icons.mail_outline )
        ),
        keyboardType: TextInputType.emailAddress,
        // obscureText: true,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular( 30 ),
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            color: Colors.black.withOpacity( 0.05 ),
            offset: Offset(0, 5)
          )
        ],
        color: Colors.white
      ),
      margin: EdgeInsets.only( bottom: 20 ),
      padding: EdgeInsets.only( bottom: 5, left: 5, right: 20, top: 5 ),
    );
  }
}