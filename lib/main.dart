import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:solitaire/screens/menu_screen.dart';
import 'package:solitaire/screens/play_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );
  SystemChrome.setEnabledSystemUIOverlays([]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Klondike Solitaire
      title: 'Solita',
      theme: ThemeData(primarySwatch: Colors.green),
      initialRoute: "/",
      routes: {
        "/": (context) => PlayScreen(),
        MenuScreen.screenName: (context) => MenuScreen(),
        PlayScreen.screenName: (context) => PlayScreen(),
      },
    );
  }
}
