import 'package:flutter/material.dart';

class BotonAzul extends StatelessWidget {
  final void Function()? onPressed;
  final String text;

  const BotonAzul({
    Key? key, 
    required this.onPressed, 
    required this.text
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Container(
        child: Center(
          child: Text(
            this.text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18
            ),
          )
        ),
        height: 55,
        width: double.infinity
      ),
      onPressed: this.onPressed, 
      style: ButtonStyle(
        elevation: MaterialStateProperty.all<double>( 2 ),
        shape: MaterialStateProperty.all<OutlinedBorder>( StadiumBorder() )
      )
    );
  }
}
