import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  final AnimationController animationController;
  final String text;
  final String uid;
  
  ChatMessage({
    Key? key, 
    required this.animationController,
    required this.text, 
    required this.uid
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      child: SizeTransition(
        child: Container(
          child: this.uid == '123'
            ? _myMesagge()
            : _notMyMessage()
        ),
        sizeFactor: CurvedAnimation(
          curve: Curves.easeOut,
          parent: this.animationController
        ),
      ),
      opacity: this.animationController,
    );
  }

  Widget _myMesagge() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        child: Text(
          this.text,
          style: TextStyle( color: Colors.white ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular( 20 ),
          color: Color(0xff4D9EF6)
        ),
        margin: EdgeInsets.only( bottom: 5, left: 50, right: 5 ),
        padding: EdgeInsets.all( 8 )
      )
    );
  }

  Widget _notMyMessage() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        child: Text(
          this.text,
          style: TextStyle( color: Colors.black87 ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular( 20 ),
          color: Color(0xffE4E5E8)
        ),
        margin: EdgeInsets.only( bottom: 5, left: 5, right: 50 ),
        padding: EdgeInsets.all( 8 )
      )
    );
  }
}