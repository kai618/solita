import 'package:flutter/material.dart';
import 'package:solitaire/screens/play_screen.dart';

class MenuScreen extends StatelessWidget {
  static const screenName = 'menu-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("------------------");
          Navigator.of(context).pushReplacementNamed(PlayScreen.screenName);
        },
      ),
    );
  }
}
