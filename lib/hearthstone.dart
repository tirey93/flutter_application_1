
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Data/card.dart';
import 'package:flutter_application_1/Data/collection.dart';

class HearthstonePage extends StatefulWidget {
  const HearthstonePage({super.key});

  @override
  State<HearthstonePage> createState() => _HearthstonePageState();
}

class _HearthstonePageState extends State<HearthstonePage> {
  Future<CardsData>? futureCollection;

  void _loadData() {
    setState(() {
      futureCollection = fetchCards();
    });
  }

  @override
  void initState() {
    super.initState();
    futureCollection = fetchCards();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('This is hearthstone screen'),
      ),
      body: Center(
        child: FutureBuilder<CardsData>(
          future: futureCollection,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(); 
            }
            else if (snapshot.hasData) {
               return ListView.builder(
                itemCount: snapshot.data!.cards.length,
                itemBuilder: (context, index) {
                  var collection = snapshot.data!.cards;
                  var entry = collection[index];

                  return ListTile(
                    title: Text(
                      entry.dbfId,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    subtitle: Text('${entry.set} ${entry.rarity} n:${entry.normalCollectible.toString()} g: ${entry.goldenCollectible.toString()}'),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            return const Text('');
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _loadData,
        tooltip: 'Refresh',
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

