import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 1,
        title: Column(
          children: [
            CircleAvatar(
              backgroundColor: Colors.blue[100],
              child: Text(
                'Te',
                style: TextStyle( fontSize: 12 ),
              ),
              maxRadius: 14,
            ),

            SizedBox( height: 3 ),

            Text(
              'Melissa flores',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 12
              ),
            )
          ]
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                itemBuilder: (_, i) => Text('$i'),
                physics: BouncingScrollPhysics(),
                reverse: true
              )
            ),

            Divider( height: 1 ),

            Container(
              color: Colors.white,
              height: 100,
            )
          ]
        )
      ),
    );
  }
}
