import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HearthstonePage extends StatefulWidget {
  const HearthstonePage({super.key});

  @override
  State<HearthstonePage> createState() => _HearthstonePageState();
}

class _HearthstonePageState extends State<HearthstonePage> {
  Future<CollectionData>? futureCollection;

  void _loadData() {
    setState(() {
      futureCollection = fetchCollection();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('This is hearthstone screen'),
      ),
      body: Center(
        child: FutureBuilder<CollectionData>(
          future: futureCollection,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
               return ListView.builder(
                itemCount: snapshot.data!.collection.length,
                itemBuilder: (context, index) {
                  var collection = snapshot.data!.collection;
                  var entry = collection[index];

                  return ListTile(
                    title: Text(
                      entry.cardId,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    subtitle: Text(entry.values.toString()),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(); 
            }

            // By default, show a loading spinner.
            return const Text('');
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _loadData,
        tooltip: 'Increment',
        child: const Icon(Icons.restore),
      ),
    );
  }
}

Future<CollectionData> fetchCollection() async {
  final response = await http
      .get(Uri.parse(
        'https://hsreplay.net/api/v1/collection/?region=2&account_lo=145926188&type=CONSTRUCTED'),
        headers: {
          "cookie": "sessionid=349urrtf4suoy4g5kfds8sqbpf8t4ndn", 
        });

  if (response.statusCode == 200) {
    var json = jsonDecode(response.body) as Map<String, dynamic>;
    return CollectionData.fromJson(json);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Entry{
  final String cardId;
  final List<int> values;

  Entry({required this.cardId, required this.values});
}

class CollectionData {
  final List<Entry> collection;

  CollectionData({required this.collection});

  factory CollectionData.fromJson(Map<String, dynamic> json) {
    List<Entry> parsedCollection = [];

    // Iterate over the "collection" map in the JSON
    json['collection'].forEach((key, value) {
      // Ensure the value is a list and cast its elements to integers
      if (value is List) {
        parsedCollection.add(Entry(cardId: key, values: value.cast<int>()));
      }
    });

    return CollectionData(collection: parsedCollection);
  }
}