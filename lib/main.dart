import 'package:flutter/material.dart';
import 'package:solitaire/utils/round_handler.dart';

void main() {
  RoundHandler roundHandler = RoundHandler();
  roundHandler.initDeck();
  print(roundHandler.cardColumn2[0]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Hi")),
    );
  }
}
