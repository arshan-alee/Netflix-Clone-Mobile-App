import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Entry {
  final String name;
  final String description;

  Entry({required this.name, required this.description});
}

class WatchListProvider {
  List<Entry> watchlist = [
    Entry(name: "Movie 1", description: "Description for Movie 1"),
    Entry(name: "Movie 2", description: "Description for Movie 2"),
    Entry(name: "Movie 3", description: "Description for Movie 3"),
  ];

  Future<List<Entry>> list() async {
    await Future.delayed(Duration(seconds: 2)); // Simulate loading delay
    return watchlist;
  }

  void remove(Entry entry) {
    watchlist.remove(entry);
  }
}

class EntryProvider {
  Future<Uint8List> imageFor(Entry entry) async {
    await Future.delayed(Duration(seconds: 2)); // Simulate loading delay
    // You can return a placeholder image or null here for simplicity
    return Uint8List(0);
  }
}

class WatchlistScreen extends StatefulWidget {
  const WatchlistScreen({Key? key}) : super(key: key);

  @override
  _WatchlistScreenState createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _row(Entry entry) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.blueGrey, // Placeholder color
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              entry.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              (entry.description ?? "").substring(0, 50) + "...",
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        )),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 30, 20),
          child: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              context.read<WatchListProvider>().remove(entry);
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Watchlist'),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Entry>>(
        future: context.read<WatchListProvider>().list(),
        builder: (context, snapshot) {
          return snapshot.hasData == false || snapshot.data == null
              ? const Padding(
                  padding: EdgeInsets.all(60),
                  child: Center(child: CircularProgressIndicator()))
              : ListView(
                  children: snapshot.data!
                      .map(
                        (entry) => GestureDetector(
                          child: _row(entry),
                          onTap: () async {
                            await showDialog(
                              context: context,
                              builder: (context) => DetailsScreen(entry: entry),
                            );
                          },
                        ),
                      )
                      .toList(),
                );
        },
      ),
    );
  }
}

class DetailsScreen extends StatelessWidget {
  final Entry entry;

  const DetailsScreen({required this.entry});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(entry.name),
      content: Text(entry.description),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Close'),
        ),
      ],
    );
  }
}
