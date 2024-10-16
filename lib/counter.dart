import 'package:flutter/material.dart';
import 'package:flutter_application_1/http.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({
    super.key,
  });

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int _counter = 0;

  void onPressedDecr() => setState(() {
        _counter--;
      });

  void onPressedIncr() => setState(() {
        _counter++;
      });
  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
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
              child: const Text("Second screen"),
              onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const HttpPage()));
              }, )
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

