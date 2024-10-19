import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/http.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';


class CounterPage extends StatefulWidget {
  const CounterPage({
    super.key,
  });

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int _counter = 0;
  final cacheManager = DefaultCacheManager();
  final cacheKey = 'exampleData';

  void onPressedDecr() => setState(() {
        _counter--;
      });

  void onPressedIncr() => setState(() {
        _counter++;
      });
  void _resetCounter() {
    cacheManager.removeFile(cacheKey);
    setState(() {
      _counter = 0;
    });
  }

  @override
  void initState(){
    super.initState();
    loadValue();
  }

  Future<void> loadValue() async {
    var fileInfo = await cacheManager.getFileFromCache(cacheKey);
    if (fileInfo != null) {
      final cachedData = await fileInfo.file.readAsString();
      final exampleModel = Counter.fromJson(jsonDecode(cachedData));
      setState(() {
      _counter = exampleModel.value;
    });
      int a = 5;
    }
  }

  _saveState() async {
    var c = Counter(value: _counter);
    await cacheManager.putFile(
        cacheKey,
        utf8.encode(jsonEncode(c)),
        fileExtension: 'json',
      );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counters'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: onPressedDecr, child: const Text("decrement")),
                ElevatedButton(
                    onPressed: onPressedIncr, child: const Text("increment")),
              ],
            ),
            ElevatedButton(
              onPressed: () => _saveState(),
              child: const Text("Save state"))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _resetCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.restore),
      ),
    );
  }
  
}

class Counter {
  final int value;

  Counter({required this.value});

  Counter.fromJson(Map<String, dynamic> json)
      : value = json['value'] as int;

  Map<String, dynamic> toJson() => {
        'value': value,
      };
}