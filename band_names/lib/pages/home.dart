import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

import 'package:band_names/models/band.dart';
import 'package:band_names/services/socket_service.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [];

  @override
  void initState() {
    final socketService = Provider.of<SocketService>(context,listen: false);

    socketService.socket.on('active-bands', _handleActiveBands);
    
    super.initState();
  }

  @override
  void dispose() {
    final socketService = Provider.of<SocketService>(context,listen: false);

    socketService.socket.off('active-bands');

    super.dispose();
  }

  void _handleActiveBands( dynamic payload ) {
    this.bands = (payload as List).map((band) => Band.fromMap(band)).toList();

    setState(() {});
  }

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
      body: Column(
        children: [
          _showGraph(),

          Expanded(
            child: ListView.builder(
              itemBuilder: ( context, i ) => _bandTile( bands[i] ),
              itemCount: bands.length,
            ),
          )
        ]
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon( Icons.add ),
        elevation: 1,
        onPressed: addNewBand
      ),
    );
  }

  Widget _bandTile( Band band ) {
    final socketService = Provider.of<SocketService>(context,listen: false);

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
        onTap: () => socketService.socket.emit('vote-band', {'id': band.id}),
        title: Text( band.name ),
        trailing: Text('${ band.votes }', style: TextStyle( fontSize: 20 )),
      ),
      direction: DismissDirection.startToEnd,
      key: Key( band.id ),
      onDismissed: (_) => socketService.socket.emit('delete-band', {'id': band.id}),
    );
  }

  addNewBand() {
    final textController = new TextEditingController();

    if ( Platform.isAndroid ) {
      return showDialog(
        builder: (_) => AlertDialog(
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
        ),
        context: context, 
      );
    }

    showCupertinoDialog(
      builder: (_) => CupertinoAlertDialog(
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
      ),
      context: context, 
    );

  }

  void addBandToList( String name ) {
    if ( name.length > 1 ) {
      final socketService = Provider.of<SocketService>(context,listen: false);

      socketService.socket.emit('add-band', {'name': name});
    }

    Navigator.pop(context);
  }

  Widget _showGraph() {
    Map<String, double> dataMap = new Map();

    this.bands.forEach((band) {
      dataMap.putIfAbsent(band.name, () => band.votes!.toDouble() );
    });

    final List<Color> colorList = [
      Colors.blue[50]!,
      Colors.blue[200]!,
      Colors.pink[50]!,
      Colors.pink[200]!,
      Colors.yellow[50]!,
      Colors.yellow[200]!
    ];

    if ( bands.isEmpty )
      return Padding(
        padding: EdgeInsets.all(10),
        child: Text(
          'No hay bandas',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
        ),
      );

    return Container(
      child: PieChart(
        animationDuration: Duration( milliseconds: 800 ),
        centerText: 'HYBRID',
        chartLegendSpacing: 32.0,
        chartRadius: MediaQuery.of(context).size.width / 3.2,
        chartType: ChartType.ring,
        chartValuesOptions: ChartValuesOptions(
          chartValueBackgroundColor: Colors.grey[200],
          chartValueStyle: defaultChartValueStyle.copyWith(
            color: Colors.blueGrey[900]!.withOpacity(0.9)
          ),
          decimalPlaces: 1,
          showChartValues: true,
          showChartValueBackground: true,
          showChartValuesInPercentage: true,
          showChartValuesOutside: true
        ),
        colorList: colorList,
        dataMap: dataMap,
        initialAngleInDegree: 0,
        legendOptions: LegendOptions(
          legendPosition: LegendPosition.right,
          legendShape: BoxShape.circle,
          legendTextStyle: TextStyle(
            fontWeight: FontWeight.bold
          ),
          showLegends: true,
          showLegendsInRow: false
        ),
        ringStrokeWidth: 12,
      ),
      height: 200,
      padding: EdgeInsets.only( top: 10 ),
      width: double.infinity,
    );
  }
}
