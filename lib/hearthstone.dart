
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Data/collection.dart';

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
  void initState() {
    super.initState();
    futureCollection = fetchCollection();
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

