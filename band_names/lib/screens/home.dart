import 'package:flutter/material.dart';

/// Models
import 'package:band_names/models/band.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Band> bands = [
    Band(id: '1', name: 'Metallica', votes: 5),
    Band(id: '2', name: 'Queen', votes: 1),
    Band(id: '3', name: 'Héroes del Silencio', votes: 2),
    Band(id: '4', name: 'Bon Jovi', votes: 5),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 1,
        title: const Text('BandNames', style: TextStyle(color: Colors.black87))
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int i) => _bandTile(bands[i]),
        itemCount: bands.length
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 1,
        onPressed: () {},
        child: const Icon(Icons.add)
      ),
    );
  }

  ListTile _bandTile(Band band) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.blue[100],
        child: Text(band.name.substring(0, 2)),
      ),
      onTap: () {
        print(band.name);
      },
      title: Text(band.name),
      trailing: Text('${band.votes}', style: const TextStyle(fontSize: 20)),
    );
  }
}
