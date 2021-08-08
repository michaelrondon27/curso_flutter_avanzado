import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _focusNode = new FocusNode();
  final _textControler = new TextEditingController();

  bool _estaEscribiendo = false;

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
              child: _inputChat()
            )
          ]
        )
      ),
    );
  }

  Widget _inputChat() {
    return SafeArea(
      child: Container(
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: _textControler,
                decoration: InputDecoration.collapsed(
                  hintText: 'Enviar mensaje'
                ),
                focusNode: _focusNode,
                onChanged: ( String value ) {
                  setState(() {
                    if ( value.trim().length > 0 ) {
                      _estaEscribiendo = true;
                    } else {
                      _estaEscribiendo = false;
                    }
                  });
                },
                onSubmitted: _handleSubmit,
              ),
            ),

            Container(
              child: Platform.isIOS
                ? CupertinoButton(
                    child: Text('Enviar'), 
                    onPressed: _estaEscribiendo ? () => _handleSubmit( _textControler.text.trim() ) : null
                  )
                : Container(
                    child: IconTheme(
                      child: IconButton(
                        highlightColor: Colors.transparent,
                        icon: Icon( Icons.send ),
                        onPressed: _estaEscribiendo ? () => _handleSubmit( _textControler.text.trim() ) : null,
                        splashColor: Colors.transparent,
                      ),
                      data: IconThemeData( color: Colors.blue[400] ),
                    ),
                    margin: EdgeInsets.symmetric( horizontal: 4 )
                  ),
              margin: EdgeInsets.symmetric( horizontal: 4 )
            )
          ]
        ),
        margin: EdgeInsets.symmetric( horizontal: 8 )
      )
    );
  }

  _handleSubmit( String value ) {
    _textControler.clear();

    _focusNode.requestFocus();

    setState(() {
      _estaEscribiendo = false;
    });
  }
}
