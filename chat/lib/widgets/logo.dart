import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
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
