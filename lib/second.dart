import 'package:flutter/material.dart';


class SecondScreen extends StatefulWidget{
  const SecondScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('This is second screen'),
      ),
    );
  }
}
