import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:chat/services/chat_service.dart';

import 'package:chat/widgets/chat_message.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _focusNode = new FocusNode();
  final _textControler = new TextEditingController();

  bool _estaEscribiendo = false;

  List<ChatMessage> _messages = [];

  @override
  void dispose() {
    for ( ChatMessage message in _messages ) {
      message.animationController.dispose();
    }
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chatService = Provider.of<ChatService>(context);

    final usuarioPara = chatService.usuarioPara;
    
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
                usuarioPara.nombre.substring(0, 2),
                style: TextStyle( fontSize: 12 ),
              ),
              maxRadius: 14,
            ),

            SizedBox( height: 3 ),

            Text(
              usuarioPara.nombre,
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
                itemBuilder: (_, i) => _messages[i],
                itemCount: _messages.length,
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
    if ( value.trim().length == 0 ) return;

    _textControler.clear();

    _focusNode.requestFocus();

    final newMesssage = new ChatMessage(
      animationController: AnimationController(
        duration: Duration( milliseconds: 200 ),
        vsync: this
      ),
      text: value, 
      uid: '123'
    );

    _messages.insert(0, newMesssage);

    newMesssage.animationController.forward();

    setState(() {
      _estaEscribiendo = false;
    });
  }
}
