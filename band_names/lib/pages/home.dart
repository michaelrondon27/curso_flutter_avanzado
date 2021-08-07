import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:band_names/models/band.dart';
import 'package:band_names/services/socket_service.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [
    Band(id: '1', name: 'Metallica', votes: 5),
    Band(id: '2', name: 'Queen', votes: 1),
    Band(id: '3', name: 'Héroes del Silencio', votes: 2),
    Band(id: '4', name: 'Bon Jovi', votes: 5)
  ];

  @override
  Widget build(BuildContext context) {
    final socketService = Provider.of<SocketService>(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          Container(
            child: ( socketService.serverStatus == ServerStatus.Online )
              ? Icon( Icons.check_circle, color: Colors.blue[300] )
              : Icon( Icons.offline_bolt, color: Colors.red )
            ,
            margin: EdgeInsets.only( right: 10 ),
          )
        ],
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 1,
        title: Text('Band Names', style: TextStyle( color: Colors.black87 ) )
      ),
      body: ListView.builder(
        itemBuilder: ( context, i ) => _bandTile( bands[i] ),
        itemCount: bands.length,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon( Icons.add ),
        elevation: 1,
        onPressed: addNewBand
      ),
    );
  }

  Widget _bandTile( Band band ) {
    return Dismissible(
      background: Container(
        color: Colors.red,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text('Delete Band', style: TextStyle( color: Colors.white ))
        ),
        padding: EdgeInsets.only( left: 8 ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue[100],
          child: Text( band.name.substring(0,2) ),
        ),
        onTap: () {},
        title: Text( band.name ),
        trailing: Text('${ band.votes }', style: TextStyle( fontSize: 20 )),
      ),
      direction: DismissDirection.startToEnd,
      key: Key( band.id ),
      onDismissed: ( DismissDirection direction ) {},
    );
  }

  addNewBand() {
    final textController = new TextEditingController();

    if ( Platform.isAndroid ) {
      return showDialog(
        builder: ( context ) {
          return AlertDialog(
            actions: [
              MaterialButton(
                child: Text('Add'),
                elevation: 5,
                onPressed: () => addBandToList( textController.text ),
                textColor: Colors.blue,
              )
            ],
            content: TextField(
              controller: textController
            ),
            title: Text('New band name:'),
          );
        },
        context: context, 
      );
    }

    showCupertinoDialog(
      builder: (_) {
        return CupertinoAlertDialog(
          actions: [
            CupertinoDialogAction(
              child: Text('Add'),
              isDefaultAction: true,
              onPressed: () => addBandToList( textController.text )
            ),

            CupertinoDialogAction(
              child: Text('Dismiss'),
              isDestructiveAction: true,
              onPressed: () => Navigator.pop(context)
            )
          ],
          content: TextField(
            controller: textController,
          ),
          title: Text('New band name:'),
        );
      },
      context: context, 
    );

  }

  void addBandToList( String name ) {
    if ( name.length > 1 ) {
      this.bands.add( new Band(id: DateTime.now().toString(), name: name, votes: 0) );
    
      setState(() {});
    }


    Navigator.pop(context);
  }
}
