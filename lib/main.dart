import 'package:flutter/material.dart';
import 'package:flutter_application_1/counter.dart';
import 'package:flutter_application_1/hearthstone.dart';
import 'package:flutter_application_1/http.dart';

//flutter build apk --release 
void main() => runApp(const MyApp());
// void main() => fetchSummary();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Demo Home Page'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const CounterPage())), child: const Text('Counter')),
              ElevatedButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const HttpPage())), child: const Text('Http')),
              ElevatedButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const HearthstonePage())), child: const Text('Hearthstone'))
            ],
          ),
        ),
      );
  }
}


