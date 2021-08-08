import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final IconData icon;
  final bool isPassword;
  final TextInputType keyboardType;
  final String placeholder;
  final TextEditingController textController;

  CustomInput({
    Key? key, 
    required this.icon, 
    this.isPassword: false, 
    this.keyboardType: TextInputType.text, 
    required this.placeholder, 
    required this.textController
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        autocorrect: false,
        controller: this.textController,
        decoration: InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintText: this.placeholder,
          prefixIcon: Icon( this.icon )
        ),
        keyboardType: this.keyboardType,
        obscureText: this.isPassword,
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