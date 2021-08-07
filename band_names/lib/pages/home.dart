import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:band_names/models/band.dart';

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
    return Scaffold(
      appBar: AppBar(
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

  ListTile _bandTile( Band band ) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.blue[100],
        child: Text( band.name.substring(0,2) ),
      ),
      onTap: () {},
      title: Text( band.name ),
      trailing: Text('${ band.votes }', style: TextStyle( fontSize: 20 )),
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
